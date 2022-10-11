// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked_core/stacked_core.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/authentication_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/firestore_service.dart';
import '../services/image_selector.dart';
import '../ui/about_us/about_us_view.dart';
import '../ui/admin/admin_view_model.dart';
import '../ui/admin/blood_request/blood_request_view_model.dart';
import '../ui/admin/center/center_view_model.dart';
import '../ui/admin/center/crud/add/add_center_view_model.dart';
import '../ui/admin/center/crud/edit/edit_center_view_model.dart';
import '../ui/admin/user_message/user_message_view_model.dart';
import '../ui/donate_view/donate_form_view_model.dart';
import '../ui/donor/donor_view_model.dart';
import '../ui/home/home_viewmodel.dart';
import '../ui/onboarding/onboarding_view_model.dart';
import '../ui/other_message/other_message_view_model.dart';
import '../ui/patient/patient_history/patient_history_view_model.dart';
import '../ui/patient/patient_view_model.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => CloudStorageService());
  locator.registerSingleton(AuthenticationService());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => DonorViewModel());
  locator.registerLazySingleton(() => DonateFormViewModel());
  locator.registerLazySingleton(() => AdminViewModel());
  locator.registerLazySingleton(() => OnboardingViewModel());
  locator.registerLazySingleton(() => PatientViewModel());
  locator.registerLazySingleton(() => PatientHistoryViewModel());
  locator.registerLazySingleton(() => BloodRequestViewModel());
  locator.registerLazySingleton(() => CenterViewModel());
  locator.registerLazySingleton(() => AboutUsViewModel());
  locator.registerLazySingleton(() => AddCenterViewModel());
  locator.registerLazySingleton(() => EditCenterViewModel());
  locator.registerLazySingleton(() => UserMessageViewModel());
  locator.registerLazySingleton(() => OtherMessageViewModel());
}
