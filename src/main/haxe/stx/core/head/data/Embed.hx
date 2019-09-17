package stx.core.head.data;

typedef Embed<T> = {
  public function pack(v:T):Void->Void;
  public function unpack(fn:Void->Void):Option<T>;
  public function check(fn:Void->Void):Bool;
}