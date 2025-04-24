import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class RDCards extends StatelessWidget {
  const RDCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              color: PrimaryColors.offWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  redirect(
                    "https://fitoterapiabrasil.com.br/sites/default/files/legislacao/rdc_96-2008.pdf",
                    LaunchMode.externalNonBrowserApplication,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/book-text.svg",
                        height: 32,
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          SecondaryColors.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'RDC 96/2008',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Ver documento',
                        style: TextStyle(fontSize: 13, fontFamily: 'Urbanist'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Card(
              elevation: 0,
              color: PrimaryColors.offWhiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  redirect(
                    "https://bvsms.saude.gov.br/bvs/saudelegis/anvisa/2019/rdc0327_09_12_2019.pdf",
                    LaunchMode.inAppBrowserView,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/book-text.svg",
                        height: 32,
                        width: 32,
                        colorFilter: ColorFilter.mode(
                          SecondaryColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'RDC 327/2019',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Ver documento',
                        style: TextStyle(fontSize: 13, fontFamily: 'Urbanist'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
