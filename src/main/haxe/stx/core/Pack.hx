package stx.core;

class Pack{
  // static public dynamic function handle<T>(opt:T):Void{
  //   throw 'Unhandled: $opt';
  // }
}
typedef ByteSizeDef                           = stx.core.type.ByteSizeDef;
typedef CardSum<T>                            = stx.core.type.CardSum<T>;
typedef ChunkSum<T,E>                         = stx.core.type.ChunkSum<T,E>;
typedef ClauseDef<Subject,Verb>               = stx.core.type.ClauseDef<Subject,Verb>;
typedef ContractDef<T,E>                      = stx.core.type.ContractDef<T,E>;
typedef DeclareDef<Subject,Verb,Object>       = stx.core.type.DeclareDef<Subject,Verb,Object>;
typedef EitherDef<Ti,Tii>                     = haxe.ds.Either<Ti,Tii>;
typedef IdentDef                              = stx.core.type.IdentDef;
typedef MatchApi                              = stx.core.type.MatchApi;
typedef ParameterDef<K,V>                     = stx.core.type.ParameterDef<K,V>;
typedef PrimitiveDef                          = stx.core.type.PrimitiveDef;
typedef RegexApi                              = stx.core.type.RegexApi;


typedef Contract<T,E>             = stx.core.pack.Contract<T,E>;
typedef Chunk<T,E>                = stx.core.pack.Chunk<T,E>;
typedef Either<Pi,Pii>            = stx.core.pack.Either<Pi,Pii>;

typedef EmbedDef<T>               = stx.core.type.EmbedDef<T>;
typedef Embed<T>                  = stx.core.pack.Embed<T>;
typedef Cell<T>                   = stx.core.pack.Cell<T>;
typedef Generator<T>              = stx.core.pack.Generator<T>;
typedef Unfold<T,R>               = stx.core.pack.Unfold<T,R>;


typedef Iter<T>                   = stx.core.pack.Iter<T>;

typedef KV<K,V>                   = stx.core.pack.KV<K,V>;

typedef Field<V>                  = stx.core.pack.Field<V>;

typedef Timer                     = stx.core.pack.Timer;

typedef Clazz                     = stx.core.pack.Clazz;

typedef Resource                        = stx.core.pack.Resource;
typedef TimeStamp                       = stx.core.pack.TimeStamp;
typedef LogicalClock                    = stx.core.pack.LogicalClock;
typedef ErrorMsg                        = stx.core.pack.ErrorMsg;
typedef Primitive                       = stx.core.pack.Primitive;

typedef PacketDef                       = stx.core.type.PacketDef;
typedef Packet                          = stx.core.pack.Packet;
typedef Ident                           = stx.core.pack.Ident;
typedef Clause<Subject,Verb>            = stx.core.pack.Clause<Subject,Verb>;
typedef Declare<Subject,Verb,Object>    = stx.core.pack.Declare<Subject,Verb,Object>; 

typedef ID                              = stx.core.pack.ID;
typedef Parameter<K,V>                  = stx.core.pack.Parameter<K,V>;

typedef VariableDef<K,V>                = stx.core.type.VariableDef<K,V>;
typedef Variable<K,V>                   = stx.core.pack.Variable<K,V>;

typedef Card<T>                         = stx.core.pack.Card<T>;
typedef Position                        = stx.core.pack.Position;
typedef SourceIdentDef                  = stx.core.type.SourceIdentDef;
typedef SourceIdent                     = stx.core.pack.SourceIdent;
typedef Enum<T>                         = stx.core.pack.Enum<T>;
typedef EnumValue                       = stx.core.pack.EnumValue;
typedef Report<E>                       = stx.core.pack.Report<E>;
typedef ReporterDef<E>                  = Void -> (Err<E> -> Void);
typedef Reporter<E>                     = stx.core.pack.Reporter<E>;

typedef ErrorCode                       = stx.core.pack.ErrorCode;

typedef Chars                           = stx.core.pack.Chars;
typedef Exception                       = stx.core.pack.Exception;
typedef Unique<T>                       = stx.core.pack.Unique<T>;

//typedef Regex                           = stx.core.pack.Regex;



class LiftString{
  static public function sep(path:String):String{
    return new haxe.io.Path(path).backslash ? "\\" : "/";
  }
}

interface AppliableApi<P,R>{
  public function apply(p:P):R;
}

interface BinomialApi<P0,P1,R>{
  public function duoply(p0:P0,p1:P1):R;
}
interface RepliableApi<T>{
  public function reply():T;
}

