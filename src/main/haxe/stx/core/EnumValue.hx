package stx.core;

abstract EnumValue(StdEnumValue) from StdEnumValue{
  public function new(self:StdEnumValue) this = self;
  public function params(){
    return StdType.enumParameters(this);
  }
  public function constructor(){
    return StdType.enumConstructor(this);
  }
  public function index(){
    return StdType.enumIndex(this);
  }
  public function alike(that:EnumValue){
    return constructor() == that.constructor() && index() == that.index();
  }
  public function prj():StdEnumValue{
    return this;
  }
}