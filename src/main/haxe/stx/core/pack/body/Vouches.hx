package stx.core.pack.body;

class Vouches{
  static public function zip<A,B,E>(vch0:Vouch<A,E>,vch1:Vouch<B,E>):Vouch<Tuple2<A,B>,E>{
    return Futures.zip(vch0,vch1).map(
      (tp) -> tp.into(Chunks.zip)
    );
  }
  static public function zipWith<A,B,C,E>(vch0:Vouch<A,E>,vch1:Vouch<B,E>,fn:A->B->C):Vouch<C,E>{
    return Futures.zip(vch0,vch1).map(
      (tp:Tuple2<Chunk<A,E>,Chunk<B,E>>) -> tp.into(
        (l,r) -> l.zipWith(r,fn)
      )
    );
  }
  static public function unit<A,E>():Vouch<A,E>{
    return Vouch.pure(Tap);
  }
  static public function map<U,T,E>(vch:Vouch<T,E>,fn:T->U):Vouch<U,E>{
    return vch.map(
      function(x){
        return switch (x){
          case Tap      : Tap;
          case Val(v)   : Val(fn(v));
          case End(err) : End(err);
    }});
  }
  static public function fmap<U,T,E>(vch:Vouch<T,E>,fn:T->Vouch<U,E>):Vouch<U,E>{
    var ft : Future<Chunk<T,E>> = vch;
    return ft.flatMap(
      function(x:Chunk<T,E>):Vouch<U,E>{
        return switch (x){
          case Tap      : new Vouch(Future.sync(Tap));
          case Val(v)   : fn(v);
          case End(err) : Vouch.sync(End(err));
    }});
  }
  static public function bindFold<A,B,E>(it:Array<A>,start:B,fm:B->A->Vouch<B,E>):Vouch<B,E>{
    return new Vouch(Futures.bindFold(
      it,
      Val(start),
      function(memo:Chunk<B,E>,next:A):Future<Chunk<B,E>>{
        return switch (memo){
          case Tap      : Vouch.unit().prj();
          case Val(v)   : fm(v,next);
          case End(err) : Vouch.end(err);
        }
      }
    ));
  }
  /*static public function waitfold<A>(init:Vouch<Array<A>>,ft:Vouch<A>):Vouch<Array<A>>{
    return Vouches.flatMap(init,
        function(arr:Array<A>){
          return ft.map(
              function(v:A):Array<A>{
                return arr.add(v);
              }
            );
        }
      );
  }
  static public function wait<A>(it:Array<Vouch<A>>):Vouch<Array<A>>{
    return it.foldLeft(intact([]), waitfold);
  }*/
  static public function fold<A,Z,E>(vch:Vouch<A,E>,val:A->Z,ers:Null<TypedError<E>>->Z,nil:Void->Z):Future<Z>{
    return vch.prj().map(Chunks.fold.bind(_,val,ers,nil));
  }
}