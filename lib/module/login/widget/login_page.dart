import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_sample/module/login/bloc/verify_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: _LoginWidget(),
    );
  }
}

class _LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      autovalidate: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MobileVerifyBloc>(
            create: (context) => MobileVerifyBloc(),
          ),
          BlocProvider<SmsCodeVerifyBloc>(
            create: (context) => SmsCodeVerifyBloc(),
          ),
        ],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _MobileTextField(),
            _SmsCodeTextField(),
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _MobileTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _validateText;
    return BlocListener<MobileVerifyBloc, VerifyState>(
      listener: (context, state) {
        if (state is VerifyFailed) {
          _validateText = state.validateText;
        } else {
          _validateText = null;
        }
      },
      child: Padding(
        padding: EdgeInsets.all(20),
        child: TextFormField(
          keyboardType: TextInputType.phone,
          validator: (text) {
            return _validateText;
          },
          onChanged: (text) {
            BlocProvider.of<MobileVerifyBloc>(context).add(VerifyEvent(text));
          },
          maxLength: 11,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            icon: Icon(Icons.phone),
            labelText: '手机号',
            helperText: '',
          ),
        ),
      ),
    );
  }
}

class _SmsCodeTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _validateText;

    return BlocListener<SmsCodeVerifyBloc, VerifyState>(
      listener: (context, state) {
        if (state is VerifyFailed) {
          _validateText = state.validateText;
        } else {
          _validateText = null;
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
        child: TextFormField(
          validator: (text) => _validateText,
          keyboardType: TextInputType.number,
          enableInteractiveSelection: false,
          onChanged: (text) {
            BlocProvider.of<SmsCodeVerifyBloc>(context).add(VerifyEvent(text));
          },
          maxLength: 6,
          decoration: InputDecoration(
            icon: Icon(Icons.sms),
            labelText: '验证码',
            helperText: '',
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Rx.combineLatest2(BlocProvider.of<MobileVerifyBloc>(context),
          BlocProvider.of<SmsCodeVerifyBloc>(context), (mState, sState) {
        return (mState is VerifySuccess && sState is VerifySuccess);
      }),
      builder: (context, snapshot) {
        return Container(
          width: double.maxFinite,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: RaisedButton(
//                  disabledElevation: 1,
              color: (snapshot.data ?? false) ? Colors.blue : Colors.grey,
              onPressed: () {
                if (snapshot.data ?? false) {
                  final mobile = BlocProvider.of<MobileVerifyBloc>(context).mobile;
                  final smsCode = BlocProvider.of<SmsCodeVerifyBloc>(context).smsCode;
                  BlocProvider.of<LoginBloc>(context).add(LoginEvent(mobile, smsCode));
                }
              },
              child: Text(
                '登 录',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
}
