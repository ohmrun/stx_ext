package stx.core.pack;

//uses the identity equality of functions to define a unique runtime identifier
abstact RTID(Void->Void){
  public function new(){
    this = () -> {};
  }
  public function equals(that:RTID){
    return this == that;
  }
}