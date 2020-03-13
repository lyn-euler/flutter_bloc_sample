

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MobileVerifyBloc extends VerifyBloc {

  String mobile;

  MobileVerifyBloc():super(validateText: "请输入手机号", validateFunction: (event) {
    return event.value != null && event.value.length == 11;
  });

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) {
    mobile = event.value;
    return super.mapEventToState(event);
  }
}

class SmsCodeVerifyBloc extends VerifyBloc {
  String smsCode;

  SmsCodeVerifyBloc():super(validateText: "请输入验证码", validateFunction: (event) {
    return event.value != null && event.value.length == 6;
  });

  @override
  Stream<VerifyState> mapEventToState(VerifyEvent event) {
    smsCode = event.value;
    return super.mapEventToState(event);
  }

}

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
