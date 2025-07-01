import 'package:event_planning_app/UI/Register/RegisterNavigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modal/MyUser.dart';
import '../../Providers/EventListProvider.dart';
import '../../Providers/UserProvider.dart';
import '../../Utils/FireBaseUtils.dart';
import '../HomeScreen/HomeScreen.dart';

class RegisterViewModel extends ChangeNotifier {
  var nameController = TextEditingController(text: 'moooooo');
  var emailController = TextEditingController(text: 'mo11@mo.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');
  var formKey = GlobalKey<FormState>();
  late RegisterNavigator registerNavigator;

  register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      registerNavigator.showLoading( message:'...Waiting ');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FireBaseUtils.addUserToFireStore(myUser);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        var eventListProvider =
            Provider.of<EventListProvider>(context, listen: false);
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);
        eventListProvider.getFavoriteEvents(userProvider.currentUser!.id);
        registerNavigator.hideLoading();
        registerNavigator.showMessage(message: 'Register successfully');
        Navigator.of(context).pushNamedAndRemoveUntil(
          HomeScreen.routeName,
              (Route<dynamic> route) => false,
        );
        print('Register successfully: ${credential.user?.uid}');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          registerNavigator.hideLoading();
          registerNavigator.showMessage(message: 'The account already exists for that email.');
          print('FirebaseAuthException: ${e.message}');
          print('The account already exists for that email.');
        } else {
          registerNavigator.hideLoading();
          registerNavigator.showMessage(message: 'Register faild ');
          print('FirebaseAuthException: ${e.message}');
        }
      } catch (e) {
        registerNavigator.hideLoading();
        registerNavigator.showMessage(message: 'Register faild ');

        print('Error: $e');
      }
    }
  }
}
