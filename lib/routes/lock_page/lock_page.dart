import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wedding_site/common/widgets/input_field.dart';
import 'package:wedding_site/providers/wedding_guest_provider.dart';
import 'package:wedding_site/routes/router.dart';
import 'package:wedding_site/services/repositories/wedding_guest_repository.dart';
import 'package:wedding_site/theme/theme.dart';

final accessCodeTcProvider = Provider.autoDispose<TextEditingController>((ref) {
  final tc = TextEditingController();

  ref.onDispose(() {
    tc.dispose();
  });

  return tc;
});

class LockPage extends ConsumerStatefulWidget {
  const LockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LockPageState();
}

class _LockPageState extends ConsumerState<LockPage> {
  bool _processingSubmission = false;
  String? _errorMessage;

  Future<void> _onEnterPressed() async {
    setState(() {
      _processingSubmission = true;
      _errorMessage = null;
    });

    final enteredCode = ref.read(accessCodeTcProvider).text.trim();

    if (enteredCode.isEmpty) {
      setState(() {
        _errorMessage = "Required";
      });
    } else {
      final bool accessCodeValid = await ref
          .read(weddingGuestRepositoryProvider)
          .validAccessCode(enteredCode);

      if (!accessCodeValid) {
        setState(() {
          _errorMessage = "Invalid Access Code";
        });
      } else {
        ref.read(currentAccessCodeProvider.notifier).state = enteredCode;

        // ignore: use_build_context_synchronously
        HomePageRouteData().go(context);
      }
    }

    if (mounted) {
      setState(() {
        _processingSubmission = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSchemeOf(context).surfaceVariant.withOpacity(0.55),
      body: LayoutBuilder(builder: (context, c) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            shadowColor: Colors.black26,
            color: colorSchemeOf(context).surface,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Image.asset(
                      "assets/tandem-love.png",
                      height: 150,
                    ),
                  ),
                  Text(
                    "Missy x Tyler",
                    style: textThemeOf(context)
                        .headlineMedium
                        .withColor(colorSchemeOf(context).onPrimaryContainer),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Please enter the access code from your wedding invite.",
                    style: textThemeOf(context).bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "If you experience any issues, please don't hesitate to reach out to either of the above mentioned.",
                      style: textThemeOf(context).bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: c.maxWidth * .5,
                    child: InputField(
                      maxLines: 1,
                      controller: ref.watch(accessCodeTcProvider),
                      label: "Access Code",
                      onChanged: () {
                        final text = ref.read(accessCodeTcProvider).text;
                        if (_errorMessage != null && text.isNotEmpty) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                      errorText: _errorMessage,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_processingSubmission)
                        const CircularProgressIndicator(),
                      const SizedBox(width: 32),
                      ElevatedButton(
                        onPressed:
                            !_processingSubmission ? _onEnterPressed : null,
                        child: Text(
                          "Enter",
                          style: textThemeOf(context).bodyMedium.withColor(
                              colorSchemeOf(context).onPrimaryContainer),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
