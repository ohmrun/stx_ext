package stx.core.pack;

abstract Fault(PosInfos) from PosInfos{
  public function new(self) this = self;
  public function because(msg,?code){
    return new Error(code,msg,cast this);
  }
  public function carrying(msg,data,?code){
    return Error.withData(code,msg,data);
  }
  public function prj():PosInfos{
    return this;
  }
}