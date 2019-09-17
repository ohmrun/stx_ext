package stx.core.body;

import haxe.Constraints;

class Iterables{
  static public function cross<T,U>(l:Iterable<T>,r:Iterable<U>):Iterable<Tuple2<T,U>>{
    return { iterator : function(){
      var l_it  = l.iterator();
      var r_it  = r.iterator();
      var l_val = null;

      return{
        next : function rec(){
          if(l_val != null &&  l_it.hasNext()){
            l_val = l_it.next();
          } 
          return if(r_it.hasNext()){
            tuple2(l_val,r_it.next());
          }else{
            if(l_it.hasNext()){
              r_it = r.iterator();
            }
            l_val = null;
            rec();
          }
        },
        hasNext: function(){
          return (!l_it.hasNext()) ? r_it.hasNext() : false;
        }
      };
    }
  }}
  static public function zip<L,R>(l:Iterable<L>,r:Iterable<R>):Iterable<Tuple2<L,R>>{
    return {
      iterator : function():Iterator<Tuple2<L,R>>{
        var lit = l.iterator();
        var rit = r.iterator();

        return {
          next : function(){
            return tuple2(lit.next(),rit.next()); 
          },
          hasNext : function(){
            return lit.hasNext() && rit.hasNext();
          }
        }
      }
    };
  }
  static public function dropLeft<T>(it:Iterable<T>,n:Int):Iterable<T>{
    return {
      iterator : function(){
        var iter = it.iterator();
        while(n>0){
          iter.next();
          n--;
        }
        return iter;
      }
    }
  }
  static public function tail<T>(it:Iterable<T>){
    return dropLeft(it,1);
  }
  static public function toMap<T,K,V,M:IMap<K,V>>(iter:Iter<T>,fn:T->Tuple2<K,V>,map:M):M{
    for(i in iter){
      var kv = fn(i);
          kv.into(
            (l,r) -> map.set(l,r)
          );
    }
    return map;
  }
  static public function map<T,U>(iter:Iter<T>,fn:T->U){
    return {
      iterator : function(){
        var i = iter.iterator();
        return {
          next : function(){
            return fn(i.next());
          },
          hasNext: function(){
            return i.hasNext();
          }
        }
      }
    }
  }
  
}