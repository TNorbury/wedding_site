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
      backgroundColor:
          Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.55),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 8),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shadowColor: Colors.black26,
          color: colorSchemeOf(context).primaryContainer,
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
                          style: textThemeOf(context).headlineMedium.withColor(
                              colorSchemeOf(context).onPrimaryContainer),
                        ),
                        Text("05/31/2024 - Portland, OR",
                            style: textThemeOf(context).bodyMedium.withColor(
                                colorSchemeOf(context).onPrimaryContainer)),
                      ],
                    ),
                  ),
                ),
              ),
              NavHeader(
                selectedTab: selectedTab,
              ),
              Expanded(
                child: Container(
                  color: colorSchemeOf(context).surface,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32,
                    ),
                    child: SelectionArea(
                      child: ClipRect(child: child),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NavHeader extends StatelessWidget {
  final SiteTab? selectedTab;

  const NavHeader({
    Key? key,
    this.selectedTab,
  }) : super(key: key);

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
                    isSelected: selectedTab == SiteTab.rsvp,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: "Gift Registry",
                    go: GiftRouteData().go,
                    isSelected: selectedTab == SiteTab.gift,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: "Venue Info",
                    go: VenueRouteData().go,
                    isSelected: selectedTab == SiteTab.venue,
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
  final bool isSelected;
  const NavTab({
    Key? key,
    required this.label,
    this.go,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle;

    if (isSelected) {
      textStyle = textThemeOf(context)
          .titleMedium
          .withColor(colorSchemeOf(context).onPrimary)!;
    } else {
      textStyle = textThemeOf(context)
          .titleMedium
          .withColor(colorSchemeOf(context).onSurface)!;
    }
    const animationDuration = Duration(milliseconds: 250);
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: () {
          go?.call(context);
        },
        child: AnimatedContainer(
          duration: animationDuration,
          color: isSelected
              ? colorSchemeOf(context).primary
              : colorSchemeOf(context).surface,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.center,
            child: AnimatedDefaultTextStyle(
              duration: animationDuration,
              style: textStyle,
              child: Text(
                label,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
