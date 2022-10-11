import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';

class AboutUsViewModel extends BaseViewModel {


  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  void changeNavToRoute(String route) {
    _authenticationService.changeRoute(route);
  }
}
