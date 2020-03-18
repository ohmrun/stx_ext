package stx.core;

abstract ErrorMsg(StdString){
  public function create(?code:Int,?pos:PosInfos):Error{
    return new Error(code,this,cast pos)
;  }
  public function internal(?pos:PosInfos){
    return create(500,pos);
  }
}