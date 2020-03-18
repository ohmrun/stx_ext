package stx.core;

abstract ID(StdString) from StdString{
  public function prj():StdString{
    return this;
  }
  public function toString(){
    return this;
  }
}
