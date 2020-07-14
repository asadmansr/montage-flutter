import "dart:io";

const String path = "unit_test/core/fixtures/data";

String fixture(String file) => File('$path/$file').readAsStringSync();
