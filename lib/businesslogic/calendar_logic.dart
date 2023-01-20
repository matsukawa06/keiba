///
/// calendar に関するBusinessLogic
///

// DateTime型からYYYYMMDDの8桁のint型へ変換
int getHachCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
