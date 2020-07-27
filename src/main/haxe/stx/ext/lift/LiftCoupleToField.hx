package stx.ext.lift;
class LiftCoupleToField{
  static public function toField<T>(tp:Couple<String,T>):Field<T>{
    return tp;
  }
}