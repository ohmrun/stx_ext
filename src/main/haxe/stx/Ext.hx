package stx;


typedef MatchApi                              = stx.ext.Match.MatchApi;
typedef Match                                 = stx.ext.Match.Match;
typedef RegexApi                              = stx.ext.Regex.RegexApi;
typedef Regex                                 = stx.ext.Regex;

typedef SymbolApi                             = stx.ext.Symbol.SymbolApi;
typedef Symbol                                = stx.ext.Symbol;

typedef ContractDef<T,E>                      = stx.ext.Contract.ContractDef<T,E>;
typedef Contract<T,E>                         = stx.ext.Contract<T,E>;

typedef ChunkSum<T,E>                         = stx.ext.Chunk.ChunkSum<T,E>;
typedef Chunk<T,E>                            = stx.ext.Chunk<T,E>;

typedef EmbedDef<T>                           = stx.ext.Embed.EmbedDef<T>;
typedef Embed<T>                              = stx.ext.Embed<T>;

typedef Cell<T>                               = stx.ext.Cell<T>;
typedef Generator<T>                          = stx.ext.Generator<T>;
typedef Unfold<T,R>                           = stx.ext.Unfold<T,R>;


typedef Iter<T>                               = stx.ext.Iter<T>;

typedef KV<K,V>                               = stx.ext.KV<K,V>;
typedef Field<V>                              = stx.ext.Field<V>;


typedef Resource                              = stx.ext.Resource;
typedef TimeStamp                             = stx.ext.TimeStamp;
typedef LogicalClock                          = stx.ext.LogicalClock;
typedef ErrorMsg                              = stx.ext.ErrorMsg;


typedef IdentDef                              = stx.ext.Ident.IdentDef;
typedef Ident                                 = stx.ext.Ident;

typedef ID                                    = stx.ext.ID;

typedef ParameterDef<K,V>                     = stx.ext.Parameter.ParameterDef<K,V>;
typedef Parameter<K,V>                        = stx.ext.Parameter<K,V>;

typedef VariableDef<K,V>                      = stx.ext.Variable.VariableDef<K,V>;
typedef Variable<K,V>                         = stx.ext.Variable<K,V>;

typedef CardSum<T>                            = stx.ext.Card.CardSum<T>;
typedef Card<T>                               = stx.ext.Card<T>;

typedef SourceIdentDef                        = stx.ext.SourceIdent.SourceIdentDef;
typedef SourceIdent                           = stx.ext.SourceIdent;
typedef Enum<T>                               = stx.ext.Enum<T>;
typedef EnumValue                             = stx.ext.EnumValue;

typedef ReporterDef<E>                        = Void -> (Err<E> -> Void);
typedef Reporter<E>                           = stx.ext.Reporter<E>;

typedef ErrorCode                             = stx.ext.ErrorCode;

typedef Char                                  = stx.ext.Char;
typedef Chars                                 = stx.ext.Chars;

typedef Pledge<T,E>                           = stx.ext.Pledge<T,E>
//typedef Regex                               = stx.ext.Regex;



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
  static public function core(__:Wildcard):stx.ext.Module{
    return new stx.ext.Module();
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
typedef LiftDynamicAccessToArrayKV  = stx.ext.lift.LiftDynamicAccessToArrayKV;
typedef LiftIMapToArrayKV           = stx.ext.lift.LiftIMapToArrayKV;
typedef LiftArrayToIter             = stx.ext.lift.LiftArrayToIter;
typedef LiftBoolToPrimitive         = stx.ext.lift.LiftBoolToPrimitive;
typedef LiftErrToChunk              = stx.ext.lift.LiftErrToChunk;
typedef LiftFunXRToGenerator        = stx.ext.lift.LiftFunXRToGenerator;
typedef LiftIntToPrimitive          = stx.ext.lift.LiftIntToPrimitive;
typedef LiftIterableToIter          = stx.ext.lift.LiftIterableToIter;
typedef LiftIteratorToIter          = stx.ext.lift.LiftIteratorToIter;
typedef LiftIterOfFieldToStringMap  = stx.ext.lift.LiftIterOfFieldToStringMap;
typedef LiftMapToIter               = stx.ext.lift.LiftMapToIter;
typedef LiftOptionToChunk           = stx.ext.lift.LiftOptionToChunk;
typedef LiftPath                    = stx.ext.lift.LiftPath;
typedef LiftStringMapToIter         = stx.ext.lift.LiftStringMapToIter;
typedef LiftStringToIdent           = stx.ext.lift.LiftStringToIdent;
typedef LiftStringToResource        = stx.ext.lift.LiftStringToResource;
typedef LiftTinkOutcomeToChunk      = stx.ext.lift.LiftTinkOutcomeToChunk;
typedef LiftCoupleToField           = stx.ext.lift.LiftCoupleToField;
typedef LiftFuture                  = stx.ext.lift.LiftFuture;
typedef LiftMapConstructors         = stx.ext.lift.LiftMapConstructors;

typedef LiftMapMap                  = stx.ext.lift.LiftMapMap;
#if tink_core
typedef LiftTinkPromiseToPledge     = stx.ext.lift.LiftTinkPromiseToPledge;
#end

typedef Math                        = stx.ext.Math;
typedef Ints                        = stx.ext.Ints;
typedef Floats                      = stx.ext.Floats;
typedef Blob                        = stx.ext.Blob;