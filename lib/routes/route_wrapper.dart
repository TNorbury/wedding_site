import 'package:flutter/material.dart';

import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/theme/theme.dart';

enum SiteTab {
  rsvp,
  gift,
  venue,
}

class RouteWrapper extends StatelessWidget {
  final Widget child;
  final SiteTab? selectedTab;
  const RouteWrapper({
    Key? key,
    required this.child,
    this.selectedTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: Material(
            elevation: 2,
            shadowColor: Colors.black26,
            color: colorSchemeOf(context).surface,
            child: Column(
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => HomePageRouteData().go(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Text(
                            "Missy x Tyler",
                            style: textThemeOf(context).headlineMedium,
                          ),
                          const Text("05/31/2024 - Portland, OR"),
                        ],
                      ),
                    ),
                  ),
                ),
                const NavHeader(),
                Expanded(
                  child: Container(
                    color: colorSchemeOf(context).surface,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SelectionArea(child: child),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavHeader extends StatelessWidget {
  const NavHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const Divider(height: 1),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: NavTab(
                    label: "RSVP",
                    go: RsvpRouteData().go,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: "Gift Registry",
                    go: GiftRouteData().go,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: "Venue Info",
                    go: VenueRouteData().go,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class NavTab extends StatelessWidget {
  final String label;
  final void Function(BuildContext context)? go;
  const NavTab({
    Key? key,
    required this.label,
    this.go,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () {
          go?.call(context);
        },
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              label,
              style: textThemeOf(context).titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}
