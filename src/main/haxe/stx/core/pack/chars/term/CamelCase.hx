package stx.core.head.string.term;

import stx.core.alias.StdString in CamelCaseT;

abstract CamelCase(CamelCaseT) from CamelCaseT to CamelCaseT{
  public function new(self) this = self;
  static public function lift(self:CamelCaseT):CamelCase return new CamelCase(self);
  

  

  public function prj():CamelCaseT return this;
  private var self(get,never):CamelCase;
  private function get_self():CamelCase return lift(this);
}