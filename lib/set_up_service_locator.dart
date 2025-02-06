import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:zybo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:zybo/features/auth/domain/auth_repository.dart';
import 'package:zybo/features/auth/domain/auth_usecase.dart';
import 'package:zybo/features/auth/data/auth_remote_data_source.dart';
import 'package:zybo/features/auth/data/auth_repository_imp.dart';
import 'package:zybo/features/home/data/data_sources/banner_remote_data_source.dart';
import 'package:zybo/features/home/data/data_sources/product_remote_data_source.dart';
import 'package:zybo/features/home/data/repository/banner_repository_imp.dart';
import 'package:zybo/features/home/data/repository/product_repository_imp.dart';
import 'package:zybo/features/home/domain/repo/banner_repository.dart';
import 'package:zybo/features/home/domain/repo/product_repository.dart';
import 'package:zybo/features/home/domain/usecase/get_banner.dart';
import 'package:zybo/features/home/domain/usecase/get_products.dart';
import 'package:zybo/features/home/domain/usecase/search_product.dart';
import 'package:zybo/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/search/search_bloc.dart';
import 'package:zybo/features/profile/data/datasource/user_remote_datasources.dart';
import 'package:zybo/features/profile/data/repo/user_repository_impl.dart';
import 'package:zybo/features/profile/domain/repo/user_repository.dart';
import 'package:zybo/features/profile/domain/usecase/get_user.dart';
import 'package:zybo/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:zybo/features/wishlist/presentation/bloc/bloc/wishlist_bloc.dart';

GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {
  serviceLocator.registerLazySingleton(() => Dio());

  _initAuth();
  _initProduct();
  _initBanner();
  _initUserData();
  _initWishlist();
  _initSearch();
}

_initAuth() {
  serviceLocator.registerLazySingleton(() => AuthRemoteDataSource());
  serviceLocator.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImp(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => VerifyUserUseCase(serviceLocator()));

  serviceLocator
      .registerLazySingleton(() => LoginOrRegisterUseCase(serviceLocator()));

  serviceLocator.registerFactory(() => AuthBloc(
      verifyUserUseCase: serviceLocator(),
      loginOrRegisterUseCase: serviceLocator()));
}

void _initProduct() {
  serviceLocator
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImp(serviceLocator()),
    )
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImp(serviceLocator()),
    )
    ..registerLazySingleton<FetchProducts>(
      () => FetchProducts(serviceLocator()),
    )
    ..registerFactory(
      () => ProductBloc(serviceLocator()),
    );
}

void _initBanner() {
  serviceLocator
    ..registerLazySingleton<BannerRemoteDataSource>(
      () => BannerRemoteDateSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<BannerRepository>(
      () => BannerRepositoryImp(serviceLocator()),
    )
    ..registerLazySingleton<GetBanner>(
      () => GetBanner(serviceLocator()),
    )
    ..registerFactory(
      () => BannerBloc(serviceLocator()),
    );
}

void _initUserData() {
  serviceLocator
    ..registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourcesImpl(serviceLocator()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<GetUser>(
      () => GetUser(serviceLocator()),
    )
    ..registerFactory(
      () => UserBloc(serviceLocator()),
    );
}

void _initWishlist() {
  serviceLocator.registerFactory(
    () => WishlistBloc(serviceLocator()),
  );
}

void _initSearch() {
  serviceLocator.registerLazySingleton<SearchProduct>(
      () => SearchProduct(serviceLocator()));

  serviceLocator.registerFactory(
    () => SearchBloc(serviceLocator()),
  );
}
