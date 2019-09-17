package stx.core.pack;

import haxe.Constraints;

import stx.core.body.Iterables;

@:forward abstract Iter<T>(Iterable<T>) from Iterable<T>{
  public function new(self) this = self;

  public function toMap<K,V>(fn:T->Tuple2<K,V>,unit:IMap<K,V>):IMap<K,V>{
    return Iterables.toMap(this,fn,unit);
  }
  public function map<U>(fn:T->U):Iter<U>{
    return Iterables.map(this,fn);
  }
  public function cross<U>(that:Iter<U>):Iter<Tuple2<T,U>>{
    return Iterables.cross(this,that.prj());
  }
  public function toArray():Array<T>{
    return Lambda.array(this);
  }
  public function prj():Iterable<T>{
    return this;
  }
}