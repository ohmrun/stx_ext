package stx.core.pack.iter;

import haxe.Constraints;

class Destructure extends Clazz{
  public function cross<T,Ti>(self:Iterable<T>,that:Iterable<Ti>):Iterable<Tuple<T,Ti>>{
    return { iterator : function(){
      var l_it  = self.iterator();
      var r_it  = that.iterator();
      var l_val = null;

      return{
        next : function rec(){
          if(l_val != null &&  l_it.hasNext()){
            l_val = l_it.next();
          } 
          return if(r_it.hasNext()){
            __.tuple(l_val,r_it.next());
          }else{
            if(l_it.hasNext()){
              r_it = that.iterator();
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
  public function zip<L,R>(l:Iterable<L>,r:Iterable<R>):Iterable<Tuple<L,R>>{
    return {
      iterator : function():Iterator<Tuple<L,R>>{
        var lit = l.iterator();
        var rit = r.iterator();

        return {
          next : function(){
            return __.tuple(lit.next(),rit.next()); 
          },
          hasNext : function(){
            return lit.hasNext() && rit.hasNext();
          }
        }
      }
    };
  }
  public function ldrop<T>(it:Iterable<T>,n:Int):Iterable<T>{
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
  public function tail<T>(it:Iterable<T>){
    return ldrop(it,1);
  }
  public function toMap<T,K,V,M:IMap<K,V>>(iter:Iter<T>,fn:T->Tuple<K,V>,map:M):M{
    for(i in iter){
      var kv = fn(i);
        __.into2(map.set)(kv);
    }
    return map;
  }
  public function map<T,Ti>(iter:Iter<T>,fn:T->Ti){
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
    /**

    Tising starting var `z`, run `f` on each element, storing the result, and passing that result
    into the next call.
    ```
    [1,2,3,4,5].foldLeft( 100, function(init,v) return init + v ));//(((((100 + 1) + 2) + 3) + 4) + 5)
    ```

	**/
  public function lfold<T, Z>(iter: Iterable<T>, mapper: T -> Z -> Z,seed: Z): Z {
    var folded = seed;
    for (e in iter) { folded = mapper(e,folded); }
    return folded;
  }  
  public function toGenerator<T>(self:Iter<T>):Void->Option<T>{
    var iter : Option<Iterator<T>> = None;
    return () -> {
      if (iter == None){
       iter = Some(self.iterator());
      }
      return iter.flat_map(
        (x) -> x.hasNext() ? Some(x.next()) : None
      );
    };
  }
}