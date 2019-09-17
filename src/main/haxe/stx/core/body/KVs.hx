package stx.core.body;

import haxe.Constraints;

class KVs{
  @:noUsing static public function fromMap<K,V>(map:IMap<K,V>):Array<KV<K,V>>{
    var out = [];
    for(key => val in map){
      out.push(KV.fromTup(tuple2(key,val)));
    }
    return out;
  }
}