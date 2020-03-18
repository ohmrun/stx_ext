package stx.core.lift;
class LiftTupleToField{
  static public function toField<T>(tp:Tuple<String,T>):Field<T>{
    return tp;
  }
}