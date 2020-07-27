package stx.core.lift;

class LiftDynamicAccessToArrayKV{
  static public function toIter<T>(obj:DynamicAccess<T>):Array<KV<String,T>>{
    var arr = [];
    for(key => val in obj){
      var kv = KV.fromObj(
        {
          key : key,
          val : val
        }
      );
      arr.push(kv);
    }
    return arr;
  }
}