package stx.core.pack;

import stx.core.pack.contract.Constructor;
#if tink_state
  import tink.state.Promised;
#end

abstract Contract<T,E>(ContractDef<T,E>) from ContractDef<T,E>{
  static public inline function _() return Constructor.ZERO;

  public function new(v:Future<Chunk<T,E>>) this = v;

  @:noUsing static public function unit<T,E>():Contract<T,E>                                        return _().unit();
  @:noUsing static public function pure<T,E>(ch:Chunk<T,E>)                                         return _().pure(ch);

  @:noUsing static public function trigger<T,E>():ContractTrigger<T,E>                              return new ContractTrigger();

  @:from @:noUsing static public function fromLazyError<T,E>(fn:Void->Err<E>):Contract<T,E>         return _().fromLazyError(fn);
  @:from @:noUsing static public function fromLazyChunk<T,E>(fn:Void->Chunk<T,E>):Contract<T,E>     return _().fromLazyChunk(fn);
  @:from @:noUsing static public function lift<T,E>(ft:Future<Chunk<T,E>>)                          return new Contract(ft);
  @:from @:noUsing static public function fromChunk<A,E>(chk:Chunk<A,E>):Contract<A,E>              return _().fromChunk(chk);
  @:from @:noUsing static public function fromOption<A,E>(m:Option<A>):Contract<A,E>                return _().fromOption(m);

  

  
  public function map<U>(fn:T->U):Contract<U,E>                                             return _()._.map(fn,this);  
  public function flat_map<U>(fn:T->Contract<U,E>):Contract<U,E>                            return _()._.flat_map(fn,this);
  public function recover(fn:Err<E>->Chunk<T,E>):Contract<T,E>                              return _()._.recover(fn,this);
  public function attempt<U>(fn:T->Chunk<U,E>):Contract<U,E>                                return _()._.attempt(fn,this);
  public function fold<Z>(pure:T->Z,err:Null<Err<E>>->Z,unit:Void->Z):Future<Z>             return _()._.fold(pure,err,unit,this);
  public function receive(fn:T->Void):Future<Option<Err<E>>>                                return _()._.receive(fn,this);
  public function zip<U>(that:Contract<U,E>):Contract<Tuple<T,U>,E>                         return _()._.zip(that,this);
  
  
  public function now():Chunk<T,E>                                                          return _()._.now(this);
  public function errata<E0>(fn:Err<E>->Err<E0>):Contract<T,E0>                             return _()._.errata(fn,this);


  public function prj():Future<Chunk<T,E>> return this;
}