package stx.core.pack;

@:callable @:forward abstract Reporter<E>(ReporterDef<E>){
  static public dynamic function command<E>(err:Err<E>){
    throw err;
  }

  public inline function new(){
    this = () -> command;
  }
  public inline function react(err:Err<E>):Void{
    this()(err);
  }
}