import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  int? selectedButton;

  changeVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  changeValue(int value) {
    selectedButton = value;
    notifyListeners();
  }

  final Logger _log = getLogger('LoginViewModel');
  void loginViaEmail() async {
    setBusy(true);
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _snackbarService.showSnackbar(message: 'please enter all the details');
    } else {
      try {
        await _authenticationService.loginWithEmail(
            email: emailController.text,
            password: passwordController.text,
            val: selectedButton ?? 0);
      } catch (e) {
        _log.e(e);
      }
    }
    setBusy(false);
  }

  void gotoSignupView() {
    _navigationService.navigateTo(Routes.signupView);
  }
}
