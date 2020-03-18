package stx.core.type;

class MatchApi extends RegexApi{
  public var target(default,null):String;
  public var status(default,null):Bool;

  public function new(source,option,target){
    super(source,option);
    this.target   = target;
    this.state    = new EReg(source,option);
    this.status   = this.state.match(target);
  }
  // public function iterator(){
  //   var idx = 1;
  //   var val = null;
  //   return {
  //     next : function(){
  //       return val;
  //     },
  //     hasNext : function(){
  //       var ok = true;
  //       try{
  //         val = this.state.matc
  //       }
  //     }
  //   }
  // }

  private var state              : EReg;
}