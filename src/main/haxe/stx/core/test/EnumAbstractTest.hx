package stx.core.test;

/**
  Proving to myself various things about what data can be fetched out of enum abstracts.
**/
class EnumAbstractTest extends haxe.unit.TestCase {
  public function test(){
    trace(StdType.typeof(TOOTLY));
    trace(TOOTLY);
  }
  public static function __init__(){
    if(Resource.exists("haxerc")){
      var a  = __.resource("haxerc").string();
      trace(a);
    }
  }
}
enum abstract Duff(Int){
  var TOOTLY;
}