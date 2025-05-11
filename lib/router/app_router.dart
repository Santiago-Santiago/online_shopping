import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';
import 'package:online_shopping/ui/mobile/screens/home_mobile.dart';
import 'package:online_shopping/ui/web/screens/categories_page.dart';
import 'package:online_shopping/ui/web/screens/home_web.dart';
import 'package:online_shopping/ui/web/screens/products_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: kIsWeb
      ? [
          GoRoute(path: '/', builder: (context, state) => HomeWeb()),
          GoRoute(
              path: '/products',
              builder: (context, state) => ProductsWebPage()),
          GoRoute(
              path: '/categories',
              builder: (context, state) => CategoriesWebPage()),
        ]
      : [
          GoRoute(path: '/', builder: (context, state) => HomeMobile()),
          //GoRoute(path: '/profile', builder: (context, state) => MobileProfilePage()),
        ],
);
