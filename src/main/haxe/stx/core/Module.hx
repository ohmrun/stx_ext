package stx.core;

using Lambda;

class Module{
  public function new(){}
  public function Future(){
    return new Ft();
  }
  public function Map(){
    return new Map();
  }
}
private class Ft extends Clazz{
  public function bind_fold<T,TT>(arr:Array<T>,fn:T->TT->Future<TT>,init:Future<TT>):Future<TT>{
    return arr.fold(
      (next,memo:Future<TT>) -> memo.flatMap(
        (tt) -> fn(next,tt)
      ),
      init
    );
  }
}
private class Map extends Clazz{
  public function String<T>():StdMap<String,T>{
    return new StdMap();
  }
}