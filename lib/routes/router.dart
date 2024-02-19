import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_site/routes/gift_page/gift_page.dart';

import 'package:wedding_site/routes/home_page/home_page.dart';
import 'package:wedding_site/routes/route_wrapper.dart';
import 'package:wedding_site/routes/rsvp_page/rsvp_page.dart';
import 'package:wedding_site/routes/venue_page/venue_page.dart';

part 'router.g.dart';

final router = GoRouter(
  initialLocation: HomePageRouteData().location,
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        final selectedTab = switch (state.matchedLocation) {
          "/rsvp" => SiteTab.rsvp,
          "/gift" => SiteTab.gift,
          "/venue" => SiteTab.venue,
          _ => null,
        };

        return RouteWrapper(
          selectedTab: selectedTab,
          child: child,
        );
      },
      routes: $appRoutes,
    ),
  ],
  redirect: (context, routerState) {
    // if !signed in, go to login page

    return null;
  },
);

class GoRouteCommon extends GoRouteData {
  final Widget page;
  GoRouteCommon({
    required this.page,
  });

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionDuration: const Duration(milliseconds: 1),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

@TypedGoRoute<HomePageRouteData>(path: "/")
class HomePageRouteData extends GoRouteCommon {
  HomePageRouteData() : super(page: const HomePage());
}

@TypedGoRoute<RsvpRouteData>(path: "/rsvp")
class RsvpRouteData extends GoRouteCommon {
  RsvpRouteData() : super(page: const RsvpPage());
}

@TypedGoRoute<GiftRouteData>(path: "/gift")
class GiftRouteData extends GoRouteCommon {
  GiftRouteData() : super(page: const GiftPage());
}

@TypedGoRoute<VenueRouteData>(path: "/venue")
class VenueRouteData extends GoRouteCommon {
  VenueRouteData() : super(page: const VenuePage());
}
