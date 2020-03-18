package stx.core.pack;

import stx.core.head.data.Logic in LogicT;


abstract Logic<T>(LogicT<T>) from LogicT<T>{
  public function new(self){
    this = self;
  }
}