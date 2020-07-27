package stx.ext.lift;
class LiftFunXRToGenerator{
  static public function toGenerator<A>(fn : Void -> Option<A>):Iterable<A>{
    return Generator.yielding(fn);
  }
}