package stx.core.head.regex.term;

//~/"([^"\\]*(\\.[^"\\]*)*)"|\\'([^\\'\\]*(\\.[^\\'\\]*)*)\\'/
abstract Requote(Regex){
  public function new(){
    this = new Regex("\"([^\"\\]*(.[^\"\\]*)*)\"|'([^\']*(.['\\]*)*)'","");    
  }
}