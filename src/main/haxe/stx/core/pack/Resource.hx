package stx.core.pack;

import haxe.Json;
import haxe.io.Bytes;

abstract Resource(String){
  public function new(str){
    if(!haxe.Resource.listNames().exists(
      (x) -> x == str
    )){
      __.fault().resource_not_found(str).throwSelf();
    }
    this = str;
  }
  public function string():String{
    return haxe.Resource.getString(this);
  }
  public function bytes():Bytes{
    return haxe.Resource.getBytes(this);
  }
  public function json():Any{
    return Json.parse(string());
  }
}