// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/EditProfile/edit_profile_view.dart';
import '../ui/ViewProfile/viewprofile_view.dart';
import '../ui/admin/admin_view.dart';
import '../ui/admin/blood_request/blood_request_view.dart';
import '../ui/admin/center/center_view.dart';
import '../ui/completeProfile/complete_profile_view.dart';
import '../ui/donate_view/donate_form_view.dart';
import '../ui/donor/donor_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/onboarding/onboarding_view.dart';
import '../ui/patient/patient_history/patient_history_view.dart';
import '../ui/patient/patient_view.dart';
import '../ui/signup/signup_view.dart';
import '../ui/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String homeView = '/home-view';
  static const String completeProfileView = '/complete-profile-view';
  static const String signupView = '/signup-view';
  static const String loginView = '/login-view';
  static const String editProfileView = '/edit-profile-view';
  static const String viewProfileView = '/view-profile-view';
  static const String donorView = '/donor-view';
  static const String donateFormView = '/donate-form-view';
  static const String adminView = '/admin-view';
  static const String introductionScreenPage = '/introduction-screen-page';
  static const String patientView = '/patient-view';
  static const String patientHistoryView = '/patient-history-view';
  static const String bloodRequestView = '/blood-request-view';
  static const String centerView = '/center-view';
  static const all = <String>{
    startUpView,
    homeView,
    completeProfileView,
    signupView,
    loginView,
    editProfileView,
    viewProfileView,
    donorView,
    donateFormView,
    adminView,
    introductionScreenPage,
    patientView,
    patientHistoryView,
    bloodRequestView,
    centerView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.completeProfileView, page: CompleteProfileView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.viewProfileView, page: ViewProfileView),
    RouteDef(Routes.donorView, page: DonorView),
    RouteDef(Routes.donateFormView, page: DonateFormView),
    RouteDef(Routes.adminView, page: AdminView),
    RouteDef(Routes.introductionScreenPage, page: IntroductionScreenPage),
    RouteDef(Routes.patientView, page: PatientView),
    RouteDef(Routes.patientHistoryView, page: PatientHistoryView),
    RouteDef(Routes.bloodRequestView, page: BloodRequestView),
    RouteDef(Routes.centerView, page: CenterView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    CompleteProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CompleteProfileView(),
        settings: data,
      );
    },
    SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignupView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    EditProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const EditProfileView(),
        settings: data,
      );
    },
    ViewProfileView: (data) {
      var args = data.getArgs<ViewProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ViewProfileView(
          args.userMap,
          key: args.key,
        ),
        settings: data,
      );
    },
    DonorView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DonorView(),
        settings: data,
      );
    },
    DonateFormView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DonateFormView(),
        settings: data,
      );
    },
    AdminView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AdminView(),
        settings: data,
      );
    },
    IntroductionScreenPage: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const IntroductionScreenPage(),
        settings: data,
      );
    },
    PatientView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PatientView(),
        settings: data,
      );
    },
    PatientHistoryView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const PatientHistoryView(),
        settings: data,
      );
    },
    BloodRequestView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const BloodRequestView(),
        settings: data,
      );
    },
    CenterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CenterView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ViewProfileView arguments holder class
class ViewProfileViewArguments {
  final Map<String, dynamic> userMap;
  final Key? key;
  ViewProfileViewArguments({required this.userMap, this.key});
}
