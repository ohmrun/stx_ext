package stx.core.pack.chars;

class Implementation{
  static public inline function _() return Constructor.ZERO._;

  static public function parse_bool(self: Chars)                                return _().parse_bool(self);
  static public function parse_int(self: Chars)                                           return _().parse_int(self);
  static public function parse_float(self: Chars)                                         return _().parse_float(self);
  static public function starts_with(self: Chars,frag: Chars): Bool                       return _().starts_with(frag,self);
  static public function ends_with(self: Chars,frag: Chars): Bool                         return _().ends_with(frag,self);
  static public function contains(self: Chars,substr: Chars): Bool                        return _().contains(substr,self);
  static public function replace(self : Chars,sub : Chars, by : Chars) : Chars            return _().replace(sub,by,self);
  static public function brackets(self:Chars,l:Chars,r:Chars)                             return _().brackets(l,r,self);
  static public function prepend(self:Chars,before:Chars)                                 return _().prepend(before,self);
  static public function append(self:Chars,after:Chars)                                   return _().append(after,self);
  static public function cca(self:Chars,i:Int)                                            return _().cca(i,self);
  static public function at(self:Chars,i:Int):Chars                                       return _().at(i,self);
  static public function chunk(self: Chars,len: Int = 1)                                  return _().chunk(len,self);
  static public function chars(self: Chars): Array<Chars>                                 return _().chars(self);
  //static public function toCamelCase(self: Chars): Chars                                  return _().toCamelCase(self);
  //static public function fromCamelCase(self: Chars,sep: Chars="_"): Chars                 return _().fromCamelCase(sep,self);
  static public function split(self:Chars,sep:Chars):Array<Chars>                         return _().split(sep,self);
  static public function strip_white( self : Chars ) : Chars                              return _().strip_white(self);
  static public function replace_recurse(self : Chars, sub : Chars, by : Chars ) : Chars  return _().replace_recurse(sub,by,self);
  static public function iterator(self : Chars) : Iterator<Chars>                         return _().iterator(self);
  static public function is_space(self : Chars,pos : Int) : Bool                          return _().is_space(pos,self);
  static public function underscore(self : Chars):Chars                                   return _().underscore(self);
  static public function after(self: Chars, sub: Chars): Chars                            return _().after(sub,self);
  static public function before(self: Chars, sub: Chars): Chars                           return _().before(sub,self);
  static public function quote(self:Chars):Chars                                          return _().quote(self);
  static public function requote(self:Chars):Chars                                        return _().requote(self);
}