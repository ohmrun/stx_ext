package stx.ext.lift;

class LiftTinkPromiseToPledge{
  static public function toPledge<T,E>(promise:Promise<T>):Pledge<T,E>{
    return Pledge.fromTinkPromise(promise);
  }
}