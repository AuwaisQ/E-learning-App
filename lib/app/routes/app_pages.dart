import 'package:get/get.dart';

import '../modules/achievements/bindings/achievements_binding.dart';
import '../modules/achievements/views/achievements_view.dart';
import '../modules/add_address/bindings/add_address_binding.dart';
import '../modules/add_address/views/add_address_view.dart';
import '../modules/appProfile/bindings/app_profile_binding.dart';
import '../modules/appProfile/views/app_profile_view.dart';
import '../modules/bottomBar/bindings/bottom_bar_binding.dart';
import '../modules/bottomBar/views/bottom_bar_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/courseLessons/bindings/course_lessons_binding.dart';
import '../modules/courseLessons/views/course_lessons_view.dart';
import '../modules/display_address/bindings/display_address_binding.dart';
import '../modules/display_address/views/display_address_view.dart';
import '../modules/filters/bindings/filters_binding.dart';
import '../modules/filters/views/filters_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/indroduction/bindings/indroduction_binding.dart';
import '../modules/indroduction/views/indroduction_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/myCourses/bindings/my_courses_binding.dart';
import '../modules/myCourses/views/my_courses_view.dart';
import '../modules/myProjects/bindings/my_projects_binding.dart';
import '../modules/myProjects/views/my_projects_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/notificationSettings/bindings/notification_settings_binding.dart';
import '../modules/notificationSettings/views/notification_settings_view.dart';
import '../modules/onBoarding/bindings/on_boarding_binding.dart';
import '../modules/onBoarding/views/on_boarding_view.dart';
import '../modules/orderList/bindings/order_list_binding.dart';
import '../modules/orderList/views/order_list_view.dart';
import '../modules/orderSummary/bindings/order_summary_binding.dart';
import '../modules/orderSummary/views/order_summary_view.dart';
import '../modules/prefrences/bindings/prefrences_binding.dart';
import '../modules/prefrences/views/prefrences_view.dart';
import '../modules/profilePage/bindings/profile_page_binding.dart';
import '../modules/profilePage/views/profile_page_view.dart';
import '../modules/progressReport/bindings/progress_report_binding.dart';
import '../modules/progressReport/views/progress_report_view.dart';
import '../modules/projectList/bindings/project_list_binding.dart';
import '../modules/projectList/views/project_list_view.dart';
import '../modules/selectInterest/bindings/select_interest_binding.dart';
import '../modules/selectInterest/views/select_interest_view.dart';
import '../modules/selectMaterials/bindings/select_materials_binding.dart';
import '../modules/selectMaterials/views/select_materials_view.dart';
import '../modules/shop/bindings/shop_binding.dart';
import '../modules/shop/views/shop_view.dart';
import '../modules/shopItem/bindings/shop_item_binding.dart';
import '../modules/shopItem/views/shop_item_view.dart';
import '../modules/updateProject/bindings/update_project_binding.dart';
import '../modules/updateProject/views/update_project_view.dart';
import '../modules/walletHistory/bindings/wallet_history_binding.dart';
import '../modules/walletHistory/views/wallet_history_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.INDRODUCTION,
      page: () => const IntroductionView(),
      binding: IndroductionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_INTEREST,
      page: () => const SelectInterestView(),
      binding: SelectInterestBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS_REPORT,
      page: () => ProgressReportView(),
      binding: ProgressReportBinding(),
    ),
    GetPage(
      name: _Paths.FILTERS,
      page: () => FiltersView(),
      binding: FiltersBinding(),
    ),
    GetPage(
      name: _Paths.COURSE_LESSONS,
      page: () => CourseLessonsView(),
      binding: CourseLessonsBinding(),
    ),
    GetPage(
      name: _Paths.MY_COURSES,
      page: () => MyCoursesView(),
      binding: MyCoursesBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.APP_PROFILE,
      page: () => AppProfileView(),
      binding: AppProfileBinding(),
    ),
    GetPage(
      name: _Paths.ACHIEVEMENTS,
      page: () => const AchievementsView(),
      binding: AchievementsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_SETTINGS,
      page: () => NotificationSettingsView(),
      binding: NotificationSettingsBinding(),
    ),
    GetPage(
      name: _Paths.PREFRENCES,
      page: () => PrefrencesView(),
      binding: PrefrencesBinding(),
    ),
    GetPage(
      name: _Paths.SHOP,
      page: () => ShopView(),
      binding: ShopBinding(),
    ),
    GetPage(
      name: _Paths.MY_PROJECTS,
      page: () => MyProjectsView(),
      binding: MyProjectsBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT_LIST,
      page: () => ProjectListView(),
      binding: ProjectListBinding(),
    ),
    GetPage(
      name: _Paths.SHOP_ITEM,
      page: () => ShopItemView(),
      binding: ShopItemBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_LIST,
      page: () => const OrderListView(),
      binding: OrderListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.DISPLAY_ADDRESS,
      page: () => DisplayAddressView(),
      binding: DisplayAddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUMMARY,
      page: () => OrderSummaryView(),
      binding: OrderSummaryBinding(),
    ),
    GetPage(
      name: _Paths.WALLET_HISTORY,
      page: () => WalletHistoryView(),
      binding: WalletHistoryBinding(),
    ),
    GetPage(
      name: _Paths.SELECT_MATERIALS,
      page: () => SelectMaterialsView(),
      binding: SelectMaterialsBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROJECT,
      page: () => UpdateProjectView(),
      binding: UpdateProjectBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => CheckoutView(),
      binding: CheckoutBinding(),
    ),
  ];
}
