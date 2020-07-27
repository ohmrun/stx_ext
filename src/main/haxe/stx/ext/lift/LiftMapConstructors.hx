package stx.ext.lift;

class LiftMapConstructors{
  static public function term(cls:VBlock<haxe.ds.Map<Dynamic,Dynamic>>):LiftedMapConstructors{
    return new LiftedMapConstructors();
  }
}
private class LiftedMapConstructors extends Clazz{
  static public function String<T>():StdMap<String,T>{
    return new StdMap();
  }
}