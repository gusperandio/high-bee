import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/util/navigate.dart';

class DiscardDialog extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onTapDiscard;
  const DiscardDialog({
    super.key,
    required this.onTap,
    required this.onTapDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black54,
      child: SizedBox(
        height: 180,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text(
                    'Descartar',
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/x.svg',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Deseja descartar sua publicação?",
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 140,
                    child: Button.black(
                      title: "Descartar",
                      onPressed: () {
                        onTapDiscard();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SizedBox(
                    width: 140,
                    child: Button.success(
                      title: "Salvar",
                      onPressed: () {
                        onTap();
                        Navigator.of(context).pop();
                        Future.delayed(const Duration(milliseconds: 100), () {
                          MSNavigate.toRoot(context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
