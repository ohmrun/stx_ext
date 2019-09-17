package stx.core.pack;

abstract Counter(Int){
  public function new(?self){
    this = self == null ? 0 : self; 
  }
  public function tick():Tuple2<Int,Counter>{
    return tuple2(this,new Counter(this+1));
  }
}