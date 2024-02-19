// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homePageRouteData,
      $rsvpRouteData,
      $giftRouteData,
      $venueRouteData,
    ];

RouteBase get $homePageRouteData => GoRouteData.$route(
      path: '/',
      factory: $HomePageRouteDataExtension._fromState,
    );

extension $HomePageRouteDataExtension on HomePageRouteData {
  static HomePageRouteData _fromState(GoRouterState state) =>
      HomePageRouteData();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rsvpRouteData => GoRouteData.$route(
      path: '/rsvp',
      factory: $RsvpRouteDataExtension._fromState,
    );

extension $RsvpRouteDataExtension on RsvpRouteData {
  static RsvpRouteData _fromState(GoRouterState state) => RsvpRouteData();

  String get location => GoRouteData.$location(
        '/rsvp',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $giftRouteData => GoRouteData.$route(
      path: '/gift',
      factory: $GiftRouteDataExtension._fromState,
    );

extension $GiftRouteDataExtension on GiftRouteData {
  static GiftRouteData _fromState(GoRouterState state) => GiftRouteData();

  String get location => GoRouteData.$location(
        '/gift',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $venueRouteData => GoRouteData.$route(
      path: '/venue',
      factory: $VenueRouteDataExtension._fromState,
    );

extension $VenueRouteDataExtension on VenueRouteData {
  static VenueRouteData _fromState(GoRouterState state) => VenueRouteData();

  String get location => GoRouteData.$location(
        '/venue',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
