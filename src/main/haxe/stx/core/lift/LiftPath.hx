package stx.core.lift;

class LiftPath{
  static public function sep(path:haxe.io.Path):String{
    return path.backslash ? "\\" : "/";
  }
  static public function split(path:haxe.io.Path):Array<String> {
    return path.toString().split(path.sep());
  }
}