import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ValidateFunction = bool Function(VerifyEvent event);

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  final String validateText;
  final ValidateFunction validateFunction;

  VerifyBloc({this.validateText, @required this.validateFunction});

  @override
  // TODO: implement initialState
  VerifyState get initialState => VerifyStateInit();

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) async* {
    if (validateFunction(event)) {
      yield VerifySuccess();
    } else {
      yield VerifyFailed(validateText);
    }
  }
}

class VerifyEvent {
  final String value;

  VerifyEvent(this.value);
}

abstract class VerifyState {}

class VerifyStateInit extends VerifyState {}

class VerifySuccess extends VerifyState {}

class VerifyFailed extends VerifyState {
  final String validateText;

  VerifyFailed(this.validateText);
}
