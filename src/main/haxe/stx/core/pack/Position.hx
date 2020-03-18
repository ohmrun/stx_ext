package stx.core.pack;

import stx.core.pack.position.Constructor;

@:forward abstract Position(Pos) from Pos to Pos{
  static public inline function _()             return Constructor.ZERO;
  static public var ZERO(default,never) : Pos = _().make(null,null,null,null);

  public function new(self:Pos) this = self;

  static public function make(fileName,className,methodName,lineNumber,?customParams):Position return _().make(fileName,className,methodName,lineNumber,customParams);
  #if (!macro)
    @:from static public function fromPosInfos(pos:PosInfos):Position{
      return new Position(pos);
    }
    public function toString():String{
      return _()._.toStringClassMethodLine(this);
    }
  #else
    public function toString() {
      return Std.string(this);
    }
  #end

  static public function here(?pos:Pos) {
    return pos;
  } 
  public function clone()                               return _()._.clone(this);
  public function withFragmentName():String             return _()._.withFragmentName(this);
  public function toStringClassMethodLine()             return _()._.toStringClassMethodLine(this);
  public function withCustomParams(v:Dynamic):Position  return _()._.withCustomParams(v,this);
}