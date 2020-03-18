package stx.core.pack;

import stx.core.pack.error_code.term.*;

@:allow(stx.core.pack.error_code.term)
enum abstract ErrorCode(Int){
  private function new(self) this = self;
  public function prj():Int{
    return this;
  }
  static public inline function inj() return Constructor.ZERO;
}

private class Constructor extends Clazz{
  static public var ZERO (default,never) = new Constructor();
  public function five_hundred():ErrorCode{
    return new FiveHundred();
  }
}