package stx.core.pack;

private typedef TimerT = {
  var created(default,null) : Float;
}
@:forward abstract Timer(TimerT) from TimerT to TimerT{
  function new(?self){
    if(self == null){
      this = unit();
    }else{
      this = self;
    }
  }
  static public function pure(v:Float):Timer{
    return {
      created : v
    };
  }
  static public function unit():Timer{
    return pure(mark());
  }
  static public function mark(){
    return haxe.Timer.stamp();
  }
  function copy(?created:Float){
    return pure(created == null ? this.created : created);
  }
  public function start(){
    return copy(mark());
  }
  public function since(){
    return mark() - this.created;
  }
  function prj(){
    return this;
  }
}