package stx.core;

abstract Counter(Int){
  public function new(?self){
    this = self == null ? 0 : self; 
  }
  public function tick():Tuple<Int,Counter>{
    return Tuple(this,new Counter(this+1));
  }
}