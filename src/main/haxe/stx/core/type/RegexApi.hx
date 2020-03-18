package stx.core.type;

@:allow(stx.core.Regex) class RegexApi{
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