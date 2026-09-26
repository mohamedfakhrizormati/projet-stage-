import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_cart_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_category_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_command_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_sales_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_variant_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_watch_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_wishlist_data_source.dart';
import 'package:clean_arch/data/repository/authentication_repository_impl.dart';
import 'package:clean_arch/data/repository/cart_repository_impl.dart';
import 'package:clean_arch/data/repository/category_repository_impl.dart';
import 'package:clean_arch/data/repository/command_repository_impl.dart';
import 'package:clean_arch/data/repository/sales_repository_impl.dart';
import 'package:clean_arch/data/repository/variant_repository_impl.dart';
import 'package:clean_arch/data/repository/watch_repository_impl.dart';
import 'package:clean_arch/data/repository/wishlist_reporitory_impl.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:clean_arch/domain/repository/cart_repository.dart';
import 'package:clean_arch/domain/repository/category_repository.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:clean_arch/domain/repository/variant_repository.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:clean_arch/domain/repository/wishlist_repository.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/auto_login_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/create_account_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/forget_password_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/get_user_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/login_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/logout_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/reset_password_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/update_user_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/verify_otp_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/create_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/get_cart_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/cart_usecases/update_cart_usecase.dart';
import 'package:clean_arch/domain/usecases/category_usecases/get_all_categories_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/create_command_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/get_all_commands_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/get_command_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/command_usecases/update_command_status_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/add_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/get_all_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/get_sales_by_id_usecase.dart';
import 'package:clean_arch/domain/usecases/sales_usecases/update_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/variant_usecases/get_one_variant_usecase.dart';
import 'package:clean_arch/domain/usecases/variant_usecases/get_all_variant_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_all_watchs_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_cat_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_creation_date_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_sorted_watchs_by_sales_usecase.dart';
import 'package:clean_arch/domain/usecases/watch_usecases/get_watch_by_id_usecase.dart';
import 'package:get_it/get_it.dart';

