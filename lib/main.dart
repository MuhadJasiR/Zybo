import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zybo/core/theme/theme.dart';
import 'package:zybo/features/auth/application/bloc/auth_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/banner/banner_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/product/product_bloc.dart';
import 'package:zybo/features/home/presentation/bloc/search/search_bloc.dart';
import 'package:zybo/features/profile/presentation/bloc/bloc/user_bloc.dart';
import 'package:zybo/features/wishlist/presentation/bloc/bloc/wishlist_bloc.dart';

import 'package:zybo/init_dependencies.dart';
import 'package:zybo/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<BannerBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<WishlistBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SearchBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        home: SplashScreen(),
      ),
    );
  }
}
