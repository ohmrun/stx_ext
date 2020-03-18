package stx.core.lift;
class LiftTinkOutcomeToChunk{
  static public function core<T,E>(oc:TinkOutcome<T,Err<E>>):Chunk<T,E>{
    return Chunk.fromTinkOutcome(oc);
  }
}