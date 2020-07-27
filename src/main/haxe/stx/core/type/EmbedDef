package stx.core.type;

typedef EmbedDef<T> = {
  public function pack(v:T):Void->Void;
  public function unpack(fn:Void->Void):Option<T>;
  public function pull(fn:Void->Void):T;
  public function check(fn:Void->Void):Bool;
}