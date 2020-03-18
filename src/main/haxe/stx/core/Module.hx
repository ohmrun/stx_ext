package stx.core;

using Lambda;

class Module{
  public function new(){}
  public function declare<Subject,Verb,Object>(brand:Subject,media:Verb,union:Object){
    return Declare.make(brand,media,union);
  }  
  public function Future(){
    return new Ft();
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