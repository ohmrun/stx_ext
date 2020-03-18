package stx.core;

@:forward abstract Clause<Subject,Verb>(ClauseDef<Subject,Verb>) from ClauseDef<Subject,Verb> to ClauseDef<Subject,Verb>{
  public function new(self) this = self;
  static public inline function _() return Constructor.ZERO;
  
  static public function lift<Subject,Verb>(self:ClauseDef<Subject,Verb>):Clause<Subject,Verb> return new Clause(self);
  static public function make<Subject,Verb>(brand:Subject,media:Verb){
    return lift({
      brand:brand,
      media:media
    });
  }
  public function copy(?brand,?media){
    return make(
      __.option(brand).defv(this.brand),
      __.option(media).defv(this.media)
    );
  }

  public function prj():ClauseDef<Subject,Verb> return this;
  private var self(get,never):Clause<Subject,Verb>;
  private function get_self():Clause<Subject,Verb> return lift(this);
}
private class Constructor extends Clazz{
  static public var ZERO(default,never) = new Constructor();
  static public var _ = new Destructure();
  static public function lift<Subject,Verb>(clause:ClauseDef<Subject,Verb>):Clause<Subject,Verb>{
    return new Clause(clause);
  }
  @:noUsing static public function make<Subject,Verb>(brand:Subject,media:Verb):Clause<Subject,Verb>{
    return lift({ brand : brand, media : media });
  }
}
private class Destructure extends Clazz{

  public function copy<Subject,Verb>(?brand,?media,self:Clause<Subject,Verb>){
    return Clause.make(
      __.option(brand).defv(self.brand),
      __.option(media).defv(self.media)
    );
  }
}