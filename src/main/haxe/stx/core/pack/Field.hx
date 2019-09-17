package stx.core.pack;

@:forward abstract Field<V>(KV<String,V>) from KV<String,V> to KV<String,V>{
  public function new(self:KV<String,V>) this = self;
  @:noUsing @:from static public function fromTup<V>(tp:Tuple2<String,V>):Field<V>{
    return new Field({ key : tp.fst(), val : tp.snd()});
  }
  static public function create<V>(key:String,val:V){
    return new Field({
      key : key,
      val : val
    });
  }
  public function map<U>(fn:V->U):Field<U>{
    return this.map(fn);
  }
  public function into<R>(fn:String->V->R):R{
    return fn(this.key,this.val);
  }
  public function toTuple():Tuple2<String,V>{
    return tuple2(this.key,this.val);
  }
}