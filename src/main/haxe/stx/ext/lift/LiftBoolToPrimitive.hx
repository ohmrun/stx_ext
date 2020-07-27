package stx.ext.lift;
class LiftBoolToPrimitive{
  static public function toPrimitive(b:Bool):Primitive{
    return PBool(b);
  }
}