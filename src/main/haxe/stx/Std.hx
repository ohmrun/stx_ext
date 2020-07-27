package stx;


//typedef MatchApi                              = stx.core.type.MatchApi;
//typedef RegexApi                              = stx.core.type.RegexApi;



typedef ContractDef<T,E>                      = stx.core.Contract.ContractDef<T,E>;
typedef Contract<T,E>                         = stx.core.Contract<T,E>;

typedef ChunkSum<T,E>                         = stx.core.Chunk.ChunkSum<T,E>;
typedef Chunk<T,E>                            = stx.core.Chunk<T,E>;

typedef EmbedDef<T>                           = stx.core.Embed.EmbedDef<T>;
typedef Embed<T>                              = stx.core.Embed<T>;

typedef Cell<T>                               = stx.core.Cell<T>;
typedef Generator<T>                          = stx.core.Generator<T>;
typedef Unfold<T,R>                           = stx.core.Unfold<T,R>;


typedef Iter<T>                               = stx.core.Iter<T>;

typedef KV<K,V>                               = stx.core.KV<K,V>;
typedef Field<V>                              = stx.core.Field<V>;


typedef Resource                              = stx.core.Resource;
typedef TimeStamp                             = stx.core.TimeStamp;
typedef LogicalClock                          = stx.core.LogicalClock;
typedef ErrorMsg                              = stx.core.ErrorMsg;


typedef IdentDef                              = stx.core.Ident.IdentDef;
typedef Ident                                 = stx.core.Ident;

typedef ID                                    = stx.core.ID;

typedef ParameterDef<K,V>                     = stx.core.Parameter.ParameterDef<K,V>;
typedef Parameter<K,V>                        = stx.core.Parameter<K,V>;

typedef VariableDef<K,V>                      = stx.core.Variable.VariableDef<K,V>;
typedef Variable<K,V>                         = stx.core.Variable<K,V>;

typedef CardSum<T>                            = stx.core.Card.CardSum<T>;
typedef Card<T>                               = stx.core.Card<T>;

typedef SourceIdentDef                        = stx.core.SourceIdent.SourceIdentDef;
typedef SourceIdent                           = stx.core.SourceIdent;
typedef Enum<T>                               = stx.core.Enum<T>;
typedef EnumValue                             = stx.core.EnumValue;

typedef ReporterDef<E>                        = Void -> (Err<E> -> Void);
typedef Reporter<E>                           = stx.core.Reporter<E>;

typedef ErrorCode                             = stx.core.ErrorCode;

typedef Char                                  = stx.core.Char;
typedef Chars                                 = stx.core.Chars;

typedef Pledge<T,E>                           = stx.core.Pledge<T,E>
//typedef Regex                               = stx.core.Regex;



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

class LiftStd{
  static public function core(__:Wildcard):stx.core.Module{
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
}
typedef LiftIMapToArrayKV           = stx.core.lift.LiftIMapToArrayKV;
typedef LiftArrayToIter             = stx.core.lift.LiftArrayToIter;
typedef LiftBoolToPrimitive         = stx.core.lift.LiftBoolToPrimitive;
typedef LiftErrToChunk              = stx.core.lift.LiftErrToChunk;
typedef LiftFunXRToGenerator        = stx.core.lift.LiftFunXRToGenerator;
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
typedef LiftCoupleToField           = stx.core.lift.LiftCoupleToField;
typedef LiftFuture                  = stx.core.lift.LiftFuture;
typedef LiftMapConstructors         = stx.core.lift.LiftMapConstructors;
typedef LiftDynamicAccessToArrayKV  = stx.core.lift.LiftDynamicAccessToArrayKV;
typedef LiftMapMap                  = stx.core.lift.LiftMapMap;
#if tink_core
typedef LiftTinkPromiseToPledge     = stx.core.lift.LiftTinkPromiseToPledge;
#end