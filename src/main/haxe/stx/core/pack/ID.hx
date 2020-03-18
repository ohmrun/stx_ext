package stx.core.pack;

abstract ID(StdString) from StdString{
  public function prj():StdString{
    return this;
  }
  public function toString(){
    return this;
  }
}
