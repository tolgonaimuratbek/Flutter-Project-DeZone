import 'package:de_zone/kurse/product_screen.dart';
import 'package:flutter/material.dart';
import '../bottom_navigation_bar.dart';
import 'category_items_screen.dart';
import 'model_category.dart';
import 'model_product.dart';

class AppRouter {
  //Route mit animation verwendet in Kontaktliste, CourseCard,HeroCarouselCard, ScreenBottomNavigationBar, Account
  static void routeTo(BuildContext context, Widget widget,
      {bool fromLeft = false}) {
    var route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin =
            fromLeft ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
    Navigator.of(context).push(route);
  }

  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    WidgetBuilder builder;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => ScreenBottomNavigationBar());

      case '/category':
        return MaterialPageRoute(
            builder: (context) =>
                CategoryItemsScreen(category: settings.arguments as Category));
      case CourseScreen.routeName:
        return CourseScreen.route(product: settings.arguments as Course);
      default:
        return _errorRoute();
    }
  }

  //Fehlerfall für Route
  static Route _errorRoute() {
    return MaterialPageRoute(
        settings: RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
            ));
  }
}
