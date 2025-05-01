import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class Sticker extends StatelessWidget {
  final String imageUrl;
  final String description;

  const Sticker({super.key, required this.imageUrl, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      width: 100,
      height: 100,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder:
            (context, imageProvider) => Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.contain,
                  colorFilter: const ColorFilter.matrix(<double>[
                    0.2126, 0.7152, 0.0722, 0, 0, // Red channel
                    0.2126, 0.7152, 0.0722, 0, 0, // Green channel
                    0.2126, 0.7152, 0.0722, 0, 0, // Blue channel
                    0, 0, 0, 1, 0, // Alpha channel
                  ]),
                ),
              ),
            ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }
}
