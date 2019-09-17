package stx.core.head.data;

import Type;
/**
  Normalized Types from Input/Output
*/
enum Primitive{
  PNull;
  PBool(b:Bool);
  PInt(int:Int);
  PFloat(fl:Float);
  PString(str:std.String);
}