interface SymbolApi{
  @:isProp public var id(get,set) : ID;
  private function get_id():ID;
  private function set_id(str:ID):ID;
}
enum LogicSum<T>{
  Seq(l:LogicSum<T>,r:LogicSum<T>);
  Alt(l:LogicSum<T>,r:LogicSum<T>);

  Neg(v:Logic<T>);

  App(v:T);
} 
typedef Logic<T> = LogicSum<T>;

enum OpSum<U,B,T>{
  Nop(v:T);
  Unop(op:U,v:T);
  Binop(op:B,l:T,r:T);
}
typedef Op<U,B,T> = OpSum<U,B,T>;

class Lift{
  static public function future<T>(wildcard:Wildcard):Tuple<FutureTrigger<T>,Future<T>>{
    var trigger = Future.trigger();
    var future  = trigger.asFuture();
    return __.tuple(trigger,future);
  }
  static public function core(__:Wildcard):Module{
    return new stx.core.Module();
  }
  static public function here(_:Wildcard,?pos:Pos):Position{
    return new Position(pos);
  }
  static public function rtid():Void->Void{
    return () -> {};
  }
  static public function chunk<T>(_:Wildcard,v:Null<T>):Chunk<T,Dynamic>{
    return switch(v){
      case null : Tap;
      default   : Val(v);
    }
  }
  static public function cell<T>(_:Wildcard,v:T):Cell<T>{
    return Cell.fromT(v);
  }
  static public function tracer<T>(v:Wildcard,?pos:PosInfos):T->T{
    return function(t:T):T{
      trace(t,pos);
      return t;
    }
  }
  static public function traced<T>(v:Wildcard,?pos:PosInfos):T->Void{
    return function(d:T):Void{
      haxe.Log.trace(d,pos);
    }
  }
  static public function test(_:Wildcard,arr:Iterable<haxe.unit.TestCase>){
    var runner = new haxe.unit.TestRunner();
    for(t in arr){
      runner.add(t);
    }
    runner.run();
  }
  static public function through<T>(__:Wildcard):T->T{
    return (v:T) -> v;
  }
  static public function command<T>(__:Wildcard,fn:T->Void):T->T{
    return (v:T) -> {
      fn(v);
      return v;
    }
  }
  static public function perform<T>(__:Wildcard,fn:Void->Void):T->T{
    return (v:T) -> {
      fn();
      return v;
    }
  }
  static public function execute<T,E>(__:Wildcard,fn:Void->Option<Err<E>>):T->Chunk<T,E>{
    return (v:T) -> switch(fn()){
      case Some(e)  : End(e);
      default       : Val(v);
    }
  }
  static public inline function report<E>(__:Wildcard,err:Err<E>):Void{
    new Reporter().react(err);
  }
  static public function timer(__:Wildcard){
    return Timer.unit();
  }
}
typedef LiftIMapToArrayKV           = stx.core.lift.LiftIMapToArrayKV;
typedef LiftArrayToIter             = stx.core.lift.LiftArrayToIter;
typedef LiftBoolToPrimitive         = stx.core.lift.LiftBoolToPrimitive;
typedef LiftErrToChunk              = stx.core.lift.LiftErrToChunk;
typedef LiftFunXRToGenerator        = stx.core.lift.LiftFunXRToGenerator;
typedef LiftFuture                  = stx.core.lift.LiftFuture;
typedef LiftIntToPrimitive          = stx.core.lift.LiftIntToPrimitive;
typedef LiftIterableToIter          = stx.core.lift.LiftIterableToIter;
typedef LiftIteratorToIter          = stx.core.lift.LiftIteratorToIter;
typedef LiftIterOfFieldToStringMap  = stx.core.lift.LiftIterOfFieldToStringMap;
typedef LiftMapToIter               = stx.core.lift.LiftMapToIter;
typedef LiftOptionToChunk           = stx.core.lift.LiftOptionToChunk;
typedef LiftPath                    = stx.core.lift.LiftPath;
typedef LiftStringMapToIter         = stx.core.lift.LiftStringMapToIter;
typedef LiftStringToIdent           = stx.core.lift.LiftStringToIdent;
typedef LiftStringToResource        = stx.core.lift.LiftStringToResource;
typedef LiftTinkOutcomeToChunk      = stx.core.lift.LiftTinkOutcomeToChunk;
typedef LiftTupleInto               = stx.core.lift.LiftTupleInto;
typedef LiftTupleToField            = stx.core.lift.LiftTupleToField;


