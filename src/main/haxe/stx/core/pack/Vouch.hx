package stx.core.pack;

import stx.core.pack.body.Vouches;

#if tink_state
  import tink.state.Promised;
#end

import stx.core.head.data.Vouch in VouchT;

@:forward abstract Vouch<T,E>(VouchT<T,E>) from VouchT<T,E> to VouchT<T,E>{
  static public function unit<T,E>():Vouch<T,E>{
    return pure(Tap);
  }
  static public function pure<T,E>(ch:Chunk<T,E>){
    return Future.async(
      (f) -> f(ch)
    ); 
  }
  @:noUsing static public function end<T,E>(?e:TypedError<E>):Vouch<T,E>{
    return pure(End(e));
  } 
  @:noUsing static public function tap<T,E>():Vouch<T,E>{
    return unit();
  } 
  #if tink_state
    @:from static public function fromFuturePromised<T>(promised:Future<Promised<T>>):Vouch<T>{
      return promised.map(Chunks.fromPromised);
    }
    @:to function toFuturePromised():Future<Promised<T>>{
      return this.map(Chunks.toPromised);
    }
  #end

  @:noUsing @:from static public function fromFutureTChunk<T,E>(ft:Future<Chunk<T,E>>){
    return new Vouch(ft);
  }
  @:noUsing static public function sync<A,E>(v:Chunk<A,E>):Vouch<A,E>{
    return new Vouch(Future.sync(v));
  }
  @:noUsing @:from static public function fromChunk<A,E>(chk:Chunk<A,E>):Vouch<A,E>{
    return Future.sync(chk);
 }
  @:noUsing @:from static public function fromOption<A,E>(m:Option<A>):Vouch<A,E>{
    return new Vouch(Future.sync(switch(m){
      case Some(v) : Val(v);
      case None: Tap;
    }));
  }
  public function new(v){
    this = v;
  }
  public function fmap<U>(fn:T->Vouch<U,E>):Vouch<U,E>{
    return Vouches.fmap(this,fn);
  }
  public function recover(fn:Error->Chunk<T,E>):Vouch<T,E>{
    return fold(
      (x) -> Val(x),
      (e) -> fn(e),
      () -> Tap
    );
  }
  public function verify<U>(fn:T->Chunk<U,E>):Vouch<U,E>{
    return fold(
      (x) -> fn(x),
      (v) -> End(v),
      ()->Tap
    );
  }
  public function or(v:Void->T):Vouch<T,E>{
    return fold(
      (x) -> Val(x),
      (e) -> End(e),
      ()  -> Val(v())
    );
  }
  public function prj():Future<Chunk<T,E>>{
    return this;
  }
  public function fold<Z>(pure:T->Z,err:Null<TypedError<E>>->Z,unit:Void->Z):Future<Z>{
    return Vouches.fold(this,pure,err,unit);
  }
}