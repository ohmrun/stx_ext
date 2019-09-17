package stx.core.pack.body;

class Failures{
  static public function toEarliestArray<A>(f:Null<Failure<A>>,?stack):Array<A>{
    if(stack == null){
      stack = [];
    }
    return switch(f){
      case Initial          : stack;
      case Defined(v)       : stack.push(v);stack;
      case Coupled(last,v)  : 
        var next = toEarliestArray(last.data,stack);
        toEarliestArray(v,next);
      case null             : stack;
    }
  }
}