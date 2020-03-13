import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/module/login/bloc/login_bloc.dart';
import 'package:flutter_bloc_sample/module/login/bloc/verify_bloc.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _MobileTextField(),
          _SmsCodeTextField(),
          _LoginButton()
        ],
      ),
    );
  }
}

class _MobileTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _validateText;
    return BlocListener<VerifyBloc, VerifyState>(
      bloc: BlocProvider.of<LoginBloc>(context).mobileVerifyBloc,
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
          validator: (text) {
            return _validateText;
          },
          onChanged: (text) {
            BlocProvider.of<LoginBloc>(context)
                .mobileVerifyBloc
                .add(VerifyEvent(text));
          },
          maxLength: 11,
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
    return BlocListener<VerifyBloc, VerifyState>(
      bloc: BlocProvider.of<LoginBloc>(context).smsCodeVerifyBloc,
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
          onChanged: (text) {
            BlocProvider.of<LoginBloc>(context)
                .smsCodeVerifyBloc
                .add(VerifyEvent(text));
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
      stream: BlocProvider.of<LoginBloc>(context).mobileAndCodeObservable(),
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
                  BlocProvider.of<LoginBloc>(context).add(LoginEvent());
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
