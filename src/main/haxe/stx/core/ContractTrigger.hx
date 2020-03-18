package stx.core;

@:forward(trigger) abstract ContractTrigger<T,E>(FutureTrigger<Chunk<T,E>>) from FutureTrigger<Chunk<T,E>>{
  public function new(){
    this = new FutureTrigger();
  }
  public function asContract():Contract<T,E>{
    return this.asFuture();
  }
}