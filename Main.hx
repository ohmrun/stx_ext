
using stx.Pico;
using stx.Core;

class Main{
  static public function main(){
    #if test
      __.test(new stx.core.Test().deliver());
    #end
  }
}