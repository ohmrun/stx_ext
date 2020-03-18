package stx.core.pack;

import haxe.Constraints;

import stx.core.pack.iter.Constructor;

@:forward abstract Iter<T>(Iterable<T>) from Iterable<T>{
  static public inline function _() return Constructor.ZERO;

  public function new(self) this = self;

  public function toMap<K,V>(fn:T->Tuple<K,V>,unit:IMap<K,V>):IMap<K,V> return _()._.toMap(this,fn,unit);
  public function map<U>(fn:T->U):Iter<U>                               return _()._.map(this,fn);

  public function cross<U>(that:Iter<U>):Iter<Tuple<T,U>>               return _()._.cross(this,that.prj());
  
  public function toArray():Array<T>                                    return Lambda.array(this);
  
  public function toGenerator():Void->Option<T>                         return _()._.toGenerator(this);
  public function lfold<Z>(fn:T->Z->Z,init:Z):Z                         return _()._.lfold(this,fn,init);
  
  public function prj():Iterable<T>{
    return this;
  }
}