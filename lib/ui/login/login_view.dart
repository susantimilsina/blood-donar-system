import 'package:blood_doner/widgets/smart/google_signin/google_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helper.dart';
import 'login_viewmodel.dart';
import 'option_radio_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 40, top: 23, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome\nBack!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: model.emailController,
                  decoration: const InputDecoration(
                      hintText: 'Your email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                verticalSpaceSmall,
                TextField(
                  keyboardType: TextInputType.text,
                  controller: model.passwordController,
                  obscureText: !model.passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          model.changeVisibility();
                        },
                        icon: Icon(
                          model.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        )),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                verticalSpaceMedium,
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Login as :',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: OptionRadio(
                          text: 'Patient',
                          index: 0,
                          selectedButton: model.selectedButton ?? 0,
                          press: (val) {
                            model.changeValue(val);
                          }),
                    ),
                    Expanded(
                      child: OptionRadio(
                          text: 'Donor',
                          index: 1,
                          selectedButton: model.selectedButton ?? 0,
                          press: (val) {
                            model.changeValue(val);
                          }),
                    ),
                  ],
                ),
                verticalSpaceMedium,
                GestureDetector(
                  onTap: model.loginViaEmail,
                  child: Container(
                    width: screenWidthPercentage(context, percentage: 0.65),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffffd200), Color(0xfff7971e)]),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                        child: model.isBusy
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.deepOrangeAccent,
                              )
                            : Text(
                                'Login',
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                  ),
                ),
                verticalSpaceTiny,
                Text(
                  'or',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                verticalSpaceTiny,
                const GoogleSigninButtonWidget(),
                verticalSpaceTiny,
                Row(
                  children: [
                    horizontalSpaceLarge,
                    const Text('Don\'t have an account ?'),
                    TextButton(
                        onPressed: model.gotoSignupView,
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          )),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
