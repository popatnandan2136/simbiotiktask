import 'package:get/get.dart';
import '../../views/splash/splash_screen.dart';
import '../../views/dashboard/job_dashboard_screen.dart';
import '../../views/detail/job_detail_screen.dart';
import '../../models/job_model.dart';

class AppRoutes {
  static const String splash = '/';
  static const String dashboard = '/dashboard';
  static const String detail = '/detail';

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: dashboard,
      page: () => JobDashboardScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: detail,
      page: () {
        final JobModel job = Get.arguments as JobModel;
        return JobDetailScreen(job: job);
      },
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
