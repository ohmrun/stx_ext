package stx.core.lift;

class LiftIMapToArrayKV{
  static public function fromIMap<K,V>(map:IMap<K,V>):Array<KV<K,V>>{
    var out = [];
    for(key => val in map){
      out.push(KV.fromTup(__.tuple(key,val)));
    }
    return out;
  }
}