package stx.core.body;

class Options {
   @:noUsing static public function wfold<T,U>(option:Option<T>,ok:T->U,no:Void->U):U{
    var ou : Option<U> = option.map(ok);
    return def(ou,no);
  }
  @:noUsing static public inline function option<T>(?v:Null<T>):Option<T>{
    return Options.create(v);
  }
  @:noUsing static public function ensure<T>(opt:Option<T>,?err):T{
    return switch(opt){
      case Some(v)  : v;
      case None     : throw err == null ? new Error(410,'Option Undefined') : err;
    }
  }
  @:noUsing static public function release<T>(opt:Option<T>):Null<T>{
    return switch (opt) {
      case Some(v)  : v;
      case None     : null;
    }
  }
  /**
		Produces Option.Some(t) if `t` is not null, Option.None otherwise.
	**/
  @:noUsing static public inline function create<T>(t: T): Option<T> {
    return if (t == null) None; else Some(t);
  }
  /**
		Performs `f` on the contents of `o` if o != None
	**/
  @:noUsing static public function map<T, S>(o: Option<T>, f: T -> S): Option<S> {
    return switch (o) {
      case None   : None;
      case Some(v): Some(f(v));
    }
  }
  /**
		Performs `f` on the contents of `o` if `o` != None
	**/
  @:noUsing static public function each<T>(o: Option<T>, f: T -> Void): Option<T> {
    return switch (o) {
      case None     : o;
      case Some(v)  : f(v); o;
    }
  }
  /**
		Produces the result of `f` which takes the contents of `o` as a parameter.
	**/
  @:noUsing static public function fmap<T, S>(o: Option<T>, f: T -> Option<S>): Option<S> {
    return flatten(map(o, f));
  }
  /**
		Produces the value of `o` if not None, the result of `thunk` otherwise.
	**/
  @:noUsing static public function def<T>(o: Option<T>, ?thunk: Void->T): T {
    return switch(o) {
      case None:
        if(
          thunk == null
        ){
          thunk = function(){
            throw "Unspecified value and default Projection not defined";
            return null;
          }
        } 
        thunk();
      case Some(v): v;
    }
  }
  /**
		Produces `o1` if it is Some, the result of `thunk` otherwise.
	**/
  @:noUsing static public function or<T>(o1: Option<T>, thunk: Void -> Option<T>): Option<T> {
    return switch (o1) {
      case None: thunk();

      case Some(_): o1;
    }
  }
	/**
		Produces an Array of length 0 if `o` is None, length 1 otherwise.
	**/
  @:noUsing static public function toArray<T>(o: Option<T>): Array<T> {
    return switch (o) {
      case None:    [];
      case Some(v): [v];
    }
  }
  /**
		Produces an Option where `o1` may contain another Option.
	**/
  @:noUsing static public function flatten<T>(o1: Option<Option<T>>): Option<T> {
    return switch (o1) {
      case None: None;
      case Some(o2): o2;
    }
  }
  @:noUsing static public function filter<T>(o:Option<T>,fn:T->Bool):Option<T>{
    return fmap(o,
      (v) -> fn(v) ? Some(v) : None
    );
  }
  /**
		Produces a Tuple2 of `o1` and `o2`.
	**/
  @:noUsing static public function zip<T, S>(o1: Option<T>, o2: Option<S>):Option<Tuple2<T,S>> {
    return switch (o1) {
      case None     : None;
      case Some(v1) : o2.map(tuple2.bind(v1));
    }
  }
  /**
		Produces one or other value if only one is defined, or calls `fn` on the two and returns the result
	**/
  @:noUsing static public function merge<A>(o1:Option<A>,o2:Option<A>,fn : A -> A -> A):Option<A>{
    return zip(o1,o2).map(
      (tp) -> tp.into(fn)
    ).or(()->o1).or(()->o2);
  }
}
