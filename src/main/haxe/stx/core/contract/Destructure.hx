package stx.core.contract;

class Destructure extends Clazz{
  public function zip<Ti,Tii,E>(that:Contract<Tii,E>,self:Contract<Ti,E>):Contract<Tuple<Ti,Tii>,E>{
    var out = LiftFuture.zip(self.prj(),that.prj()).map(
      (tp) -> tp.fst().zip(tp.snd())
    );
    return out;
  }
  
  public function map<T,Ti,E>(fn:T->Ti,self:Contract<T,E>):Contract<Ti,E>{
    return self.prj().map(
      function(x){
        return switch (x){
          case Tap      : Tap;
          case Val(v)   : Val(fn(v));
          case End(err) : End(err);
    }});
  }
  public function flat_map<T,Ti,E>(fn:T->Contract<Ti,E>,self:Contract<T,E>):Contract<Ti,E>{
    var ft : Future<Chunk<T,E>> = self.prj();
    return ft.flatMap(
      function(x:Chunk<T,E>):ContractDef<Ti,E>{
        return switch (x){
          case Tap      : new Contract(Future.sync(Tap)).prj();
          case Val(v)   : fn(v).prj();
          case End(err) : Contract.fromChunk(End(err)).prj();
    }});
  }
  public function fold<T,Ti,E>(val:T->Ti,ers:Null<Err<E>>->Ti,nil:Void->Ti,self:Contract<T,E>):Future<Ti>{
    return self.prj().map(Chunk._()._.fold.bind(val,ers,nil));
  }
  public function recover<T,E>(fn:Err<E>->Chunk<T,E>,self:Contract<T,E>):Contract<T,E>{
    return fold(
      (x) -> Val(x),
      (e) -> fn(e),
      ()  -> Tap,
      self
    );
  }
  public function attempt<T,Ti,E,U>(fn:T->Chunk<Ti,E>,self:Contract<T,E>):Contract<Ti,E>{
    return fold(
      (x) -> fn(x),
      (v) -> End(v),
      ()->Tap,
      self
    );
  }
  public function receive<T,E>(fn:T->Void,self:Contract<T,E>):Future<Option<Err<E>>>{
    return self.prj().map(
      (chk) -> switch chk {
        case End(e)   : __.option(e);
        case Val(v)   : fn(v); None;
        case Tap      : None;
      }
    );
  }
  public function now<T,E>(self:Contract<T,E>):Chunk<T,E>{
    var out = null;
    self.prj().handle(
      (v) -> out = v
    );
    if(out == null){
      out = Tap;
    }
    return out;
  }
  public function errata<T,E,EE>(fn:Err<E>->Err<EE>,self:Contract<T,E>):Contract<T,EE>{
    return self.prj().map(
      (chk) -> chk.errata(fn)
    );
  }
}