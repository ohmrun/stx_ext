package stx.core.lift;
class LiftCoupleToField{
  static public function toField<T>(tp:Couple<String,T>):Field<T>{
    return tp;
  }
}