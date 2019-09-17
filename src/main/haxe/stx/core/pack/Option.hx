package stx.core.pack;

import stx.core.body.Options;

@:using(stx.core.body.Options)
abstract Option<T>(haxe.ds.Option<T>) from haxe.ds.Option<T>{
  public function new(self) this = self;
  @:noUsing @:from static public function fromNullT<T>(v:Null<T>):Option<T>{
    return Options.option(v);
  }  
  public function map<U>(fn:T->U):Option<U>{
    return Options.map(this,fn);
  }
  public function fmap<U>(fn:T->Option<U>){
    return Options.fmap(this,fn);
  }
  public function or(thk):Option<T>{
    return Options.or(this,thk);
  }
  public function zip<U>(that:Option<U>):Option<Tuple2<T,U>>{
    return Options.zip(this,that);
  }
  public function filter(fn){
    return Options.filter(this,fn);
  }
  public function def(f){
    return Options.def(this,f);
  }
  public function defined(){
    return this != None;
  }
  public function wfold<U>(ok:T->U,no:Void->U):U{
    return Options.wfold(this,ok,no);
  }

}