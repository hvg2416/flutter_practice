import 'package:flutter_practice/redux/actions/actions.dart';
import 'package:redux/redux.dart';

final testReducer = TypedReducer<bool, TestAction>(_testActionReducer);

bool _testActionReducer(bool state, TestAction action) {
  return action.testPayload;
}

final testReducer1 = TypedReducer<List, TestAction1>(_testActionReducer1);

List _testActionReducer1(List state, TestAction1 action) {
  return action.testPayload;
}
