package stx.core;

enum ParameterDef<K,V>{
  Unbound(k:K);
  Bound(v:V);
}
abstract Parameter<K,V>(ParameterDef<K,V>) from ParameterDef<K,V> to ParameterDef<K,V>{
    public function new(self){
        this = self;
    }
}