package stx.ext;

typedef PledgeDef<T,E> = Future<Res<T,E>>;

@:using(stx.ext.Pledge.PledgeLift)
@:forward abstract Pledge<T,E>(PledgeDef<T,E>) from PledgeDef<T,E> to PledgeDef<T,E>{
  static public var _(default,never) = PledgeLift;
  public function new(self) this = self;
  static public function lift<T,E>(self:PledgeDef<T,E>):Pledge<T,E> return new Pledge(self);

  @:noUsing static public function pure<T,E>(ch:Res<T,E>):Pledge<T,E>{
    return Future.irreversible(
      (f) -> f(ch)
    ); 
  }
  @:noUsing static public function bind_fold<T,Ti,E>(it:Array<T>,start:Ti,fm:Ti->T->Pledge<Ti,E>):Pledge<Ti,E>{
    return new Pledge(__.core().Future().bind_fold(
      it,
      function(next:T,memo:Res<Ti,E>):Future<Res<Ti,E>>{
        return memo.fold(
          (v) -> fm(v,next).prj(),
          (e) -> pure(__.reject(e))
        );
      },
      __.accept(start)
    ));
  }
  @:noUsing static public function lazy<T,E>(fn:Void->T):Pledge<T,E>{
    return lift(Future.irreversible(
      (f) -> f(__.accept(fn()))
    ));
  }
  @:noUsing static public function fromLazyError<T,E>(fn:Void->Err<E>):Pledge<T,E>{
    return fromLazyRes(
      () -> __.reject(fn())
    );
  }
  #if tink_core
  @:noUsing static public function fromTinkPromise<T,E>(promise:Promise<T>):Pledge<T,E>{
    return lift(
      promise.map(
        (outcome) -> switch(outcome){
          case tink.core.Outcome.Success(s) : __.accept(s);
          case tink.core.Outcome.Failure(f) : __.reject(Err.fromTinkError(f));
        }
      )
    );
  }
  #end
  @:noUsing static public function fromLazyRes<T,E>(fn:Void->Res<T,E>):Pledge<T,E>{
    return Future.irreversible(
      (f) -> f(fn())
    );
  }

  @:noUsing static public function err<T,E>(e:Err<E>):Pledge<T,E>{
    return pure(__.reject(e));
  }
  @:noUsing static public function fromRes<T,E>(chk:Res<T,E>):Pledge<T,E>{
    return Future.irreversible(
      (cb) -> cb(
        chk
      )
    );
  }
  @:noUsing static public function fromOption<T,E>(m:Option<T>):Pledge<T,E>{
    final val = m.fold((x)->__.accept(x),()->__.reject(__.fault().err(E_UnexpectedNullValueEncountered)));
    return fromRes(val);
  } 
  #if stx_arw
    public function toProduce(){
      return stx.arw.Produce.fromPledge(this);
    }
  #end
  public function prj():PledgeDef<T,E> return this;
  private var self(get,never):Pledge<T,E>;
  private function get_self():Pledge<T,E> return lift(this);
}
class PledgeLift{
  static private function lift<T,E>(self:Future<Res<T,E>>):Pledge<T,E>{
    return Pledge.lift(self);
  }
  static public function zip<Ti,Tii,E>(self:Pledge<Ti,E>,that:Pledge<Tii,E>):Pledge<Couple<Ti,Tii>,E>{
    var out = LiftFuture.zip(self.prj(),that.prj()).map(
      (tp) -> tp.fst().zip(tp.snd())
    );
    return out;
  }
  
  static public function map<T,Ti,E>(self:Pledge<T,E>,fn:T->Ti):Pledge<Ti,E>{
    return lift(self.prj().map(
      (x) -> x.fold(
        (s) -> __.accept(fn(s)),
        __.reject
      )
    ));
  }
  static public function flat_map<T,Ti,E>(self:Pledge<T,E>,fn:T->Pledge<Ti,E>):Pledge<Ti,E>{
    var ft : Future<Res<T,E>> = self.prj();
    return ft.flatMap(
      function(x:Res<T,E>):PledgeDef<Ti,E>{
        return x.fold(
          (v)   -> fn(v).prj(),
          (err) -> Pledge.fromRes(__.reject(err)).prj()
        );
      }
    );
  }
  static public function fold<T,Ti,E>(self:Pledge<T,E>,val:T->Ti,ers:Null<Err<E>>->Ti):Future<Ti>{
    return self.prj().map(Res._.fold.bind(_,val,ers));
  }
  static public function recover<T,E>(self:Pledge<T,E>,fn:Err<E>->Res<T,E>):Pledge<T,E>{
    return lift(fold(
      self,
      (x) -> __.accept(x),
      (e) -> fn(e)
    ));
  }
  static public function attempt<T,Ti,E,U>(self:Pledge<T,E>,fn:T->Res<Ti,E>):Pledge<Ti,E>{
    return lift(fold(
      self,
      (x) -> fn(x),
      (v) -> __.reject(v)
    ));
  }
  static public function receive<T,E>(self:Pledge<T,E>,fn:T->Void):Future<Option<Err<E>>>{
    return self.prj().map(
      (res) -> res.fold(
        (v) -> {
          fn(v);
          return None;
        },
        __.option
      )
    );
  }
  static public function now<T,E>(self:Pledge<T,E>):Res<T,E>{
    var out = null;
    self.prj().handle(
      (v) -> out = v
    );
    if(out == null){
      throw __.fault().err(E_ValueNotReady);
    }
    return out;
  }
  static public function errata<T,E,EE>(fn:Err<E>->Err<EE>,self:Contract<T,E>):Contract<T,EE>{
    return self.prj().map(
      (chk) -> chk.errata(fn)
    );
  }
}