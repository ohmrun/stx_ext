package stx.core;

typedef UniqueT<T> = {
  public var data(default,null) : T;
  public var rtid(default,null) : Void->Void;
}

/**
  You can get around it, of course, but the identity is held within here.
**/
@:forward abstract Unique<T>(UniqueT<T>){
  private function new(self) this = self;
  static public function lift<T>(self:UniqueT<T>):Unique<T> return new Unique(self);
  static public function pure<T>(data:T):Unique<T> return make(data,()->{});
  static private function make<T>(data:T,rtid:Void->Void){
    return lift({
      data : data,
      rtid : rtid
    });
  }
  

  private function prj():UniqueT<T> return this;
  private var self(get,never):Unique<T>;
  private function get_self():Unique<T> return lift(this);

  public function equals(that:Unique<T>){
    return this.rtid == that.rtid;
  }
  @:to public function toT():T{
    return this.data;
  }
}