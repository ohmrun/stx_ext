package stx.core.body;

class ERegs{
  static public function replaceReg(s:String,reg:EReg,with:String):String {
    return reg.replace(s,with);
  }
  static public function matches(reg:EReg):Array<String>{
    var out = [];
    var idx = 0;
    var val = null;

    while(true){
      try{
        val = reg.matched(idx);
      }catch(e:Dynamic){
        break;
      }
      out.push(val);
      idx++;
    }
    return out;
  }
}