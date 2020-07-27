using stx.Pico;
using stx.Nano;
using stx.Std;

class Main{
  static public function main(){
    #if test
      __.test(new stx.ext.Test().deliver());
    #end
  }
}