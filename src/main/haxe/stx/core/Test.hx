package stx.core;

import haxe.unit.TestCase;

import stx.core.test.*;

class Test extends Clazz{
  public function deliver():Array<TestCase>{
    return [
      new EnumAbstractTest()
    ];
  }
}