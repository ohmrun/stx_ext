package stx.core.pack;

import stx.core.head.data.Primitive in PrimitiveT;

abstract Primitive(PrimitiveT) from PrimitiveT to PrimitiveT{
  @:noUsing static public function fromInt(i:Int):Primitive{
    return PInt(i);
  }
  @:noUsing static public function fromFloat(i:Float):Primitive{
    return PFloat(i);
  }
  @:noUsing static public function fromString(i:String):Primitive{
    return PString(i);
  }
  @:noUsing static public function fromBool(i:Bool):Primitive{
    return PBool(i);
  }
  public function toAny():Any{
    return switch (this){
      case PString(str) : str;
      case PInt(int)    : int;
      case PFloat(fl)   : fl;
      case PBool(b)     : b;
      case PNull        : null;
    }
  }
  public function toString():String{
    return switch (this){
      case PString(str) : str;
      case PInt(int)    : '$int';
      case PFloat(fl)   : '$fl';
      case PBool(b)     : '$b';
      case PNull        : 'null';
    }
  }
  public function prj():PrimitiveT{
    return this;
  }
  static public function lt(l:Primitive,r:Primitive){
    return switch([l,r]){
      case [PString(str),PString(str0)] : str < str0;
      case [PInt(int),PInt(int0)]       : int < int0;
      case [PFloat(fl),PFloat(fl0)]     : fl < fl0;
      case [PBool(false),PBool(true)]   : true;
      case [PBool(_),PBool(_)]          : false;
      case [x,y]  :
        new EnumValue(x.prj()).index() < new EnumValue(y.prj()).index();
    }
  }
  static public function eq(l:Primitive,r:Primitive){
    return switch([l,r]){
      case [PNull,PNull]                : true;
      case [PString(str),PString(str0)] : str == str0;
      case [PInt(int),PInt(int0)]       : int == int0;
      case [PFloat(fl),PFloat(fl0)]     : fl == fl0;
      case [PBool(true),PBool(true)]    : true;
      case [PBool(false),PBool(false)]  : true;
      case [PBool(_),PBool(_)]          : false;
      default                           : false;
    }
  }
}