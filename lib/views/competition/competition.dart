import 'package:flutter/material.dart'; 
import 'package:high_bee/views/competition/widgets/elegant_card.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: ElegantCard(title: "Natureza Psicodélica", imageUrl: "https://t3.ftcdn.net/jpg/05/70/04/96/360_F_570049639_VbcfL0q4BAd5PXWbYrsc9UDdnlbUyEqY.jpg",),
        ),
      ],
    );
  }
}
