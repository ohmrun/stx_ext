package stx.core.lift;

class LiftTupleInto{
  static public function into2<P0,P1,R>(_:Wildcard,fn:P0->P1->R):Tuple<P0,P1>->R{
    return (tp) -> fn(tp.fst(),tp.snd());
  }
}