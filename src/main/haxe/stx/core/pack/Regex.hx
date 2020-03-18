package stx.core.pack;

import stx.core.type.Regex in RegexT;

abstract Regex(RegexT) from RegexT to RegexT{
  public function new(self) this = self;
  static public function lift(self:RegexT):Regex return new Regex(self);
  static public function make(source:String,option:String) return new RegexT(source,option);


  public function prj():RegexT return this;
  private var self(get,never):Regex;
  private function get_self():Regex return lift(this);
}