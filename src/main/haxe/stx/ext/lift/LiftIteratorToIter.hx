package stx.ext.lift;
class LiftIteratorToIter{
  static public function toIter<T>(it:Iterator<T>):Iter<T>{
    return {
      iterator : () -> it
    };
  }
}