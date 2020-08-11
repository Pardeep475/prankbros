import 'dart:async';

import 'package:rxdart/rxdart.dart';

class VideoScreenBloc {
  // 0 for nothing show, 1 for play icon, 2 for pause icon
  final BehaviorSubject categoriesSearchController = BehaviorSubject<int>();

  Stream get categoriesSearchStream => categoriesSearchController.stream;

  StreamSink get categoriesSearchSink => categoriesSearchController.sink;
}
