package stx.core;

abstract Parameter<K,V>(ParameterDef<K,V>) from ParameterDef<K,V> to ParameterDef<K,V>{
    public function new(self){
        this = self;
    }
}