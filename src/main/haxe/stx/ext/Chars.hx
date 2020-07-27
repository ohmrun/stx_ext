package stx.ext;


@:using(stx.ext.Chars.CharsLift)
@:forward abstract Chars(StdString) from StdString to StdString{
  static public var _(default,never) = CharsLift;
  private function new(self) this = self;

  public function char(int:Int):Char{
    return new Char(this.charAt(int));
  }
  @:op(A + A)
  public function add(that:Chars){
    return this + that;
  }
}
class CharsLift{
  /**
  Returns `true` if `v` is `'true'` or `'1'`, `false` if `'false'` or `'0'` and `d` otherwise.
**/
public function parse_bool(self: Chars): Option<Bool> {
  var vLower = self.toLowerCase();

  return switch([vLower,self]){
    case ['false',_] | [_,'0']  : Some(false);
    case ['true',_] | [_,'1']   : Some(true);
    default                     : None;
  }
}

public function parse_int(self: Chars):Option<Int> {
  return 
    __.option(std.Std.parseInt(self))
      .filter(function(i) return !Math.isNaN(i));
}
public function parse_float(self: Chars):Option<Float> {
  return 
    __.option(std.Std.parseFloat(self))
   .filter(function(i) return !Math.isNaN(i));
}
/**
  Returns `true` if `frag` is at the beginning of `v`, `false` otherwise.
**/
public function starts_with(self: Chars,frag: Chars): Bool {
  return if (self.length >= frag.length && frag == self.substr(0, frag.length)) true else false;
}
/**
  Returns `true` if `frag` is at the end of `v`, `false` otherwise.
**/
public function ends_with(self: Chars,frag: Chars): Bool {
  return if (self.length >= frag.length && frag == self.substr(self.length - frag.length)) true else false;
}
/**
  Returns true if v contains s, false otherwise.
**/
public function contains(self: Chars,substr: Chars): Bool {
  return self.indexOf(substr) != -1;
}
/**
  Returns a Chars where sub is replaced by by in s.
**/
public function replace(self : Chars,sub : Chars, by : Chars) : Chars {
  return StringTools.replace(self, sub, by);
}
/**
  Surrounds `v`, prepending `l` and concating `r`.
**/
public function brackets(self:Chars,l:Chars,r:Chars){
  return '$l$self$r';
}
/**
  prepend `before` on `str.`
**/
public function prepend(self:Chars,before:Chars){
  return before + self;
}
/**
  concat `before` on `str.`
**/
public function append(self:Chars,after:Chars){
  return self + after;
}
/**
  Get character code from `str` at index `i`.
**/
public function cca(self:Chars,i:Int){
  return self.charCodeAt(i);
}
public function at(self:Chars,i:Int):Chars{
  return self.charAt(i);
}
/**
  Returns an Array of `str` divided into sections of length `len`.
**/
public function chunk(self: Chars,len: Int = 1): Array<Chars> {
  var start = 0;
  var end   = Math.round(Math.min(start + len,self.length));

  return if (end == 0) [];
   else {
     var prefix = self.substr(start, end);
     var rest   = self.substr(end);

     [prefix].concat(chunk(rest,len));
   }
}
/**
  Returns an Array of the characters of `str`.
**/
public function chars(self: Chars): Array<Chars> {
  var a = [];

  for (i in 0...self.length) {
    a.push(self.charAt(i));
  }

  return a;
}
/**
  Turns a slugged or underscored string into a camelCase string.
**/
// public function toCamelCase(self: Chars): Chars {
//   return SepAlphaPattern.map(self, function(e) { return e.matched(2).toUpperCase(); });
// }
/**
  Replaces uppercased letters with prefix `sep` + lowercase.
**/
// public function fromCamelCase(sep: Chars="_",self: Chars): Chars {
//   return AlphaUpperAlphaPattern.map(self, function(e) { return e.matched(1) + sep + e.matched(2).toLowerCase(); });
// }
/**
  Split `st` at `sep`.
**/
public function split(self:Chars,sep:Chars):Array<Chars>{
  return self.split(sep);
}
/**
  Strip whitespace out of a string.
**/
public function strip_white( self : Chars ) : Chars {
  var l = self.length;
  var i = 0;
  var sb = new StringBuf();
  while( i < l ) {
    if(!is_space(self,i))
      sb.add(self.charAt(i));
    i++;
  }
  return sb.toString();
}
/**
  Continues to replace `sub` with `by` until no more instances of `sub` exist.
**/
public function replace_recurse( self : Chars, sub : Chars, by : Chars ) : Chars {
  if(sub.length == 0)
    return replace(self, sub, by);
  if(by.indexOf(sub) >= 0)
    throw "Infinite recursion";
  var ns : Chars = self.toString();
  var olen = 0;
  var nlen = ns.length;
  while(olen != nlen) {
    olen = ns.length;
    replace(  sub, by, ns );
    nlen = ns.length;
  }
  return ns;
}
/**
  Returns an iterator of `value`.
**/
public function iterator(self : Chars) : Iterator<Chars> {
  var index = 0;
  return {
      hasNext: function() {
          return index < self.length;
      },
      next: function() {
          return if (index < self.length) {
              self.substr(index++, 1);
          } else {
            throw __.fault().of(E_IndexOutOfBounds);
          }
      }
  };
}
/*
public function camelCaseToDashes(value : Chars) : Chars {
  var regexp = new EReg("([a-zA-Z])(?=[A-Z])", "g");
  return regexp.replace(value, "$1-");
}

public function camelCaseToLowerCase(value : Chars, ?separator : Chars = "_") : Chars {
  var reg = new EReg("([^\\A])([A-Z])", "g");
  return reg.replace(value, '$1${separator}$2').toLowerCase();
}
public function camelCaseToUpperCase(value : Chars, ?separator : Chars = "_") : Chars {
  var reg = new EReg("([^\\A])([A-Z])", "g");
  return reg.replace(value, '$1${separator}$2').toUpperCase();
}*/
public function is_space(self : Chars, pos : Int ) : Bool {
  var c = self.charCodeAt( pos );
  return (c >= 9 && c <= 13) || c == 32;
}
public inline function chr(i:Int){
  return String.fromCharCode(i);
}
@thx
public function underscore(s : Chars):Chars {
  s = (~/::/g).replace(s, '/');
  s = (~/([A-Z]+)([A-Z][a-z])/g).replace(s, '$1_$2');
  s = (~/([a-z\d])([A-Z])/g).replace(s, '$1_$2');
  s = (~/-/g).replace(s, '_');
  return s.toLowerCase();
}
/**
 * Returns all characters from a that appear after the first occurence of sub, or,
 * if sub does not occur in a, empty string.
 **/
public function after(self: Chars,sub: Chars): Chars {
  var idx = self.indexOf(sub);
  if (idx < 0) return "";
  return self.substring(idx + sub.length, self.length);
}
/**
 * Returns all characters from a that appear before the first occurence of sub, or,
 * if sub does not occur in a, empty string.
 **/
public function before(self: Chars,sub: Chars): Chars {
  return self.substring(0, self.indexOf(sub));
}
public function quote(str:Chars):Chars{
  return '\"$str\"';
}
public function requote(str:Chars):Chars{
  return str.replace("\"","\\\"");
}
}