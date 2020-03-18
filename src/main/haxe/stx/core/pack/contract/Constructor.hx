package stx.core.pack.contract;

class Constructor extends Clazz{
  static  public var ZERO(default,never)   = new Constructor();
          public var _(default,null)       = new Destructure();

  public function unit<T,E>():Contract<T,E>{
    return Contract.pure(Tap);
  }
  public function pure<T,E>(ch:Chunk<T,E>):Contract<T,E>{
    return Future.async(
      (f) -> f(ch)
    ); 
  }
  public function bind_fold<T,Ti,E>(it:Array<T>,start:Ti,fm:Ti->T->Contract<Ti,E>):Contract<Ti,E>{
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
  public function lazy<T,E>(fn:Void->T):Contract<T,E>{
    return Future.async(
      (f) -> f(Val(fn()))
    );
  }
  public function fromLazyError<T,E>(fn:Void->Err<E>):Contract<T,E>{
    return fromLazyChunk(
      () -> End(fn())
    );
  }
  public function fromLazyChunk<T,E>(fn:Void->Chunk<T,E>):Contract<T,E>{
    return Future.async(
      (f) -> f(fn())
    );
  }

  @:noUsing public function end<T,E>(?e:Err<E>):Contract<T,E>{
    return pure(End(e));
  }
  @:noUsing public function tap<T,E>():Contract<T,E>{
    return unit();
  }
  @:noUsing public function fromChunk<T,E>(chk:Chunk<T,E>):Contract<T,E>{
    return Future.async(
      (cb) -> cb(
        chk
      )
    );
  }
  @:noUsing public function fromOption<T,E>(m:Option<T>):Contract<T,E>{
    final val = m.fold((x)->Val(x),()->Tap);
    return fromChunk(val);
  }
}