package stx.core.pack;

typedef OutcomeT<T,E> = Either<Err<E>,T>;

abstract Outcome<T,E>(OutcomeT<T,E>) from OutcomeT<T,E> to OutcomeT<T,E>{
  public function new(self) this = self;
  static public var inj(default,null) = new Constructor();

  static public function lift<T,E>(self:OutcomeT<T,E>):Outcome<T,E> return inj.lift(self);
  

  public function errata<EE>(fn:Err<E>->Err<EE>):Outcome<T,EE>  return inj._.errata(fn,self);
  public function map<TT>(fn:T->TT)                                           return inj._.map(fn,self);
  public function flat_map<TT>(fn:T->Outcome<TT,E>)                               return inj._.flat_map(fn,self);
  public function fold<Z>(fn:T->Z,er:Err<E>->Z):Z                      return inj._.fold(fn,er,self);
  public function zip<TT>(that:Outcome<TT,E>):Outcome<Tuple<T,TT>,E>         return inj._.zip(that,self);
  
  public function fudge():T                                                   return inj._.fudge(self);
  public function elide():Outcome<Dynamic,E>                                  return inj._.elide(this);

  public function prj():OutcomeT<T,E> return this;
  private var self(get,never):Outcome<T,E>;
  private function get_self():Outcome<T,E> return lift(this);
}
class Constructor extends Clazz {
  public var _ =  new Destructure();
  public function lift<T,E>(self:OutcomeT<T,E>):Outcome<T,E> return new Outcome(self);
  public function success<T,E>(t:T):Outcome<T,E>{
    return lift(Right(t));
  }
  public function failure<T,E>(e:Err<E>):Outcome<T,E>{
    return lift(Left(e));
  }
}
class Destructure extends Clazz{
  public function errata<T,E,EE>(fn:Err<E>->Err<EE>,self:Outcome<T,E>):Outcome<T,EE>{
    return Outcome.inj.lift(
      self.prj().fold(
        (e) -> Left(fn(e)),
        (t) -> Right(t)
      )
    );
  }
  public function map<T,E,TT>(fn:T->TT,self:Outcome<T,E>):Outcome<TT,E>{
    return flat_map(
      (x) -> Right(fn(x)),
      self
    );
  }
  public function flat_map<T,E,TT>(fn:T->Outcome<TT,E>,self:Outcome<T,E>):Outcome<TT,E>{
    return Outcome.inj.lift(
      self.prj().fold(
        (e) -> Left(e),
        (t) -> fn(t)
      )
    );
  }
  public function fold<T,E,Z>(fn:T->Z,er:Err<E>->Z,self:Outcome<T,E>):Z{
    return self.prj().fold(er,fn);
  }
  public function zip<T,TT,E>(that:Outcome<TT,E>,self:Outcome<T,E>):Outcome<Tuple<T,TT>,E>{
    return switch([self,that]){
      case [Left(e),Left(ee)]     : Left(e.next(ee));
      case [Left(e),_]            : Left(e);
      case [_,Left(e)]            : Left(e);
      case [Right(t),Right(tt)]   : Right(Tuple(t,tt));
    }
  }
  public function fudge<T,E>(self:Outcome<T,E>):T{
    return fold(
      (t) -> t,
      (e) -> throw(e),
      self
    );
  }
  public function elide<T,E>(self:Outcome<T,E>):Outcome<Dynamic,E>{
    return fold(
      (t) -> Left((t:Dynamic)),
      (e) -> Right(e),
      self
    );
  }
}