package stx.core.type;

typedef DeclareDef<Subject,Verb,Object> = {
  public var union(default,null):Object;
} & stx.core.type.ClauseDef<Subject,Verb>;