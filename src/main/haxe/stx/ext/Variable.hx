package stx.ext;

typedef VariableDef<K,V> = Couple<K,Option<V>>;

@:forward abstract Variable<K,V>(VariableDef<K,V>) from VariableDef<K,V> to VariableDef<K,V>{
  public function new(self) this = self;

  public function map<U>(fn:V->U):Variable<K,U>{
    return new Variable(
      Couple._.map(
        this,
        function(x:Option<V>):Option<U>{
            return x.map(fn);
        }
      )
    );
  }
  @:noUsing static public function make<K,V>(k:K,?v:V):Variable<K,V>{
    var vOpt = v == null ? None : Some(v);
    return new Variable(__.couple(k,vOpt));
  }
}