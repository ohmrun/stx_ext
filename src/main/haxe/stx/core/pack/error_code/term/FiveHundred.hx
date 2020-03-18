package stx.core.pack.error_code.term;

abstract FiveHundred(ErrorCode) to ErrorCode{
  public function new() this = new ErrorCode(500);
}