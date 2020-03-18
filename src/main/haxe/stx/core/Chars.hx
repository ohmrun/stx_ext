package stx.core;

import stx.core.chars.Constructor;

@:using(stx.core.chars.Implementation)
@:forward abstract Chars(StdString) from StdString to StdString{
  private function new(self) this = self;

  public function char(int:Int):Char{
    return new Char(this.charAt(int));
  }
  @:op(A + A)
  public function add(that:Chars){
    return this + that;
  }
}