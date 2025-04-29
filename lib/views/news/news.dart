import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart';
import 'package:high_bee/models/datas/news.dart';

class NewsPage extends StatelessWidget {
  static const routeName = 'news';
  final NewsModel news;

  const NewsPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: TopBar(),
      backgroundColor: PrimaryColors.claudeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news.title ?? '',
                style: TextStyle(
                  fontFamily: news.font,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                  height: 1.3,
                ),
              ),
              Tag.blackHigh(title: news.tag!),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(news.cape!, fit: BoxFit.cover),
                ),
              ),
              Text(
                news.argument!,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: news.font,
                  fontSize: 18,
                  color: Colors.black87,
                  height: 1.6,
                ),
              ),
              if (news.photo1 != null) ...[
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(news.photo1!, fit: BoxFit.cover),
                  ),
                ),
                if (news.photo1desc != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "(${news.photo1desc})",
                      style: TextStyle(
                        fontFamily: news.font,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/icon_launcher.png",
                      height: 50,
                      width: 50,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Text(
                    news.user!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  subtitle: Text(
                    news.user!.intention,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Urbanist',
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
