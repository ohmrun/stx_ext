package stx.core.pack;

import stx.core.pack.body.Maybes;

/**
  Similar to the `haxe.ds.Option` class with little runtime overhead.

  At this point, `import hx.Maybe.[static]` will not work.
**/
abstract Maybe<T>(Null<Dynamic>) from Null<T>{

  /**
    Unit function, type will be inferred down the line.
  **/
  static public inline function unit<T>():Maybe<T>{
    return new Maybe(null);
  }

  /**
    Static constructor
  **/
  static public inline function pure<T>(v:T):Maybe<T>{
    return new Maybe(v);
  }
  /**
    Constructor. new Maybe(any_value);
  */
  public function new(self){
    this = self;
  }
  /**
    Call f on the value, if there is one.
  */
  public inline function each(f:T->Void):Maybe<T>{
    switch(this){
      case null:
      default : f(this);
    }
    return this;
  }
  /**
    If there is a value, apply fn to it, if not, don't.
  */
  public inline function map<U>(fn:T->U):Maybe<U>{
    return switch(this){
      case null : null;
      default : fn(this);
    }
  }
  public function defined():Bool {
    return Maybes.defined(this);
  }
  @:noUsing @:from static private inline function fromNull_A<A>(v:Null<A>):Maybe<A>{
    return new Maybe(v);
  }
  private inline function toNull_T():Null<T>{
    return this;
  }
  /**
    Unbox the maybe, only used privately so that Maybe will generally
    not unify with it's base type.
  **/
  @:noUsing private static inline function unbox<A>(v:Maybe<A>):Null<A>{
    return v==null ? null : v.toNull_T();
  }
  /**
    Takes an embedded Maybe and produces a Maybe. Mostly handwavy type
    system stuff.
  */
  static public inline function flatten<A>(v:Maybe<Maybe<A>>):Maybe<A>{
    return switch(v){
      case null : null;
      default   : v.toNull_T();
    }
  }
  /*
    Fun a function that produces a Maybe over the current value.
    Will not run if this is null
  */
  public inline function fmap<U>(fn:T->Maybe<U>):Maybe<U>{
    return flatten(map(fn));
  }
  /**
    Zip two maybes together as a Tuple2. Will only work if both
    sides are non-null.
  */
  public inline function zip<U>(that:Maybe<U>):Maybe<Tuple2<T,U>>{
    return switch([this,that]){
      case[a,b] if(a!=null && b!=null) : new Maybe(tuple2(unbox(this),unbox(that)));
      case[_,_] : null;
    }
  }
  /**
    Uses `that` as a value if `this` is null.
  */
  public inline function or(that:Maybe<T>):Maybe<T>{
    return switch(this){
      case null : that;
      default   : this;
    }
  }
  /**
    Calls function `that` if `this` is null.
  */
  public inline function orTry(that:Void->Maybe<T>):Maybe<T>{
    return switch(this){
      case null : that();
      default   : this;
    }
  }
  public inline function getOrElseC(elseVal:T):T{
    return switch(this.isDefined()){
      case true   : unbox(this);
      default     : elseVal;
    }
  }
  public inline function getOrElse(elseVal:Void->T):T{
    return switch(this.isDefined()){
      case true   : unbox(this);
      default     : elseVal();
    }
  }
  /**
    Will produce an `Option` safetly from any value.
  */
  @:to public function toOption():Option<T>{
    return switch(this){
      case null : None;
      default   : Some(cast this);
    }
  }
}