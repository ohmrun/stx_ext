package stx.ext.head;

class Strings{
  /**
		Unit function.
	**/
  static public function unit():String{
    return '';
  }
  @:noUsing static public function lift(self:StdString){
    return new String(self);
  }
  //static function Requote()                 return ~/"([^"\\]*(\\.[^"\\]*)*)"|\\'([^\\'\\]*(\\.[^\\'\\]*)*)\\'/;
  //static function SepAlphaPattern()         return ~/(-|_)([a-z])/g;
  //static function AlphaUpperAlphaPattern()  return ~/-([a-z])([A-Z])/g;
  //static function CamelCaseToDashes()       { return new EReg("([a-zA-Z])(?=[A-Z])", "g") };
  //static function CamelCaseToLowerCase()
 
    /**
		Returns a seamless joined string of `l`.
	**/
  public function string(l: Iterable<String>): String {
    var o = '';
    for ( val in l) {
      o += val;
    }
    return o;
  }
}