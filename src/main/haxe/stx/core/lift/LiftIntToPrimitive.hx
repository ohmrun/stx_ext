package stx.core.lift;
class LiftIntToPrimitive{
  static public function toPrimitive(i:Int):Primitive{
    return PInt(i);
  }
}