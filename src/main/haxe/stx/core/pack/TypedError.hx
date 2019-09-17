package stx.core.pack;

@:access(tink.core.Error) class TypedError<T> extends tink.core.TypedError<Failure<T>>{
  public function new(?code:ErrorCode = InternalError, message, ?pos) {
    super(code,message,pos);
    this.data = Initial;
  }
  static public function fromTinkError(err:tink.core.Error):Error{
    var next_error = withData(err.code,err.message,err.data,err.pos);
    return next_error;
  }
  public function withValue(data:T){
    return this.withFailure(Defined(data));
  }
  public function withFailure(data:Failure<T>):TypedError<T>{
    var err                 = new TypedError(this.code,this.message,this.pos);
        err.callStack       = this.callStack;
        err.exceptionStack  = this.exceptionStack;
        err.data            = data;
    return err; 
  }
  public static function withData(?code:ErrorCode, message:String, data:Dynamic, ?pos:Pos):Error{
    return new Error(code,message,pos).withValue(data);
  }
  public function next(that:TypedError<T>):TypedError<T>{
    /*
      trace('this.data = ${this.data}');
      trace('that.data = ${that.data}');
    */
    var next_data = (switch(that.data){
      case Initial          : Coupled(this);
      case Defined(v)       : Coupled(this,Defined(v));
      case Coupled(last,v)  : Coupled(this,Coupled(last,v));
    });
    return that.withFailure(next_data);
  }
  public function toConsole():String{
    var thing   = "___________________________________________";
    var thing1  = "/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
    var thing2  = "###########################################";
    var ret     = '\nError#$code: $message';
    if (pos != null)
      ret += " @ "+printPos();

    ret += '\n${thing1}';
    var dat = this.data.toEarliestArray().map(Std.string).map(
      function(x){
        return '\t$x';
      }
    ).join("\n");
    return '$ret\n$thing\n${dat}\n$thing\n${thing2}';
  }
}