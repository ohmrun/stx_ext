package stx.core.lift;
class LiftErrToChunk{
  static public function toChunk<T,E>(err:Err<E>):Chunk<T,E>{
    return stx.core.pack.Chunk.fromError(err);
  }
}