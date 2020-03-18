package stx.core;

import haxe.macro.Context;
import haxe.macro.Expr;

import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

using stx.core.Lift;

class Plugin{
  static public macro function use(){
    var cwd = Sys.getCwd();
    var sep = cwd.sep();
    var lib = '${cwd}haxelib.json';
    var val = "";

    if(FileSystem.exists(lib)){
      try{
        var str : Dynamic= haxe.Json.parse(File.getContent(lib)).name;
            val = str;
      }catch(e:Dynamic){
        haxe.macro.Context.warning(Std.string(e),haxe.macro.Context.currentPos());
      }
    }
    var kind  = TDAbstract(TPath({ name : "String", pack : []}),[],[TPath({ name : "String", pack : []})]);
    var expr  = macro this = $v{val};
    var field : Field = {
      pos     : Context.currentPos(),
      name    : "new",
      access  : [APublic],
      kind  : FFun({
        args  : [],
        ret   : null,
        expr  : expr
      })
    };

    var type : TypeDefinition = {
      name    : "Name",
      pack    : ["stx","env","haxelib"],
      kind    : kind,
      pos     : Context.currentPos(),
      fields  : [field]
    };
    Context.defineType(type);
    return macro {};
  }
}