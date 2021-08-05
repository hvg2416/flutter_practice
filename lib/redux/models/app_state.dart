import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool reduxSetup;
  final List testList;

  const AppState({
    @required this.reduxSetup,
    @required this.testList,
  });

  @override
  String toString() {
    return 'AppState: { reduxSetup: $reduxSetup, testList: $testList }';
  }
}
