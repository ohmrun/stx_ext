package stx.core.pack.chunk;

class Destructure extends Clazz{
   public function def<T,E>(fn:Void->T,self:Chunk<T,E>):T{
     return switch(self){
       case Val(v)      : v;
       case End(e)      : throw e;
       case Tap         : fn();
     }
   }
  public function fold<T,E,Ti>(val:T->Ti,ers:Null<Err<E>>->Ti,tap:Void->Ti,chk:Chunk<T,E>):Ti{
    return switch (chk) {
      case Val(v) : val(v);
      case End(e) : ers(e);
      case Tap    : tap();
    }
  }
  public function map<T,Ti,E>(fn:T->Ti,self:Chunk<T,E>):Chunk<Ti,E>{
    return switch (self){
      case Tap      : Tap;
      case Val(v)   :
        var o = fn(v);
        Chunk.pure(o);
      case End(err) : End(err);
    }
  }
  public function flatten<T,E>(self:Chunk<Chunk<T,E>,E>):Chunk<T,E>{
    return flat_map(
      function(x:Chunk<T,E>){
        return x;
      },
      self
    );
  }
  /**
    Run a function with the content of the Chunk that produces another self,
    then flatten the result.
  */
  public function flat_map<T,Ti,E>(fn:T->Chunk<Ti,E>,self:Chunk<T,E>):Chunk<Ti,E>{
    return switch (self){
      case Tap      : Tap;
      case Val(v)   : fn(v);
      case End(err) : End(err);
    }
  }
  /*
    If the Chunk is in an Error state, recover using the handler `fn`
  */
  public function recover<T,E,EE>(fn:Err<E> -> Chunk<T,EE>,self:Chunk<T,E>):Chunk<T,EE>{
    return switch (self){
      case Tap      : Tap;
      case Val(v)   : Val(v);
      case End(err) : fn(err);
    }
  }
  public function errata<T,E,EE>(fn:Err<E> -> Err<EE>,self:Chunk<T,E>):Chunk<T,EE>{
    return recover(
      (x:Err<E>) -> return End(fn(x))
    ,self);
  }
  public function zip<T,Ti,E>(that:Chunk<Ti,E>,self:Chunk<T,E>):Chunk<Tuple<T,Ti>,E>{
    return switch (self){
      case Tap      : Tap;
      case Val(v)   :
        switch (that){
          case Tap      : Tap;
          case Val(v0)  : Val(__.tuple(v,v0).toTuple());
          case End(err) : End(err);
        }
      case End(err) :
        switch (that){
          case End(err0)  : End(
            err.next(err0)
          );
          default         : Tap;
        }
    }
  }
  @:deprecated
  public function valueOption<T,E>(chk:Chunk<T,E>):Option<T>{
    return switch (chk){
      case Tap      : None;
      case Val(v)   : Some(v);
      case End(_)   : None;
    }
  }
  public function is_defined<T,E>(self:Chunk<T,E>):Bool{
    return fold(
      (_) -> true,
      (_) -> false,
      ()  -> false,
      self
    );
  }
  public function opt_else<T,Ti,E>(_if:T->Ti,_else:Option<Err<E>>->Ti,self:Chunk<T,E>):Ti{
    return fold(
      _if,
      (e) -> _else(__.option(e)),
      ()  -> _else(None),
      self
    );
  }
  public function fudge<T,E>(?pos:Pos,self:Chunk<T,E>):Null<T>{
    return switch self{
      case End(null)  : throw "Value not found on force";null;
      case End(err)   : throw err;
      case Tap        : throw "Value not found on force";null;
      case Val(v)     : v;
      case null       : throw "no self to push on";
    }
  }
  public function iterator<T,E>(self:Chunk<T,E>):Iterator<T>{
    var done = false;
    return {
      hasNext : function(){
        return !done && new EnumValue(self).alike(new EnumValue(Val(null)));
      },
      next    : function(){
        done = true;
        return switch(self){
          case Val(v)   : v;
          default       : null;
        }
      }
    };
  }
}

/*
#if tink_state
 
  public function fromPromised<T>(p:Promised<T>):Chunk<T>{
    return switch(p){
      case Loading                  : Tap;
      case Done(result)             : Val(result);
      case Failed(err)              : Error.withData(err.code,err.message,err.data,err.pos);
    }
  }
  public function toPromised<T>(chk:Chunk<T>):Promised<T>{
    return switch(chk){
      case Tap        : Loading;
      case Val(v)     : Done(v);
      case End(err)   : Failed(err);
    }
  }
#end
*/