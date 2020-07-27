package stx.ext;

typedef SourceIdentDef = {
  var name    : StdString;
  var pack    : Array<String>;
  var module  : Option<haxe.io.Path>;
}

@:forward abstract SourceIdent(SourceIdentDef) from SourceIdentDef{
  public function new(self){
    this = self;
  }
  #if(!macro)
    @:from static public function fromPosInfos(p:PosInfos):SourceIdent{
      var seperate_extension = p.fileName.split(".")[0];
      var folders            = seperate_extension.split("/");//hmmm
      
      var class_path         = p.className.split(".");
      var class_name         = class_path.pop();

      return new SourceIdent({
        module     : new haxe.io.Path(p.fileName),
        name     : class_name,
        pack     : class_path
      });
    }
  #else
    @:from static public function fromPosition(p:Position):SourceIdent{
      #if macro 
        #if (!doc_gen)
          var module = new SourceIdent({
            name:  "*",
            pack:  [],
            module: None
          });
          return module;
        #else
          var path  = new haxe.io.Path(p.file);
          var dir   = path.dir.split(path.sep());
          var head  = path.file;
          var module = {
            name     : head,
            pack     : dir,
            module     : path
          };
          return new SourceIdent(module);
        #end
      #else
        return fromPosInfos(p);
      #end
    }
  #end
  public function eq(that:SourceIdent){
    return if(this.name!=that.name){
      false;
    }else if(this.pack.length != that.pack.length){
      false;
    }else if(
      this.module.zip(that.module)
        .map(
          (tp:Couple<haxe.io.Path,haxe.io.Path>) -> tp.decouple(
            (l,r) -> l.toString().length != r.toString().length
          )
        ).defv(false)
    ){
      false;
    }else{
      for(i in 0...this.pack.length-1){
        if(this.pack[i] != that.pack[i]){
          return false;
        }
      }
      if(__.option(this.module).is_defined() &&  __.option(that.module).is_defined()){
        var this_string = this.module.fudge().toString();
        var that_string = that.module.fudge().toString();

        for(i in 0...this_string.length){
          if(this_string.charAt(i)!= that_string.charAt(i)){
            return false;
          }
        }
      }
      true;
    }
  }
  public function toString():StdString{
    return switch([this.module,this.pack]){
      case [null,[]]  : this.name;
      case [null,arr] : 
          var next = [this.name];
          for(v in arr){
            next.push(v);
          }
          return next.join(".");
      case [md,[]]    : '$md.${this.name}';
      case [md,arr]   : '$md.${this.name}';
    }
  }
  
}