package stx.core.pack;

private typedef TimerT = {
  var start : Float;
}
abstract Timer(TimerT) from TimerT to TimerT{
  function new(?self){
    if(self == null){
      this = unit();
    }else{
      this = self;
    }
  }
  static public function pure(v:Float):Timer{
    return {
      start : v
    };
  }
  static public function unit():Timer{
    return pure(mark());
  }
  static function mark(){
    return haxe.Timer.stamp();
  }
  function copy(?start:Float){
    return pure(start == null ? this.start : start);
  }
  public function start(){
    return copy(mark());
  }
  public function since(){
    return mark() - this.start;
  }
  function prj(){
    return this;
  }
}