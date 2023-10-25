import 'package:auto_route/auto_route.dart';
import 'package:build_context_provider/build_context_provider.dart';
import 'package:flutter/material.dart';
import 'package:totalis_admin/screens/auth_page/bloc.dart';
import 'package:totalis_admin/utils/custom_stream_builder.dart';
import 'package:totalis_admin/widgets/custom_buttom.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({this.reLogin = false, super.key});

  final bool reLogin;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _bloc = LoginBloc();

  @override
  initState() {
    _bloc.init(context, widget.reLogin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStreamBuilder(
        bloc: _bloc,
        builder: (context, ScreenState state) => Scaffold(
                body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 400,
                    child: CustomButton(
                        onTap: () => _bloc.signInWithGoogle(context),
                        title: 'Login with google'),
                  ),
                ),
                const ListenerThatRunsFunctionsWithBuildContext(),
              ],
            )));
  }
}
