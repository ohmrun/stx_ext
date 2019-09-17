package stx.core.pack;

abstract ErrorMsg(String){
  public function create(?code:Int,?pos:PosInfos):Error{
    return new Error(code,this,cast pos)
;  }
  public function internal(?pos:PosInfos){
    return create(500,pos);
  }
}