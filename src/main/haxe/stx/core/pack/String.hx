package stx.core.pack;

@:forward abstract String(stx.alias.StdString) from stx.alias.StdString to stx.alias.StdString{
  public function new(self) this = self;
}