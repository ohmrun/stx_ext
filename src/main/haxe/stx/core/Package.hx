package stx.core;

class Package{
   
}
typedef Futures         = stx.core.body.Futures;
typedef Vouch<T,E>      = stx.core.pack.Vouch<T,E>;

typedef Tuple2<L,R>     = stx.core.pack.Tuple2<L,R>;
typedef Chunk<T,E>      = stx.core.pack.Chunk<T,E>;

typedef Iterables       = stx.core.body.Iterables;
typedef Options         = stx.core.body.Options;
//typedef Strings         = stx.core.body.Strings;

typedef Embed<T>        = stx.core.pack.Embed<T>;
typedef Cell<T>         = stx.core.pack.Cell<T>;
typedef Generator<T>    = stx.core.pack.Generator<T>;
typedef Unfold<T,R>     = stx.core.pack.Unfold<T,R>;

typedef Option<T>       = stx.core.pack.Option<T>;
typedef Iter<T>         = stx.core.pack.Iter<T>;

typedef KV<K,V>         = stx.core.pack.KV<K,V>;
typedef KVs             = stx.core.body.KVs;
typedef Field<V>        = stx.core.pack.Field<V>;

typedef Timer           = stx.core.pack.Timer;

typedef Clazz           = stx.core.pack.Clazz;

typedef TypedError<T>   = stx.core.pack.TypedError<T>;
typedef Error           = stx.core.pack.Error;

typedef Failure<T>      = stx.core.pack.Failure<T>;
typedef Resource        = stx.core.pack.Resource;
typedef TimeStamp       = stx.core.pack.TimeStamp;
typedef LogicalClock    = stx.core.pack.LogicalClock;
typedef ErrorMsg        = stx.core.pack.ErrorMsg;
typedef Fault           = stx.core.pack.Fault;
typedef Primitive       = stx.core.pack.Primitive;
typedef Packet          = stx.core.pack.Packet;
typedef Ident           = stx.core.pack.Ident;

typedef Maybe<T>        = stx.core.pack.Maybe<T>;