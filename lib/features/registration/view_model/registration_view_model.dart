
import 'package:clarity_mirror/features/registration/models/registration_entity.dart';
import 'package:clarity_mirror/features/registration/models/registration_model.dart';
import 'package:clarity_mirror/features/registration/repository/registration_repository.dart';
import 'package:clarity_mirror/features/signin/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../utils/common_widgets/custom_alert_dialog.dart';

class RegistrationViewModel extends ChangeNotifier {
  /// Instance created [logger] for logging the data in console for debugging
  Logger logger = Logger();

  /// Initializing the [RegistrationRepository] class for making and interacting with network layer
  ///
  final RegistrationRepository _registrationRepository = RegistrationRepository();

  /// Registration response will be persist in the [registrationResponseModel] variable globally
  /// through provider state management technique
  /// for utilising in the UI screen and through out the application if required
  ///
  RegistrationResponseModel? registrationResponseModel;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();

  String? userNameError;
  String? userMobileError;
  String? userEmailError;
  String? userPasswordError;
  String? userReEnterPasswordError;


  /// function to validate the user password
  validatePassword(String value) {
    if(value.isEmpty) {
      userPasswordError = 'User password should not be empty';
      notifyListeners();
      return;
    }else if(value.length < 6) {
      userPasswordError = 'password should be greater than 6 characters';
      notifyListeners();
      return;
    }else {
      userPasswordError = null;
      notifyListeners();
    }
  }

  /// function to validate the re-entered password
  validateReEnteredPassword(String value) {
    var password = passwordController.text.trim().toString();
    var reEnteredPassword = reEnterPasswordController.text.trim().toString();
    if(value.isEmpty) {
      userReEnterPasswordError = 'Re-Enter password should not be empty';
      notifyListeners();
      return;
    }else if(value.length < 6) {
      userReEnterPasswordError = 'password should be greater than 6 characters';
      notifyListeners();
      return;
    }else if(password.compareTo(reEnteredPassword) != 0) {
      userReEnterPasswordError = 'Password and Re-Entered password mismatch';
      notifyListeners();
      return;
    }else {
      userReEnterPasswordError = null;
      notifyListeners();
    }
  }

  /// function to validate the user name
  validateName(String value) {
    if(value.isEmpty) {
      userNameError = 'User name should not be empty';
      notifyListeners();
      return;
    }else if(value.length < 6) {
      userNameError = 'user name should be greater than 6 characters';
      notifyListeners();
      return;
    }else {
      userNameError = null;
      notifyListeners();
    }
  }

  /// function to validate user mobile number
  validateMobileNumber(String value) {
    if(value.isEmpty) {
      userMobileError = 'User mobile should not be empty';
      notifyListeners();
      return;
    }else if(value.length < 10) {
      userMobileError = 'Please enter valid mobile number';
      notifyListeners();
      return;
    }else {
      userMobileError = null;
      notifyListeners();
    }
  }

  /// function to validate the user email address
  validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp =  RegExp(pattern);
    if(value.isEmpty) {
      userEmailError = 'User name should not be empty';
      notifyListeners();
      return;
    }else if(!regExp.hasMatch(value)) {
      userEmailError = 'Please provide valid email id';
      notifyListeners();
      return;
    }else {
      userEmailError = null;
      notifyListeners();
    }
  }

  /// function [signUp] for making api call from the [RegistrationRepository] class
  ///
  Future<void> signUp(BuildContext context) async {
    try {
      // AppNavigation.rootNavigatorKey.currentContext!.go('/loginScreen');
      await validateName(nameController.text);
      await validateEmail(emailController.text);
      await validateMobileNumber(mobileNumberController.text);
      await validatePassword(passwordController.text);
      await validateReEnteredPassword(reEnterPasswordController.text);

      RegistrationEntity registrationEntity = RegistrationEntity(
          firstName: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          mobile: mobileNumberController.text,
          lastName: nameController.text,
          expertise: 'Cosmetologist'
      );
      /*if((userNameError == null && userNameError!.isEmpty && userEmailError == null && userEmailError!.isEmpty && userMobileError == null &&
          userMobileError!.isEmpty && userPasswordError == null && userPasswordError!.isEmpty
          && userReEnterPasswordError == null && userReEnterPasswordError!.isEmpty)) {}*/
        registrationResponseModel = await _registrationRepository.signUp(registrationEntity: registrationEntity,context: context);
        logger.i('${registrationResponseModel?.message}');
        if(registrationResponseModel?.statusCode == 200) {
          print('sign up success');
          CustomAlertDialog.showCustomDialog(title: 'Alert Dialog', message: registrationResponseModel?.message,context: context);
          // AppNavigation.rootNavigatorKey.currentContext!.pushReplacement(RouteNames.login);
          // return;
        } else {
          print('sign up error');
          CustomAlertDialog.showCustomDialog(title: 'Alert Dialog', message: registrationResponseModel?.message,context: context);
      }
    }catch(e,s) {
      print('Exception: $e \n $s');
    }

  }
}