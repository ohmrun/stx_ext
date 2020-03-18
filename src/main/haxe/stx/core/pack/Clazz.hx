package stx.core.pack;

class Clazz{
  public function new(){}

  final public function identify(){
    return StdType.getClassName(clazz());
  }
  final public function clazz():Class<Dynamic> {
    return StdType.getClass(this);
  }
}