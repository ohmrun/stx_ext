package stx.core.pack.body;

class Maybes{
  public static inline function defined<T>(thiz:Maybe<T>):Bool {
   return thiz!=null;
  }
  /**
    If there is a value, apply `fn` to it and return a wrapped result if not, don't.
  */
  static public inline function map<T,U>(thiz:Maybe<T>,fn:T->U):Maybe<U>{
    return thiz.map(fn);
  }
  /**
  Applies a function that produces a Maybe over the current value.
  Will not run `fn` if `thiz` is null
  */
  static public inline function fmap<T,U>(thiz:Maybe<T>,fn:T->Maybe<U>):Maybe<U>{
    return thiz.fmap(fn);
  }
  /**
    Call f on the value, if there is one.
  */
  static public inline function each<T>(thiz:Maybe<T>,fn:T->Void):Maybe<T>{
    return thiz.each(fn);
  }
}