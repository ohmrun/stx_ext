
using stx.Pico;
using stx.core.Pack;

class Main{
  static public function main(){
    #if test
      __.test(new stx.core.pack.Test().deliver());
    #end
  }
}