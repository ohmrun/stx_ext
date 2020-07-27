package stx.ext.lift;

class LiftStringMapToIter{
  static public function toIter<V>(map:StringMap<V>):Iter<Field<V>>{
    return LiftMapToIter.toIter(map).map((x) -> new Field(x));
  }
}