import 'domain/usecases/wishlist_usecases/create_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/delete_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/get_wishlist_usecase.dart';
import 'domain/usecases/wishlist_usecases/update_wishlist_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(cartRemoteDataSource: sl()));

  sl.registerLazySingleton<WishlistRepository>(
      () => WishlistReporitoryImpl(wishlistRemoteDataSource: sl()));

  sl.registerLazySingleton<WatchRepository>(
      () => WatchRepositoryImpl(watchRemoteDataSource: sl()));

  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryRemoteDataSource: sl()));

  sl.registerLazySingleton<SalesRepository>(
      () => SalesRepositoryImpl(salesRemoteDataSource: sl()));

  sl.registerLazySingleton<CommandRepository>(
      () => CommandRepositoryImpl(commandRemoteDataSource: sl()));

  // sl.registerLazySingleton<VariantRepository>(
  //     () => VariantRepositoryImpl(variantRemoteDataSource: sl()));

  // sl.registerLazySingleton<PromotionRepository>(
  //     () => PromotionRepositoryImpl(sl()));

  // sl.registerLazySingleton<SubCategoryRepository>(
  //     () => SubCategoryRepositoryImpl(sl()));

  // sl.registerLazySingleton<SupplierRepository>(
  //     () => SupplierRepositoryImpl(sl()));

  // sl.registerLazySingleton<RatingRepository>(() => RatingRepositoryImpl(sl()));
  // sl.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(sl()));
  // sl.registerLazySingleton<SalesRepository>(() => SalesRepositoryImpl(sl()));
  // sl.registerLazySingleton<ReclamationRepository>(
  //     () => ReclamationsRepositoryImpl(sl()));
  // sl.registerLazySingleton<NotificationRepository>(
  //     () => NotificationRepositoryImpl(sl()));

  // /* data sources */
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl());

  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());

  sl.registerLazySingleton<CartRemoteDataSource>(
      () => CartRemoteDataSourceImpl());

  sl.registerLazySingleton<WishlistRemoteDataSource>(
      () => WishlistRemoteDataSourceImpl());

  sl.registerLazySingleton<WatchRemoteDataSource>(
      () => WatchRemoteDataSourceImpl());

  sl.registerLazySingleton<CategoryRemoteDataSource>(
      () => CategoryRemoteDataSourceImpl());

  sl.registerLazySingleton<CommandRemoteDataSource>(
      () => CommandRemoteDataSourceImpl());

  sl.registerLazySingleton<SalesRemoteDataSource>(
      () => SalesRemoteDataSourceImpl());

  // sl.registerLazySingleton<PromotionRemoteDataSource>(
  //     () => PromotionRemoteDataSourceImpl());

  // sl.registerLazySingleton<SubCategoryRemoteDataSource>(
  //     () => SubCategoryRemoteDataSourceImpl());
  // sl.registerLazySingleton<SupplierRemoteDataSource>(
  //     () => SupplierRemoteDataSourceImpl());

  // sl.registerLazySingleton<RatingRemoteDataSource>(
  //     () => RatingRemoteDataSourceImpl());
  // sl.registerLazySingleton<ReviewRemoteDataSource>(
  //     () => ReviewRemoteDataSourceImpl());
  // sl.registerLazySingleton<SalesRemoteDataSource>(
  //     () => SalesRemoteDataSourceImp());
  // sl.registerLazySingleton<ReclamtionsRemoteDataSource>(
  //     () => ReclamationRemoteDataSourceImpl());
  // sl.registerLazySingleton<NotificationRemoteDataSource>(
  //     () => NotificationRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => CreateAccountUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ForgetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => OTPVerificationUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => LogoutUsecase(sl()));
  // sl.registerLazySingleton(() => GoogleLoginUsecase(sl()));
  // sl.registerLazySingleton(() => FacebookLoginUsecase(sl()));
  sl.registerLazySingleton(() => AutoLoginUsecase(sl()));
  // sl.registerLazySingleton(() => GetRecoveryEmailUsecase(sl()));

  //cart//
  sl.registerLazySingleton(() => CreateCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartUsecase(sl()));
  sl.registerLazySingleton(() => GetCartByIdUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteCartUsecase(sl()));

  // // //wishlist//
  sl.registerLazySingleton(() => CreateWishListUsecase(sl()));
  sl.registerLazySingleton(() => UpdateWishListUsecase(sl()));
  sl.registerLazySingleton(() => GetWishlistUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteWishListUsecase(sl()));

  // //promotion//
  // sl.registerLazySingleton(() => GetAllPromotionsUsecase(sl()));

  // //products//
  sl.registerLazySingleton(() => GetAllWatchsUsecase(sl()));
  // sl.registerLazySingleton(() => GetSortedProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetWatchByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetSortedWatchsByCatUsecase(sl()));
  sl.registerLazySingleton(() => GetSortedWatchsBySalesUsecase(sl()));
  sl.registerLazySingleton(() => GetSortedWatchsByCreationDateUsecase(sl()));

  // //products 3D//
  // sl.registerLazySingleton(() => GetAllVariantUsecase(sl()));
  // sl.registerLazySingleton(() => GetOneVariant(sl()));

  // //categories//
  sl.registerLazySingleton(() => GetAllCategoriesUsecase(sl()));
  // sl.registerLazySingleton(() => GetAllSubCategoriesUsecase(sl()));

  // //supplier//
  // sl.registerLazySingleton(() => GetSupplierByIdUsecase(sl()));
  // sl.registerLazySingleton(() => GetSuppliersUsecase(sl()));

  // //rating//
  // sl.registerLazySingleton(() => AddRatingUsecase(sl()));
  // sl.registerLazySingleton(() => GetRatingsUsecase(sl()));
  // sl.registerLazySingleton(() => GetSingleRatingUsecase(sl()));
  // sl.registerLazySingleton(() => UpdateRatingUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteRatingUsecase(sl()));

  // //review//
  // sl.registerLazySingleton(() => GetAllReviewsUsecase(sl()));
  // sl.registerLazySingleton(() => AddReviewUsecase(sl()));
  // sl.registerLazySingleton(() => UpdateReviewUsecase(sl()));
  // sl.registerLazySingleton(() => RemoveReviewUsecase(sl()));
  // sl.registerLazySingleton(() => AddReviewImageUsecase(sl()));

  // //sales usecases//
  sl.registerLazySingleton(() => AddSaleUsecase(sl()));
  sl.registerLazySingleton(() => GetAllSalesUsecase(sl()));
  sl.registerLazySingleton(() => GetSalesByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateSalesUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteSaleUsecase(sl()));

  // //command usecases//
  sl.registerLazySingleton(() => CreateCommandUsecase(sl()));
  sl.registerLazySingleton(() => GetAllCommandsUsecase(sl()));
  sl.registerLazySingleton(() => GetCommandByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCommandStatusUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteSaleUsecase(sl()));

  // //reclamations usecases//
  // sl.registerLazySingleton(() => AddReclamationsUsecase(sl()));
  // sl.registerLazySingleton(() => GetAllReclamationsUsecase(sl()));
  // sl.registerLazySingleton(() => GetSingleReclamationUsecase(sl()));

  // // //notifications//
  // sl.registerLazySingleton(() => UpdateNotificationUsecase(sl()));
  // sl.registerLazySingleton(() => GetNotificationByIDUsecase(sl()));
  // sl.registerLazySingleton(() => GetNotificationByUserUsecase(sl()));
  // sl.registerLazySingleton(() => DeleteNotificationUsecase(sl()));
}
