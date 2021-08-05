import 'package:flutter_practice/redux/models/models.dart';
import 'package:flutter_practice/redux/reducers/test_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    reduxSetup: testReducer(state.reduxSetup, action),
    testList: testReducer1(state.testList, action),
  );
}
