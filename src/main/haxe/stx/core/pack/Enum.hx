package stx.core.pack;

abstract Enum<T>(StdEnum<T>) from StdEnum<T>{
  public function new(self) this = self;

  public function constructs(){
    return Type.getEnumConstructs(this);
  }
  public function name(){
    return Type.getEnumName(this);
  }
}