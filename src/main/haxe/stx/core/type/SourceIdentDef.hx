package stx.core.type;

typedef SourceIdentDef = {
  var name    : StdString;
  var pack    : Array<String>;
  var module  : Option<haxe.io.Path>;
}