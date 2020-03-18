package stx.core.lift;
class LiftIterOfFieldToStringMap{
  static public function toMap<V>(iter:Iter<Field<V>>):StringMap<V>{
    return Iter._()._.toMap(
      iter,
      (f) -> f.toTuple(),
      new StringMap()
    );
  }
}