package stx.core.body;

class Futures{
  static public function zip<A,B>(ft0:Future<A>,ft1:Future<B>):Future<Tuple2<A,B>>{
    var done  = false;
    var left  = None;
    var right = None;
    var trigger = Future.trigger();
    var on_done = function(){
      switch([left,right]){
        case [Some(l),Some(r)]:
        default :
      }
    }
    var l_handler = function(l){
      left = Some(l);
      on_done();
    }
    var r_handler = function(r){
      right = Some(r);
      on_done();
    }

    ft0.handle(l_handler);
    ft1.handle(r_handler);

    return trigger.asFuture();
  }
  @:noUsing static public function bindFold<A,B>(arr:Array<A>,init:B,fold:B->A->Future<B>){
    return Lambda.fold(arr,
      function(next:A,memo:Future<B>):Future<B>{
        return memo.flatMap(
          function(b:B){
            return fold(b,next);
          }
        );
      },
      Future.sync(init)
    );
  }
}
