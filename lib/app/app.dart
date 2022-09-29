import 'package:blood_doner/ui/EditProfile/edit_profile_view.dart';
import 'package:blood_doner/ui/ViewProfile/viewprofile_view.dart';
import 'package:blood_doner/ui/admin/admin_view_model.dart';
import 'package:blood_doner/ui/admin/center/center_view_model.dart';
import 'package:blood_doner/ui/donate_view/donate_form_view.dart';
import 'package:blood_doner/ui/donate_view/donate_form_view_model.dart';
import 'package:blood_doner/ui/donor/donor_view.dart';
import 'package:blood_doner/ui/donor/donor_view_model.dart';
import 'package:blood_doner/ui/home/home_viewmodel.dart';
import 'package:blood_doner/ui/onboarding/onboarding_view_model.dart';
import 'package:blood_doner/ui/patient/patient_history/patient_history_view.dart';
import 'package:blood_doner/ui/patient/patient_history/patient_history_view_model.dart';
import 'package:blood_doner/ui/patient/patient_view_model.dart';
import 'package:blood_doner/ui/signup/signup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../services/authentication_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/firestore_service.dart';
import '../services/image_selector.dart';
import '../ui/admin/admin_view.dart';
import '../ui/admin/blood_request/blood_request_view.dart';
import '../ui/admin/blood_request/blood_request_view_model.dart';
import '../ui/admin/center/center_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/completeProfile/complete_profile_view.dart';
import '../ui/onboarding/onboarding_view.dart';
import '../ui/patient/patient_view.dart';
import '../ui/startup/startup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartUpView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: CompleteProfileView),
    MaterialRoute(page: SignupView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: EditProfileView),
    MaterialRoute(page: ViewProfileView),
    MaterialRoute(page: DonorView),
    MaterialRoute(page: DonateFormView),
    MaterialRoute(page: AdminView),
    MaterialRoute(page: IntroductionScreenPage),
    MaterialRoute(page: PatientView),
    MaterialRoute(page: PatientHistoryView),
    MaterialRoute(page: BloodRequestView),
    MaterialRoute(page: CenterView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: FirestoreService),
    LazySingleton(classType: ImageSelector),
    LazySingleton(classType: CloudStorageService),
    Singleton(classType: AuthenticationService),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: DonorViewModel),
    LazySingleton(classType: DonateFormViewModel),
    LazySingleton(classType: AdminViewModel),
    LazySingleton(classType: OnboardingViewModel),
    LazySingleton(classType: PatientViewModel),
    LazySingleton(classType: PatientHistoryViewModel),
    LazySingleton(classType: BloodRequestViewModel),
    LazySingleton(classType: CenterViewModel),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /*serves no purpose except having an annotation attached to it*/
}
//run "flutter pub run build_runner build --delete-conflicting-outputs" after making changes