
import 'package:clarity_mirror/features/signin/models/signin_response_model.dart';
import 'package:clarity_mirror/features/signin/repository/signin_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../utils/common_widgets/custom_alert_dialog.dart';

/// SignIn View model for updating the data to utilize in the ui screen
/// SignIn View model is a mediator between UI layer and Network layer
///
class SignInViewModel extends ChangeNotifier {

  /// Instance created [logger] for logging the data in console for debugging
  Logger logger = Logger();

  /// Instance created [signInRepository] for [SignInRepository] class
  ///
  final SignInRepository _signInRepository = SignInRepository();

  /// [signInResponseModel] contains the response after making the sign in api
  ///
  late SignInResponseModel signInResponseModel;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? userNameError;
  String? userPasswordError;

  bool isValidUserName = false;
  bool isValidPassword = false;

  /// function to validate the user name
  validateUserName(String value) {
    if(value.isEmpty) {
      userNameError = 'UserName should not be empty';
      isValidUserName = false;
    } else {
      userNameError = '';
      isValidUserName = true;
    }
    notifyListeners();
  }

  /// function to validate the user password
   validatePassword(String value) {
    if(value.isEmpty) {
      isValidPassword = false;
      userPasswordError = 'User password should not be empty';
      notifyListeners();
      return;
    }else if(value.length < 6) {
      isValidPassword = false;
      userPasswordError = 'password should be greater than 6 characters';
      notifyListeners();
      return;
    }else {
      isValidPassword = true;
      notifyListeners();
    }
  }

  /// function to clear the text input values
  void clearData() {
    print('clear data');
    userNameController.clear();
    passwordController.clear();
    notifyListeners();
  }

  /// function [signIn] for Api call to invoke the sign in api and handling the sign in response
  Future signIn(BuildContext context) async {
    try {
      /// Validating the filed for updating the error states
      ///
       validateUserName(userNameController.text);
       validatePassword(passwordController.text);

      /// proceed if user name and password validations are correct
      if((isValidUserName && isValidPassword)) {
        var userName = userNameController.text.toString();
        var password = passwordController.text.toString();
        signInResponseModel = await _signInRepository.signIn(userName: userName, password: password,context: context);
        notifyListeners();
        if(signInResponseModel.statusCode == 200) {
          // Handling the success scenario
          logger.i("Sign In data: ${signInResponseModel.message}");

          /// Clear the text controllers data after success api response
          clearData();

          /// updating the ui elements after resetting the text controllers data
          notifyListeners();

          /// show the alert dialog with success message
          // CustomAlertDialog.showCustomDialog(title: 'Alert Dialog', message: signInResponseModel.message);
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
              return CustomAlertDialog.alertDialogWidget(
                context: context,
                  title: 'Alert Dialog', message: signInResponseModel.message, onCompleted: () {
                    /// closing the alert dialog
                    Navigator.of(context).pop();
                    /// Navigating back to dashboard screen
                    // Navigator.of(context).pop();
              },
              );
          });
        } else {
          // TODO: Handle the response
          /// Handling the error scenario
          /// show the error dialog with error message
          logger.i("Sign error data: ${signInResponseModel.message}");
          CustomAlertDialog.showCustomDialog(title: 'Alert Dialog', message: signInResponseModel.message,context: context);
        }
        // CustomAlertDialog().stopLoadingIndicator();
      } else {
        CustomAlertDialog.showCustomDialog(title: 'Login Alert', message: 'Please provide valid user name or password',context: context);
        return;
      }
    }catch(e, s) {
      logger.e('Exception In SignIn ViewModel: $e \n $s');
    }
  }
}