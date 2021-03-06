package stx.ext;

#if tink_state
  import tink.state.Promised;
#end

typedef ContractDef<T,E> = Future<Chunk<T,E>>; 

@:using(stx.ext.Contract.ContractLift)
abstract Contract<T,E>(ContractDef<T,E>) from ContractDef<T,E>{
  static public var _(default,never) = ContractLift;

  public function new(v:Future<Chunk<T,E>>) this = v;

  @:noUsing static public function lift<T,E>(self:Future<Chunk<T,E>>){
    return new Contract(self);
  }
  @:noUsing static public function unit<T,E>():Contract<T,E>{
    return Contract.pure(Tap);
  }
  @:noUsing static public function pure<T,E>(ch:Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(ch)
    ); 
  }
  @:noUsing static public function bind_fold<T,Ti,E>(it:Array<T>,start:Ti,fm:Ti->T->Contract<Ti,E>):Contract<Ti,E>{
    return new Contract(__.core().Future().bind_fold(
      it,
      function(next:T,memo:Chunk<Ti,E>):Future<Chunk<Ti,E>>{
        return switch (memo){
          case Tap      : unit().prj();
          case Val(v)   : fm(v,next).prj();
          case End(err) : end(err).prj();
        }
      },
      Val(start)
    ));
  }
  @:noUsing static public function lazy<T,E>(fn:Void->T):Contract<T,E>{
    return lift(Future.irreversible(
      (f) -> f(Val(fn()))
    ));
  }
  @:noUsing static public function fromLazyError<T,E>(fn:Void->Err<E>):Contract<T,E>{
    return fromLazyChunk(
      () -> End(fn())
    );
  }
  @:noUsing static public function fromLazyChunk<T,E>(fn:Void->Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (f) -> f(fn())
    );
  }

  @:noUsing static public function end<T,E>(?e:Err<E>):Contract<T,E>{
    return pure(End(e));
  }
  @:noUsing static public function tap<T,E>():Contract<T,E>{
    return unit();
  }
  @:noUsing static public function fromChunk<T,E>(chk:Chunk<T,E>):Contract<T,E>{
    return Future.irreversible(
      (cb) -> cb(
        chk
      )
    );
  }
  @:noUsing static public function fromOption<T,E>(m:Option<T>):Contract<T,E>{
    final val = m.fold((x)->Val(x),()->Tap);
    return fromChunk(val);
  }
  public function prj():Future<Chunk<T,E>> return this;
}

class ContractLift extends Clazz{
  static private function lift<T,E>(self:Future<Chunk<T,E>>):Contract<T,E>{
    return Contract.lift(self);
  }
  static public function zip<Ti,Tii,E>(self:Contract<Ti,E>,that:Contract<Tii,E>):Contract<Couple<Ti,Tii>,E>{
    var out = LiftFuture.zip(self.prj(),that.prj()).map(
      (tp) -> tp.fst().zip(tp.snd())
    );
    return out;
  }
  
  static public function map<T,Ti,E>(self:Contract<T,E>,fn:T->Ti):Contract<Ti,E>{
    return lift(self.prj().map(
      function(x){
        return switch (x){
          case Tap      : Tap;
          case Val(v)   : Val(fn(v));
          case End(err) : End(err);
    }}));
  }
  static public function flat_map<T,Ti,E>(self:Contract<T,E>,fn:T->Contract<Ti,E>):Contract<Ti,E>{
    var ft : Future<Chunk<T,E>> = self.prj();
    return ft.flatMap(
      function(x:Chunk<T,E>):ContractDef<Ti,E>{
        return switch (x){
          case Tap      : new Contract(Future.sync(Tap)).prj();
          case Val(v)   : fn(v).prj();
          case End(err) : Contract.fromChunk(End(err)).prj();
    }});
  }
  static public function fold<T,Ti,E>(self:Contract<T,E>,val:T->Ti,ers:Null<Err<E>>->Ti,nil:Void->Ti):Future<Ti>{
    return self.prj().map(Chunk._.fold.bind(_,val,ers,nil));
  }
  static public function recover<T,E>(self:Contract<T,E>,fn:Err<E>->Chunk<T,E>):Contract<T,E>{
    return lift(fold(
      self,
      (x) -> Val(x),
      (e) -> fn(e),
      ()  -> Tap
    ));
  }
  static public function attempt<T,Ti,E,U>(self:Contract<T,E>,fn:T->Chunk<Ti,E>):Contract<Ti,E>{
    return lift(fold(
      self,
      (x) -> fn(x),
      (v) -> End(v),
      ()->Tap
    ));
  }
  static public function receive<T,E>(self:Contract<T,E>,fn:T->Void):Future<Option<Err<E>>>{
    return self.prj().map(
      (chk) -> switch chk {
        case End(e)   : __.option(e);
        case Val(v)   : fn(v); None;
        case Tap      : None;
      }
    );
  }
  static public function now<T,E>(self:Contract<T,E>):Chunk<T,E>{
    var out = null;
    self.prj().handle(
      (v) -> out = v
    );
    if(out == null){
      out = Tap;
    }
    return out;
  }
  static public function errata<T,E,EE>(fn:Err<E>->Err<EE>,self:Contract<T,E>):Contract<T,EE>{
    return self.prj().map(
      (chk) -> chk.errata(fn)
    );
  }
}