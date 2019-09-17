package stx.core;

import haxe.PosInfos;
import haxe.Constraints;

typedef Errors = stx.core.body.Errors;

@:forward abstract Stx<T>(Null<T>) from Null<T>{
  public function new(self:Null<T>){
    this = self;
  }
  public function thunk():Void -> T{
    return () -> this;
  }
  static public function unit(){
    return new Stx(__);
  }
  static public function stx(v:Wildcard):Stx<Wildcard>{
    return new Stx(v);
  }
}
enum Wildcard{
  __;
}
class Lift{
  /**
		Returns a unique identifier, each `x` replaced with a hex character.
	**/
  static public function uuid(v:Stx<Wildcard>, value : String = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx') : String {
    var reg = ~/[xy]/g;
    return reg.map(value, function(reg) {
        var r = Std.int(Math.random() * 16) | 0;
        var v = reg.matched(0) == 'x' ? r : (r & 0x3 | 0x8);
        return StringTools.hex(v);
    }).toLowerCase();
  }
  static public function option<T>(v:Stx<Wildcard>,v:Null<T>):Option<T>{
    return switch(v){
      case null : None;
      default   : Some(v);
    }
  }
  static public function chunk<T,E>(v:Stx<Wildcard>,v:Null<T>):Chunk<T,E>{
    return switch (v){
      case null : Tap;
      default   : Val(v);
    }
  }  
  static public function sep(v:Stx<Wildcard>):String{
    return "/";
  }
  static public function trace<T>(v:Stx<Wildcard>,?pos:PosInfos):T->T{
    return function(d:T):T{
      haxe.Log.trace(d,pos);
      return d;
    }
  }
  static public function core(stx:Stx<Wildcard>):stx.core.pack.Api{
    return new stx.core.pack.Api();
  }
}
class LiftTupleField{
  static public function toField<T>(tp:Tuple2<String,T>):Field<T>{
    return tp;
  }
}
class LiftOption{
  static public function core<T>(o:stx.alias.StdOption<T>):stx.core.pack.Option<T>{
    return o;
  }
}
class LiftGenerator{
  static public function toGenerator<A>(fn : Void -> Option<A>):Iterable<A>{
    return Generator.yielding(fn);
  }
}
class LiftMap{
  static public function toIter<K,V>(map:Map<K,V>):Iter<KV<K,V>>{
    return {
      iterator : function() {
        var source = map.keyValueIterator();
        return{
          next : function(){
            var out = source.next();
            return {
              key : out.key,
              val : out.value
            };
          },
          hasNext: source.hasNext
        }  
      }
    }
  }
}
class LiftStringMap{
  static public function toIter<V>(map:StringMap<V>):Iter<Field<V>>{
    return LiftMap.toIter(map).map((x) -> new Field(x));
  }
}
class LiftChunk{
  static public function toChunk<T,E>(v:T):Chunk<T,E>{
    return Val(v);
  }
}
class LiftOptionChunk{
  static public function toChunk<T,E>(opt:StdOption<T>):Chunk<T,E>{
    return switch (opt){
      case Some(v)  : Val(v);
      case None     : Tap;
    }
  }
}
class LiftErrorChunk{
  static public function toChunk<T>(err:Error){
    return Chunk.fromError(err);
  }
}

class LiftStringResource{
  static public function resource(stx:Stx<Wildcard>,str:String):Resource{
    return new Resource(str);
  }
}
class LiftFault{
  static public function fault(stx:Stx<Wildcard>,?pos:PosInfos):Fault{
    return new Fault(pos);
  }
}
class LiftFieldsIterIntoMap{
  static public function toMap<V>(iter:Iter<Field<V>>):StringMap<V>{
    return Iterables.toMap(
      iter,
      (f) -> f.toTuple(),
      new StringMap()
    );
  }
}
class LiftBoolPrimitive{
  static public function toPrimitive(b:Bool):Primitive{
    return PBool(b);
  }
}
class LiftIntPrimitive{
  static public function toPrimitive(i:Int):Primitive{
    return PInt(i);
  }
}
class LiftIterator{
  static public function toIter<T>(it:Iterator<T>):Iter<T>{
    return {
      iterator : () -> it
    };
  }
}