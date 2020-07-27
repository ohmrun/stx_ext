package stx.ext;

import haxe.unit.TestCase;

import stx.ext.test.*;

class Test extends Clazz{
  public function deliver():Array<TestCase>{
    return [
      new EnumAbstractTest()
    ];
  }
}