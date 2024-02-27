import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_site/providers/local_storage_provider.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/routes/gift_page/gift_page.dart';
import 'package:wedding_site/routes/home_page/home_page.dart';
import 'package:wedding_site/routes/lock_page/lock_page.dart';
import 'package:wedding_site/routes/route_wrapper.dart';
import 'package:wedding_site/routes/rsvp_page/rsvp_page.dart';
import 'package:wedding_site/routes/venue_page/venue_page.dart';
import 'package:wedding_site/services/repositories/wedding_guest_repository.dart';

part 'router.g.dart';

GoRouter router(WidgetRef ref) {
  final router = GoRouter(
    initialLocation: HomePageRouteData().location,
    routes: [
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          final selectedTab = switch (state.matchedLocation) {
            "/" => SiteTab.home,
            "/rsvp" => SiteTab.rsvp,
            "/gift" => SiteTab.gift,
            "/venue" => SiteTab.venue,
            _ => null,
          };

          if (state.matchedLocation == LockRouteData().location) {
            return child;
          }

          return RouteWrapper(
            selectedTab: selectedTab,
            child: child,
          );
        },
        routes: $appRoutes,
      ),
    ],
    redirect: (context, routerState) async {
      final currentlySetAccessCode = ref.read(currentAccessCodeProvider);

      // provider is set, all is valid and good
      if (currentlySetAccessCode.isNotEmpty) {
        return null;
      }

      // check storage for access code
      final cacheAccessCode = await ref
          .read(localStorageValueProvider("accessCode").future) as String?;

      debugPrint("code from cache: $cacheAccessCode");

      // no access code
      if (cacheAccessCode == null || cacheAccessCode.isEmpty) {
        return "/lock";
      }

      // check if cache is valid
      final cacheIsValid = await ref
          .read(weddingGuestRepositoryProvider)
          .validAccessCode(cacheAccessCode);

      if (!cacheIsValid) {
        return "/lock";
      }

      ref.read(currentAccessCodeProvider.notifier).state = cacheAccessCode;

      return null;
    },
  );
  return router;
}

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

@TypedGoRoute<LockRouteData>(path: "/lock")
class LockRouteData extends GoRouteCommon {
  LockRouteData() : super(page: const LockPage());
}
