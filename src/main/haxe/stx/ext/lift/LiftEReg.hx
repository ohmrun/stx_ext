package stx.ext.lift;

class LiftEReg{
  static public function replaceReg(s:StdString,reg:EReg,with:StdString):StdString {
    return reg.replace(s,with);
  }
  static public function matches(reg:EReg):Array<StdString>{
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