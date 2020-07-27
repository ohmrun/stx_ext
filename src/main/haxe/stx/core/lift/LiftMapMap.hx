package stx.core.lift;

class LiftMapMap{
  static public function map_arw<K,V,VV>(map:Map<K,V>,fn:V->VV):Map<K,VV> -> Map<K,VV>{
    return (next:Map<K,VV>) -> {
      for( key => val in map){
        next.set(key,fn(val));
      }
      return next;
    }
  }
}