package stx.ext;

abstract Enum<T>(StdEnum<T>) from StdEnum<T>{
  
  public function new(self) this = self;

  public function constructs(){
    return Type.getEnumConstructs(this);
  }
  public function name(){
    return Type.getEnumName(this);
  }
  public function construct(cons:Either<Int,String>,args:Array<Dynamic>):Option<T>{
    return switch(cons){
      case Left(i)  : StdType.createEnumIndex(this,i,args);
      case Right(s) : StdType.createEnum(this,s,args);
    }
  }
}