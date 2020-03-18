package stx.core.string;

class Is{
  var self : StdString;
  public function new(self){
    this.self = self;
  }
  public function empty(){
    return self == null || self.length < 1;
  }
  public function blank(){
    return new Is(StringTools.trim(self)).empty();
  }
}