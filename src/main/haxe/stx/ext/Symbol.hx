package stx.ext;

interface SymbolApi{
  @:isProp public var id(get,set) : ID;
  private function get_id():ID;
  private function set_id(str:ID):ID;
}

abstract Symbol(SymbolApi) from SymbolApi{
  
}