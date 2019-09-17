package stx.core.head.data;

enum Chunk<V,E>{
  Val(v:V);
  Tap;
  End(?err:TypedError<E>);
}