package stx.core.pack.body;

class Tuple2s {
    #if thx_core
      static public function fromThxTuple2<A,B>(tup:ThxTuple2<A,B>):Tuple2<A,B>{
        return tuple2(tup._0,tup._1);
      }

      static public function toThxTuple2<A,B>(tup:Tuple2<A,B>):ThxTuple2<A,B>{
        return new ThxTuple2(fst(tup),snd(tup));
      }
    #end


    static public function map<T1,T2,TZ>(tuple: Tuple2<T1,T2>,fn:T2->TZ): Tuple2<T1,TZ>{
      return switch tuple{
          case tuple2(l,r) : tuple2(l,fn(r));
      }
    }
    static public function apply<T1,T2,R>(tuple: Tuple2<T1->R,T1>){
        return fst(tuple)(snd(tuple));
    }
    static public function fst<T1, T2>(tuple : Tuple2<T1, T2>) : T1 {
        return switch (tuple){
            case tuple2(a,_)    : a;
        }
    }
    static public function snd<T1, T2>(tuple : Tuple2<T1, T2>) : T2 {
        return switch (tuple){
            case tuple2(_,b)    : b;
        }
    }
    static public function swap<T1, T2>(tuple : Tuple2<T1, T2>) : Tuple2<T2, T1> {
        return switch (tuple) {
            case tuple2(a, b): tuple2(b, a);
        }
    }
    static public function equals<T1, T2>(a : Tuple2<T1, T2>, b : Tuple2<T1, T2>) : Bool {
      return switch (a) {
        case tuple2(t0l, t0r):
            switch (b) {
              case tuple2(t1l, t1r) :  (t0l == t1l) && (t0r == t1r);
              default               : false;
            }
        default : false;
        }
    }
    static public function toArray<T1, T2>(tuple : Tuple2<T1, T2>) : Array<Dynamic> {
        return switch (tuple){
            case tuple2(a,b)    : [a,b];
        }
    }
    static public function into<A,B,C>(t:Tuple2<A,B>,f:A->B->C):C {
        return switch(t){
            case tuple2(a,b)    : f(a,b);
        }
    }
    public inline static function tupled<A,B,C>(f : A -> B -> C){
        return into.bind(_,f);
    }
    public inline static function untupled<A,B,C>(f:Tuple2<A,B>->C):A->B->C{
        return function(a:A,b:B):C{
            return f(tuple2(a,b));
        }
    }
}
