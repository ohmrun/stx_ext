package stx.core.lift;
class LiftFunXRToGenerator{
  static public function toGenerator<A>(fn : Void -> Option<A>):Iterable<A>{
    return Generator.yielding(fn);
  }
}