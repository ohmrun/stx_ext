package stx.ext;

class RegexApi{
  public var source(default,null) : String;
  public var option(default,null) : String;

  public function new(source:String,option:String){
    this.source = source;
    this.option = option;
  }
  public function match(match:String):MatchApi{
    return new MatchApi(this.source,this.option,match);
  }
}

abstract Regex(RegexApi) from RegexApi to RegexApi{
  public function new(self) this = self;
  static public function lift(self:RegexApi):Regex return new Regex(self);
  static public function make(source:String,option:String) return new RegexApi(source,option);


  public function prj():RegexApi return this;
  private var self(get,never):Regex;
  private function get_self():Regex return lift(this);
}