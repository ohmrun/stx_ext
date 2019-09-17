package stx.core.pack.body;

class Chunks{
   static public function def<T,E>(self:Chunk<T,E>,fn:Void->T){
     return switch(self){
       case Val(v)      : v;
       case End(null)   : fn();
       case End(e)      : e.throwSelf();
       case Tap         : fn();
     }
   }
#if tink_state
 
  static public function fromPromised<T>(p:Promised<T>):Chunk<T>{
    return switch(p){
      case Loading                  : Tap;
      case Done(result)             : Val(result);
      case Failed(err)              : Error.withData(err.code,err.message,err.data,err.pos);
    }
  }
  static public function toPromised<T>(chk:Chunk<T>):Promised<T>{
    return switch(chk){
      case Tap        : Loading;
      case Val(v)     : Done(v);
      case End(err)   : Failed(err);
    }
  }
#end

  @:noUsing static public function pure<A,E>(?c:A):Chunk<A,E>{
    return (c == null) ? Tap : Val(c);
  }
  /**
		Produces a `Chunk` of `Array<A>` only if all chunks are defined.
	**/
  static public function all<A,E>(chks:Array<Chunk<A,E>>,?TapFail:TypedError<E>):Chunk<Array<A>,E>{
    return chks.fold(
        function(next,memo:Chunk<Array<A>,E>){
          return switch ([memo,next]) {
            case [Val(memo),Val(next)]  :
              memo.push(next);
              Val(memo);
            case [Val(memo),End(e)]     : End(e);
            case [Val(v),Tap]           : TapFail == null ? Tap : End(TapFail);
            case [End(e),End(e0)]       : End(Error.withData(500,'errors',[e,e0]));
            case [End(e),Tap]           : End(Error.withData(500,'errors',[e,TapFail]));
            case [End(e),_]             : End(e);
            case _                      : TapFail == null ? Tap : End(TapFail);
          }
        },
        Val([])
      );
  }
  static public function sure<A,E>(chk:Chunk<A,E>,?err:TypedError<E>):A{
    return switch (chk) {
      case Val(v) : v;
      case Tap    : throw err == null ? new Error(410,'Chunk undefined') : err;
      case End(e) : throw e;
    }
  }
  static public function fold<A,E,Z>(chk:Chunk<A,E>,val:A->Z,ers:Null<TypedError<E>>->Z,tap:Void->Z):Z{
    return switch (chk) {
      case Val(v) : val(v);
      case End(e) : ers(e);
      case Tap    : tap();
    }
  }
  static public function map<A,B,E>(chunk:Chunk<A,E>,fn:A->B):Chunk<B,E>{
    return switch (chunk){
      case Tap      : Tap;
      case Val(v)   :
        var o = fn(v);
        pure(o);
      case End(err) : End(err);
    }
  }
  static public function flatten<A,E>(chk:Chunk<Chunk<A,E>,E
  >):Chunk<A,E>{
    return fmap(chk,
      function(x:Chunk<A,E>){
        return x;
      }
    );
  }
  /**
    Run a function with the content of the Chunk that produces another chunk,
    then flatten the result.
  */
  static public function fmap<A,B,E>(chunk:Chunk<A,E>,fn:A->Chunk<B,E>):Chunk<B,E>{
    return switch (chunk){
      case Tap      : Tap;
      case Val(v)   : fn(v);
      case End(err) : End(err);
    }
  }
  /*
    If the Chunk is in an Error state, recover using the handler `fn`
  */
  static public function recover<A,B,E>(chunk:Chunk<A,E>,fn:TypedError<E> -> Chunk<A,E> ):Chunk<A,E>{
    return switch (chunk){
      case Tap      : Tap;
      case Val(v)   : Val(v);
      case End(err) : fn(err);
    }
  }
  /*

  */
  static public function zipWith<A,B,C,E>(chunk0:Chunk<A,E>,chunk1:Chunk<B,E>,fn:A->B->C):Chunk<C,E>{
    return switch (chunk0){
      case Tap      : Tap;
      case Val(v)   :
        switch (chunk1){
          case Tap      : Tap;
          case Val(v0)  : Chunks.pure(fn(v,v0));
          case End(err) : End(err);
        }
      case End(err) :
        switch (chunk1){
          case End(err0)  : End(
            err.next(err0)
          );
          default         : Tap;
        }
    }
  }
  static public function zip<A,B,E>(chunk0:Chunk<A,E>,chunk1:Chunk<B,E>):Chunk<Tuple2<A,B>,E>{
    return zipWith(chunk0,chunk1,tuple2);
  }
  static public function zipN<A,E>(rest:Array<Chunk<A,E>>):Chunk<Array<A>,E>{
    return rest.fold(
      function(next,memo:Chunk<Array<A>,E>){
        return switch (memo) {
          case Val(xs) : switch (next) {
            case Val(x) :
            xs.push(x);
            Val(xs);
            case Tap    : Val(xs);
            case End(e) : End(e);
          }
          default       : memo;
        }
      }
      ,Val([])
    );
  }
  static public function valueOption<A,E>(chk:Chunk<A,E>):Option<A>{
    return switch (chk){
      case Tap      : None;
      case Val(v)   : Some(v);
      case End(_)   : None;
    }
  }
  static public function defined<A,E>(chk:Chunk<A,E>):Bool{
    return fold(chk,
      function(x) return true,
      function(x) return false,
      function() return false
    );
  }
  static public function toChunk<T,E>(outcome:Outcome<T,TypedError<E>>):Chunk<T,E>{
    return switch(outcome){
      case Success(v) : Chunks.pure(v);
      case Failure(e) : End(e);
    }
  }
  static public function when<T,E>(fn:T->Void):Chunk<T,E> -> Void{
    return function(chk:Chunk<T,E>){
      switch(chk){
        case Val(v) : fn(v);
        default     : 
      }
    }
  }
}