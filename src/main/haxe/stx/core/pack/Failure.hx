package stx.core.pack;

import stx.core.pack.body.Failures;
import stx.core.head.data.Failure in FailureT;

abstract Failure<T>(FailureT<T>) from FailureT<T>{
  public function toEarliestArray(){
    return Failures.toEarliestArray(this);
  }
}