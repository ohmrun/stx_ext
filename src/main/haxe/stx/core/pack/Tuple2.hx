package stx.core.pack;

import stx.core.pack.body.Tuple2s;
import stx.core.head.data.Tuple2 in Tuple2T;

@:forward @:callable abstract Tuple2<A,B>(Tuple2T<A,B>) from Tuple2T<A,B>{

  @:from static public function fromTinkPair<A,B>(tup:tink.core.Pair<A,B>):Tuple2<A,B>{
    return tuple2(tup.a,tup.b);
  }
  @:to public function toTinkPair():tink.core.Pair<A,B>{
    return new tink.core.Pair(fst(),snd());
  }
#if thx_core
  @:from static public function fromThxTuple2<A,B>(tup:ThxTuple2<A,B>):Tuple2<A,B>{
    return tuple2(tup._0,tup._1);
  }

  @:to public function toThxTuple2():ThxTuple2<A,B>{
    return new ThxTuple2(fst(),snd());
  }
#end

  public function new(l,r){
    this = tuple2(l,r);
  }
  /**
    Returns the value on the left hand side.
  **/
  public function fst() : A {
    return Tuple2s.fst(this);
  }
  /**
    Returns the value on the right hand side.
  **/
  public function snd() : B {
    return Tuple2s.snd(this);
  }
  /**
    Returns the value on the right hand side.
  **/
  public function swap() : Tuple2<B, A> {
    return Tuple2s.swap(this);
  }
  /**
    Equality Function.
  **/
  @:op(A == B)
  public function equals(b : Tuple2<A,B>): Bool {
    return Tuple2s.equals(this,b);
  }
  /**
    Produces an array of untyped values.
  **/
  public function toArray() : Array<Dynamic> {
    return Tuple2s.toArray(this);
  }
  /**
    Unpacks the tuple and applies the function with the internal values.
  **/
  public function into<C>(fn:A->B->C):C {
    return Tuple2s.into(this,fn);
  }
  public function map<C>(fn:B->C):Tuple2<A,C>{
    return Tuple2s.map(this,fn);
  }
  /**
    Transforms the function to receive a tuple rather than two arguments.
  **/
  public inline static function tupled<A,B,C>(f : A -> B -> C){
    return Tuple2s.tupled(f);
  }
  /**
    Transforms a function taking a tuple to one taking two arguments.
  **/
  public inline static function untupled<A,B,C>(f:Tuple2<A,B>->C):A->B->C{
    return Tuple2s.untupled(f);
  }
  //weird map
  public function wmap<C,D>(f:A->C,f0:B->D):Tuple2<C,D>{
    return tuple2(f(fst()),f0(snd()));
  }
  //fox the type system for Null<T> -> Null<T> situations
  public function mod(f:A->A,f0:B->B):Tuple2<A,B>{
    return wmap(f,f0);
  } 
}