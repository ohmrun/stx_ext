package stx.core;

@:forward abstract Ident(IdentDef) from IdentDef{
  @:from static public function fromDotPath(str:String):Ident{
    var arr = str.split(".");
    return if(arr.length == 1){
      {
        name : str,
        pack : []
      }
    }else{
      var head = arr.pop();
      {
        name : head,
        pack : arr
      }
    }
  }
  @:to public function toStructure():{name : std.String, pack : Array<std.String> }{
    var tail = [];
    for (val in this.pack){
      tail.push(val);
    }
    return { name : this.name, pack : tail };
  }
  public function canonical(){
    return this.pack.length > 0 ? this.pack.concat([this.name]).join(".") : this.name;
  }
}