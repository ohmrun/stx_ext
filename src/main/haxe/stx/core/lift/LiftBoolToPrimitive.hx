package stx.core.lift;
class LiftBoolToPrimitive{
  static public function toPrimitive(b:Bool):Primitive{
    return PBool(b);
  }
}