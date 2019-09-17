package stx.core.pack;

import stx.core.head.data.Chunk in ChunkT;

import stx.core.pack.body.Chunks;

abstract Chunk<T,E>(ChunkT<T,E>) from ChunkT<T,E> to ChunkT<T,E>{

#if tink_state
  @:from static public function fromPromised<T>(p:Promised<T>):Chunk<T>{
    return Chunks.fromPromised(p);
  }
  @:to public function toPromised():Promised<T>{
    return Chunks.toPromised(this);
  }
#end
  @:noUsing static public function pure<T>(v:T):Chunk<T,Any>{
    return pure(v);
  }
  @:noUsing @:from static public function fromError<T>(e:Error):Chunk<T,Any>{
    return End(e);
  }
  @:noUsing @:from static public function fromNull_T<T>(v:Null<T>):Chunk<T,Any>{
    return Chunks.pure(v);
  }
  @:noUsing @:from static public function fromOption<T>(opt:Option<T>):Chunk<T,Any>{
    return switch(opt){
      case Some(v)  : Val(v);
      case None     : Tap; 
    }
  }
  public function new(v:ChunkT<T,E>){
    this = v;
  }
  public function sure(?err:TypedError<E>):T{
    return Chunks.sure(this,err);
  }
  public function fold<A,Z>(val:T->Z,ers:Null<TypedError<E>>->Z,Tap:Void->Z):Z{
    return Chunks.fold(this,val,ers,Tap);
  }
  public function map<U>(fn:T->U):Chunk<U,E>{
    return Chunks.map(this,fn);
  }
  public function fmap<U>(fn:T->Chunk<U,E>):Chunk<U,E>{
    return Chunks.fmap(this,fn);
  }
  public function recover(fn:TypedError<E> -> Chunk<T,E> ):Chunk<T,E>{
    return Chunks.recover(this,fn);
  }
  public function zipWith<U,V>(chunk1:Chunk<U,E>,fn:T->U->V):Chunk<V,E>{
    return Chunks.zipWith(this,chunk1,fn);
  }
  public function zip<U>(chunk1:ChunkT<U,E>):Chunk<Tuple2<T,U>,E>{
    return Chunks.zip(this,chunk1);
  }
  public function def(v:Void->T):T{
    return Chunks.def(this,v);
  }
  public function defined():Bool{
    return Chunks.defined(this);
  }
  public function elide<U>():Chunk<U,E>{
    return cast this;
  }
}