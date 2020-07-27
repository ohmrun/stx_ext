package src.dev.haxe.stx.ext;

private class StateRef<S,A>{
  private var value : A;
  public function new(v:A){
    this.value = v;
  }
  public function read():State<S,A> {
    return State.pure(value);
  }
  public function write(a:A):State<S,StateRef<S,A>>{
    return function(s:S){
      this.value = a;
      return __.couple(this,s);
    }
  }
  public function modify(f:A->A):State<S,StateRef<S,A>> {
    var a = read();
    var v = a.flatMap(f.fn().then(write));
    return v;
  }
}
// private class WorldState{
//   public function new(){

//   }
// }
// class WorldStates{
//   static public function run<A>(v:State<WorldState,StateRef<WorldState,A>>){
//     return v.apply( new WorldState() );
//   }
//   static public function exec<R>(v:State<WorldState,StateRef<WorldState,R>>):WorldState{
//     return v.apply(new WorldState()).snd();
//   }
//   static public function eval<R>(v:State<WorldState,StateRef<WorldState,R>>):StateRef<WorldState,R>{
//     return v.apply(new WorldState()).fst();
//   }
// }