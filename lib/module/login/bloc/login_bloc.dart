import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/login/bloc/verify_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<AbstractLoginEvent, LoginState> {

//  static String _mobile;
//  static String _smsCode;
//
//  final mobileVerifyBloc = VerifyBloc(validateText: "请输入手机号", validateFunction: (event) {
//    _mobile = event.value;
//    return event.value != null && event.value.length == 11;
//  });
//
//  final smsCodeVerifyBloc = VerifyBloc(validateText: "请输入验证码", validateFunction: (event) {
//    _smsCode = event.value;
//    return event.value != null && event.value.length == 6;
//  });


//  Stream<bool> mobileAndCodeObservable() => ;

  @override
  LoginState get initialState => LoginInit(null);

  @override
  Stream<LoginState> mapEventToState(AbstractLoginEvent event) async* {
    if (event is LogoutEvent) {
      yield LoginInit(null);
    }else if(event is LoginEvent) {
      yield LoginSuccess("token");
    }
  }
}

abstract class AbstractLoginEvent {
}

class LoginEvent extends AbstractLoginEvent {
  final String mobile;
  final String smsCode;
  LoginEvent(this.mobile, this.smsCode);
  @override
  String toString() => "{mobile: $mobile, smsCode: $smsCode}";
}

class LogoutEvent extends AbstractLoginEvent {}



abstract class LoginState{}

class LoginInit extends LoginState {
  final String token;
  LoginInit(this.token);
}

class LoginSuccess extends LoginState {
  final String token;
  LoginSuccess(this.token);
}

class LoginFailed extends LoginState {
  final String errorMsg;
  LoginFailed(this.errorMsg);
}