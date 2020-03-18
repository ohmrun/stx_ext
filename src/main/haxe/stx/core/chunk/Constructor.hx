package stx.core.chunk;

class Constructor extends Clazz{
  static  public var ZERO(default,never)  = new Constructor();
          public var _(default,never)     = new Destructure();

  public function pure<T,E>(c:Null<T>):Chunk<T,E>{
    return switch(c){
      case null : Tap;
      default   : Val(c);
    }
  }
    
  /**
		Produces a `Chunk` of `Array<A>` only if all chunks are defined.
	**/
  public function all<T,E>(arr:Array<Chunk<T,E>>,?TapFail:Err<E>):Chunk<Array<T>,E>{
    return arr.fold(
        function(next,memo:Chunk<Array<T>,E>){
          return switch ([memo,next]) {
            case [Val(memo),Val(next)]  :
              memo.push(next);
              Val(memo);
            case [Val(memo),End(e)]     : End(e);
            case [Val(v),Tap]           : TapFail == null ? Tap : End(TapFail);
            case [End(e),End(e0)]       : 
                var err = 
                  __.option(e).array()
                    .concat(__.option(e0).array())
                    .fold(
                      (nx,mm:Err<E>) -> mm.next(nx),
                      TapFail
                    );
                End(err);
            case [End(e),Tap]           : 
                var err = __.option(e).map(e->e.next(TapFail)).defv(TapFail);
                End(err);
            case [End(e),_]             : End(e);
            case _                      : TapFail == null ? Tap : End(TapFail);
          }
        },
        Val([])
      );
  }
  public function available<T,E>(rest:Array<Chunk<T,E>>):Chunk<Array<T>,E>{
    return rest.fold(
      function(next,memo:Chunk<Array<T>,E>){
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
  public function fromTinkOutcome<T,E>(outcome:TinkOutcome<T,Err<E>>):Chunk<T,E>{
    return new Chunk(switch(outcome){
      case TinkOutcome.Success(v) : pure(v);
      case TinkOutcome.Failure(e) : End(e);
    });
  }
  public function fromOption<T,E>(opt:Option<T>):Chunk<T,E>{
    return switch(opt){
      case Some(v)  : Val(v);
      case None     : Tap; 
    }
  }
  public function fromOptionError<E>(opt:Option<Err<E>>):Chunk<Noise,E>{
    return switch(opt){
      case Some(v)  : End(v);
      case None     : Tap; 
    }
  }
}