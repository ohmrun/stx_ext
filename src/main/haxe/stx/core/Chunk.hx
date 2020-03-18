package stx.core;

import stx.core.chunk.Constructor;

abstract Chunk<T,E>(ChunkSum<T,E>) from ChunkSum<T,E> to ChunkSum<T,E>{
  static public inline function _() return Constructor.ZERO;

  public function new(self:ChunkSum<T,E>) this = self;

  @:noUsing static public function lift<T,E>(v:ChunkSum<T,E>):Chunk<T,E>                      return new Chunk(v);
  @:noUsing static public function pure<T,E>(v:T):Chunk<T,E>                                  return _().pure(v);
  @:noUsing static public function fromTinkOutcome<T,E>(outcome:TinkOutcome<T,Err<E>>)        return _().fromTinkOutcome(outcome);

  @:from @:noUsing static public function fromError<T,E>(e:Err<E>):Chunk<T,E>    return End(e);
  @:from @:noUsing static public function fromNull_T<T,E>(v:Null<T>):Chunk<T,E>         return _().pure(v);
  @:from @:noUsing static public function fromOption<T,E>(opt:Option<T>):Chunk<T,E>     return _().fromOption(opt);

  
    
  
  
  public function fold<Z>(val:T->Z,ers:Null<Err<E>>->Z,Tap:Void->Z):Z                   return _()._.fold(val,ers,Tap,self);
  public function opt_else<Z>(_if:T->Z,_else:Option<Err<E>>->Z):Z                       return _()._.opt_else(_if,_else,self);
  public function map<U>(fn:T->U):Chunk<U,E>                                            return _()._.map(fn,self);
  public function flat_map<U>(fn:T->Chunk<U,E>):Chunk<U,E>                              return _()._.flat_map(fn,self);
  public function recover<E0>(fn:Err<E> -> Chunk<T,E0> ):Chunk<T,E0>                    return _()._.recover(fn,self);
  public function zip<U>(that:Chunk<U,E>):Chunk<Tuple<T,U>,E>                           return _()._.zip(that,self);
  public function def(v:Void->T):T                                                      return _()._.def(v,self);
  public function is_defined():Bool                                                     return _()._.is_defined(self);
  public function elide<U>():Chunk<U,E>                                                 return cast self;
  public function iterator():Iterator<T>                                                return _()._.iterator(self);
  public function array():Array<T>                                                      return Lambda.array({ iterator : iterator });
  public function errata<EE>(fn:Err<E>->Err<EE>):Chunk<T,EE>                            return _()._.errata(fn,self);

  private var self(get,never):Chunk<T,E>;
  private function get_self():Chunk<T,E> return this;
}