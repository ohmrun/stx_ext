package stx.core.type;

enum PrimitiveDef{
  PNull;
  PBool(b:Bool);
  PInt(int:Int);
  PFloat(fl:Float);
  PString(str:StdString);
}
