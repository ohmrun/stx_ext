package stx.core;

@:forward abstract Declare<Subject,Verb,Object>(DeclareDef<Subject,Verb,Object>) from DeclareDef<Subject,Verb,Object> to DeclareDef<Subject,Verb,Object>{
  public function new(self) this = self;
  static public function lift<Subject,Verb,Object>(self:DeclareDef<Subject,Verb,Object>):Declare<Subject,Verb,Object> return new Declare(self);
  static public function make<Subject,Verb,Object>(brand,media,union):Declare<Subject,Verb,Object>{
    return lift({
      brand:brand,
      media:media,
      union:union
    });
  }
  public function copy(?brand:Subject,?media:Verb,?union:Object){
    return make(
      __.option(brand).defv(this.brand),
      __.option(media).defv(this.media),
      __.option(union).defv(this.union)
    );
  }
  

  public function prj():DeclareDef<Subject,Verb,Object> return this;
  private var self(get,never):Declare<Subject,Verb,Object>;
  private function get_self():Declare<Subject,Verb,Object> return lift(this);
}
private class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();

  public function lift<Subject,Verb,Object>(self:DeclareDef<Subject,Verb,Object>):Declare<Subject,Verb,Object>{
    return new Declare(self);
  }
  public function make<Subject,Verb,Object>(brand:Subject,media:Verb,union:Object):Declare<Subject,Verb,Object>{
    return lift({ brand : brand, media : media, union : union });
  }
  public function copy<Subject,Verb,Object>(?brand,?media,?union,self:Declare<Subject,Verb,Object>){
    return make(
      __.option(brand).defv(self.brand),
      __.option(media).defv(self.media),
      __.option(union).defv(self.union)
    );
  }
}