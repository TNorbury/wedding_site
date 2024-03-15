import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/routes/rsvp_count_dialog/rsvp_count_dialog.dart';
import 'package:wedding_site/theme/theme.dart';

enum SiteTab {
  home("Home"),
  rsvp("RSVP"),
  gift("Gift Registry"),
  venue("Venue Info");

  final String label;
  const SiteTab(this.label);
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
    final phone = MediaQuery.of(context).size.width <= 660;

    return Scaffold(
      backgroundColor: colorSchemeOf(context).surfaceVariant.withOpacity(0.55),
      drawer: NavigationDrawer(
        selectedIndex: selectedTab?.index,
        backgroundColor: colorSchemeOf(context).surfaceVariant,
        elevation: 0,
        children: [
          NavDrawerItem(
            label: "Home",
            go: HomePageRouteData().go,
            isSelected: selectedTab == SiteTab.home,
          ),
          NavDrawerItem(
            label: SiteTab.rsvp.label,
            go: RsvpRouteData().go,
            isSelected: selectedTab == SiteTab.rsvp,
          ),
          NavDrawerItem(
            label: SiteTab.gift.label,
            go: GiftRouteData().go,
            isSelected: selectedTab == SiteTab.gift,
          ),
          NavDrawerItem(
            label: SiteTab.venue.label,
            go: VenueRouteData().go,
            isSelected: selectedTab == SiteTab.venue,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: phone ? 24 : 64, vertical: 8),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          shadowColor: Colors.black26,
          color: colorSchemeOf(context).primaryContainer,
          child: Column(
            children: [
              const SiteHeader(),
              if (!phone)
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

class SiteHeader extends ConsumerWidget {
  const SiteHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    // final phone = MediaQuery.of(context).size.width <= WidthBreakpoints.medium;
    final smallScreen = MediaQuery.of(context).size.width <= 660;

    final direction = smallScreen ? Axis.vertical : Axis.horizontal;
    Widget child;

    final content = Flex(
      direction: direction,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: smallScreen ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (!smallScreen)
          Flexible(
            child: Image.asset(
              "assets/tandem-love.png",
              height: 150,
            ),
          ),
        if (smallScreen)
          Flexible(
            flex: 3,
            child: Image.asset(
              "assets/tandem-love.png",
              height: 75,
            ),
          ),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Missy x Tyler",
                style: textThemeOf(context)
                    .headlineMedium
                    .withColor(colorSchemeOf(context).onPrimaryContainer),
                textAlign: TextAlign.center,
              ),
              Text(
                "05/31/2024 - Portland, OR",
                style: textThemeOf(context)
                    .bodyMedium
                    .withColor(colorSchemeOf(context).onPrimaryContainer),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        if (!smallScreen) const Spacer(),
      ],
    );
    if (smallScreen) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
          SizedBox(width: 24),
          Flexible(child: content)
        ],
      );
    } else {
      child = content;
    }

    final admin = ref.watch(
      weddingGuestProvider.select(
        (value) =>
            value?.accessCode == "mltn68" ||
            (kDebugMode && value?.accessCode == "testtest"),
      ),
    );

    return GestureDetector(
      onDoubleTap: admin
          ? () {
              showDialog(
                context: context,
                builder: (context) => RsvpCountDialog(),
              );
            }
          : null,
      child: Padding(
        padding: EdgeInsets.only(
          right: 32,
          left: smallScreen ? 0 : 32,
          top: 16.0,
          bottom: 16.0,
        ),
        child: child,
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
                    label: SiteTab.home.label,
                    go: HomePageRouteData().go,
                    isSelected: selectedTab == SiteTab.home,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: SiteTab.rsvp.label,
                    go: RsvpRouteData().go,
                    isSelected: selectedTab == SiteTab.rsvp,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: SiteTab.gift.label,
                    go: GiftRouteData().go,
                    isSelected: selectedTab == SiteTab.gift,
                  ),
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: NavTab(
                    label: SiteTab.venue.label,
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
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavDrawerItem extends StatelessWidget {
  final String label;
  final void Function(BuildContext context)? go;
  final bool isSelected;
  const NavDrawerItem({
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
          .withColor(colorSchemeOf(context).onSurfaceVariant)!;
    }

    return ListTile(
      title: Text(
        label,
        style: textStyle,
      ),
      tileColor: isSelected
          ? colorSchemeOf(context).primary
          : colorSchemeOf(context).surfaceVariant,
      onTap: () {
        go?.call(context);
        Navigator.of(context).pop();
      },
    );
  }
}
