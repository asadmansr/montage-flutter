import 'package:flutter_test/flutter_test.dart';
import 'package:montageapp/core/use_case/params.dart';

import '../dataset/test_data.dart';

void main() {
  test('Should return a valid params with user attribute', () {
    final result = Params(user: tUserA);
    expect(result.user, tUserA);
    expect(result.props, [tUserA]);
  });
}
