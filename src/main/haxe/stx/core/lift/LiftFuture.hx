package stx.core.lift;

class LiftFuture{
  static public function zip<Ti,Tii>(self:Future<Ti>,that:Future<Tii>):Future<Couple<Ti,Tii>>{
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

    self.handle(l_handler);
    that.handle(r_handler);

    return trigger.asFuture();
  }
  static public function tryAndThenCancelIfNotAvailable<T>(ft:Future<T>):Option<T>{
    var output : Option<T>   = None;
    var canceller = ft.handle(
      (x) -> output = Some(x)
    );
    if(!output.is_defined()){
      canceller.cancel();
    }
    return output;
  }
}