package stx.ext.head.regex.term;

//~/"([^"\\]*(\\.[^"\\]*)*)"|\\'([^\\'\\]*(\\.[^\\'\\]*)*)\\'/
abstract Requote(Regex){
  public function new(){
    this = new Regex("\"([^\"\\]*(.[^\"\\]*)*)\"|'([^\']*(.['\\]*)*)'","");    
  }
}