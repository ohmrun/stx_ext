package stx.ext;

abstract Counter(Int){
  public function new(?self){
    this = self == null ? 0 : self; 
  }
  public function tick():Couple<Int,Counter>{
    return __.couple(this,new Counter(this+1));
  }
}