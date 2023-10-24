import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:totalis_admin/api/admin/dto.dart';
import 'package:totalis_admin/api/admin/request.dart';
import 'package:totalis_admin/api/request.dart';
import 'package:totalis_admin/api/user/request.dart';
import 'package:totalis_admin/routers/routes.dart';
import 'package:totalis_admin/utils/bloc_base.dart';

class LoginBloc extends BlocBaseWithState<ScreenState> {
  @override
  ScreenState get currentState => super.currentState!;
  final Request _request = Request();
  final GoogleSignIn? googleSignIn = GoogleSignIn();
  final UserRequest _userRequest = UserRequest();

  LoginBloc() {
    setState(ScreenState());
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    await googleSignIn?.currentUser?.clearAuthCache();
    final GoogleSignInAccount? googleUser = await googleSignIn?.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final credentialResult =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final idToken = await credentialResult.user?.getIdToken();
    await _request.setTokenId(idToken);

    final alreadyLoggedIn = await _userRequest.getAll();
    if (alreadyLoggedIn != null) {
      if (context.mounted) context.router.push(const MainRoute());
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Contact the main admin')));
      }
      return;
      // final newUser = await _adminRequest.create(AdminRequestModel(
      //     name: credentialResult.user!.displayName,
      //     mail: credentialResult.user!.email,
      //     firebase_uid: credentialResult.user?.uid,
      //     enabled: false,
      //     super_admin: false));
      // if (newUser == null) {
      //   return;
      // } else {
      //   if (context.mounted) context.router.push(const MainRoute());
      //   _adminRequest.setAdminToLocal(newUser);
      // }
    }
    // final newUser = await _adminRequest.create(AdminRequestModel(
    //     name: credentialResult.user!.displayName,
    //     mail: credentialResult.user!.email,
    //     firebase_uid: credentialResult.user?.uid));
    // final newUser = await _userRequest.createUser(UserRequestModel(
    //     name: 'pavlo',
    //     mail: 'asasasdasd@sadasd.sds',
    //     firebase_uid: 'asdasdasdasdasdasd'));

    // if (newUser == null) {
    //   return;
    // } else {
    //   if (context.mounted) context.router.push(const MainRoute());
    //   _adminRequest.setAdminToLocal(newUser);
    // }
  }

  Future<void> init(BuildContext context) async {
    // await FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser != null) {
      if (context.mounted) context.router.push(const MainRoute());
    }
  }
}

class ScreenState {
  final bool loading;

  ScreenState({this.loading = false});

  ScreenState copyWith({bool? loading}) {
    return ScreenState(loading: loading ?? this.loading);
  }
}
