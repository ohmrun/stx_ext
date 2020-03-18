package stx.core;

@:forward abstract Card<T>(CardSum<T>) from CardSum<T>{

  public function new(self:CardSum<T>){
    this = self;
  }
  static public function of<T>(wildcard:Wildcard,x:T):Card<T>{
    return new Card(___(x));
  }
  public function asAny():Card<Any>{
    return map(x -> (x:Any));
  }
  public function asDynamic():Card<Dynamic>{
    return map(x -> (x:Dynamic));
  }
  public function then<U>(v:U):Card<U>{
    var out = new Card(___(v));
    return out;
  }
  public function val(?pos:Pos):T{
    return pull(x->x,pos);
  }
  public function pull<U>(fn:T->U,?pos:Pos):U{
    return switch(this){
      case ___(a) : 
        if(a == null){
          throw "Null Encountered at (${pos})";
        }
        fn(a);
    }
  }
  public function or(thk:Void->T):Card<T>{
    return switch(this){
      case ___(a) : ___(a);
      case null   : ___(thk());
    }
  }
  public function orv(v:T):Card<T>{
    return or(()-> v);
  }
  public function def(thk:Void->T):T{
    return switch(this){
      case ___(a) : a;
      case null   : thk();
    }
  }
  public function defv(v:T):T{
    return def(()-> v);
  }
  
  public function map<U>(fn:T->U):Card<U>{
    return switch(this){
      case ___(null)  : new Card(___(null));
      case ___(a)     : new Card(___(fn(a)));
    }
  }
  @:from static public function fromWildcard(crd:Wildcard):Card<Wildcard>{
    return new Card(___(crd));
  }
  static public function ab<A,B>(tp:Card<{ a : A, b : B}>):Tuple<A,B>{
    return tp.map((tp) -> __.tuple(tp.a,tp.b)).val();
  }
}