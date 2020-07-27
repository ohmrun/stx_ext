package stx.ext.lift;
class LiftErrToChunk{
  static public function toChunk<T,E>(err:Err<E>):Chunk<T,E>{
    return stx.ext.Chunk.fromError(err);
  }
}