// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:blood_doner/ui/completeProfile/complete_profile_view.dart'
    as _i4;
import 'package:blood_doner/ui/EditProfile/edit_profile_view.dart' as _i7;
import 'package:blood_doner/ui/home/home_view.dart' as _i3;
import 'package:blood_doner/ui/login/login_view.dart' as _i6;
import 'package:blood_doner/ui/signup/signup_view.dart' as _i5;
import 'package:blood_doner/ui/startup/startup_view.dart' as _i2;
import 'package:blood_doner/ui/ViewProfile/viewprofile_view.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i10;

class Routes {
  static const startUpView = '/';

  static const homeView = '/home-view';

  static const completeProfileView = '/complete-profile-view';

  static const signupView = '/signup-view';

  static const loginView = '/login-view';

  static const editProfileView = '/edit-profile-view';

  static const viewProfileView = '/view-profile-view';

=======
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/EditProfile/edit_profile_view.dart';
import '../ui/ViewProfile/viewprofile_view.dart';
import '../ui/completeProfile/complete_profile_view.dart';
import '../ui/donor/donor_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
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
>>>>>>> 3d916ceae41114a6f8f4a760a8d630641bbc512f
  static const all = <String>{
    startUpView,
    homeView,
    completeProfileView,
    signupView,
    loginView,
    editProfileView,
<<<<<<< HEAD
    viewProfileView
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(Routes.startUpView, page: _i2.StartUpView),
    _i1.RouteDef(Routes.homeView, page: _i3.HomeView),
    _i1.RouteDef(Routes.completeProfileView, page: _i4.CompleteProfileView),
    _i1.RouteDef(Routes.signupView, page: _i5.SignupView),
    _i1.RouteDef(Routes.loginView, page: _i6.LoginView),
    _i1.RouteDef(Routes.editProfileView, page: _i7.EditProfileView),
    _i1.RouteDef(Routes.viewProfileView, page: _i8.ViewProfileView)
=======
    viewProfileView,
    donorView,
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
>>>>>>> 3d916ceae41114a6f8f4a760a8d630641bbc512f
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.StartUpView(),
        settings: data,
      );
    },
    _i3.HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.HomeView(),
        settings: data,
      );
    },
    _i4.CompleteProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.CompleteProfileView(),
        settings: data,
      );
    },
    _i5.SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SignupView(),
        settings: data,
      );
    },
    _i6.LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.LoginView(),
        settings: data,
      );
    },
    _i7.EditProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.EditProfileView(),
        settings: data,
      );
    },
    _i8.ViewProfileView: (data) {
      final args = data.getArgs<ViewProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => _i8.ViewProfileView(args.userMap, key: args.key),
        settings: data,
      );
<<<<<<< HEAD
    }
=======
    },
    DonorView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DonorView(),
        settings: data,
      );
    },
>>>>>>> 3d916ceae41114a6f8f4a760a8d630641bbc512f
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ViewProfileViewArguments {
<<<<<<< HEAD
  const ViewProfileViewArguments({required this.userMap, this.key});

  final Map<String, dynamic> userMap;

  final _i9.Key? key;
}

extension NavigatorStateExtension on _i10.NavigationService {
  Future<dynamic> navigateToStartUpView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.startUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCompleteProfileView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.completeProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignupView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.signupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView(
      [int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewProfileView(
      {required Map<String, dynamic> userMap,
      _i9.Key? key,
      int? routerId,
      bool preventDuplicates = true,
      Map<String, String>? parameters,
      Widget Function(
              BuildContext, Animation<double>, Animation<double>, Widget)?
          transition}) async {
    return navigateTo<dynamic>(Routes.viewProfileView,
        arguments: ViewProfileViewArguments(userMap: userMap, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
=======
  final Map<String, dynamic> userMap;
  final Key? key;
  ViewProfileViewArguments({required this.userMap, this.key});
>>>>>>> 3d916ceae41114a6f8f4a760a8d630641bbc512f
}
