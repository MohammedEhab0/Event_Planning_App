import 'package:event_planning_app/UI/Login/LoginNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modal/MyUser.dart';
import '../../Providers/EventListProvider.dart';
import '../../Providers/UserProvider.dart';
import '../../Utils/FireBaseUtils.dart';

class LoginViewModel extends ChangeNotifier{
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController =
  TextEditingController(text: 'mo@mo.com');
  TextEditingController passwordController =
  TextEditingController(text: '123456');
  late  LoginNavigator loginNav ;
  login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      loginNav.showLoading( message: '...Loading');
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        MyUser? user= await FireBaseUtils.readUserFromFireStore(credential.user?.uid??'');
        if(user == null){
          return;
        }
        var userProvider=Provider.of<UserProvider>(context,listen: false);
        userProvider.updateUser(user);
        var eventListProvider=Provider.of<EventListProvider>(context,listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getFavoriteEvents( userProvider.currentUser!.id);
       loginNav.hideLoading();
       loginNav.showMessage(message: 'Login successfully');

        print('Login successfully ');
        print(credential.user?.uid ?? "");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          loginNav.hideLoading();
          loginNav.showMessage(message: 'Login faild ');

          print('No user found for that email.');
        } else if (e.code == 'invalid-credential') {
          loginNav.hideLoading();
          loginNav.showMessage(message: 'Login faild ');
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        loginNav.hideLoading();
        loginNav.showMessage(message: 'Login faild ');
        print('Error: $e');
      }
    }
  }

}