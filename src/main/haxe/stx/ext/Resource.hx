package stx.ext;

import haxe.Json;
import haxe.io.Bytes;

abstract Resource(StdString){
  static public function exists(str:String){
    return haxe.Resource.listNames().exists(
      (x:String) -> x == str
    );
  }
  public inline function new(str:String,?pos:Pos){
    if(!exists(str)){
      __.report(__.fault(pos).of(E_ResourceNotFound,str));
    }
    this = str;
  }
  public function string():StdString{
    return haxe.Resource.getString(this);
  }
  public function bytes():Bytes{
    return haxe.Resource.getBytes(this);
  }
  public function json():Any{
    return Json.parse(string());
  }
}