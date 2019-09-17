package stx.core.head.data;

enum Failure<A>{
  Initial;
  Defined(v:A);
  Coupled(last:stx.core.pack.TypedError<A>,?v:Failure<A>);
}