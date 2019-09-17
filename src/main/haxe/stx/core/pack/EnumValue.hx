package stx.core.pack;

abstract EnumValue(StdEnumValue) from StdEnumValue{
  public function new(self) this = self;
  public function params(){
    return Type.enumParameters(this);
  }
  public function constructor(){
    return Type.enumConstructor(this);
  }
  public function index(){
    return Type.enumIndex(this);
  }
}