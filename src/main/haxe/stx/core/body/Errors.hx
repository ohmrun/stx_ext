package stx.core.body;

class Errors{
  static public function resource_not_found(f:Fault,name:String){
    return f.because('resource: "$name" not compiled in');
  }
  static public function unexpected_iter_exhaustion(f:Fault,?pos:PosInfos){
    return f.because('iterator exhausted unexpectedly');
  }
  static public function nullError(f:Fault){
    return f.because('encountered null value');
  }
}