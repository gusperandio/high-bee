import 'package:flutter/material.dart';
import 'package:high_bee/components/enum/enums.dart';

class BannerCustom extends StatefulWidget {
  final String asset;
  final String? title;
  final String? description;
  final AlignTitle? alignTitle;
  final Color? titleColor;

  const BannerCustom(
      {super.key,
      required this.asset,
      this.title,
      this.description,
      this.alignTitle,
      this.titleColor});

  @override
  BannerCustomState createState() => BannerCustomState();
}

class BannerCustomState extends State<BannerCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Stack(
            alignment: widget.alignTitle == AlignTitle.top
                ? Alignment.topCenter
                : Alignment.bottomCenter,
            children: [
              widget.asset.contains('http')
                  ? Image.network(widget.asset,
                      width: double.infinity, height: 150, fit: BoxFit.fill)
                  : Image.asset(widget.asset,
                      width: double.infinity, height: 150, fit: BoxFit.fill),
              if (widget.description != null && widget.title != null)
                Container(
                  alignment: widget.alignTitle == AlignTitle.top
                      ? Alignment.topLeft
                      : Alignment.bottomLeft,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.title != null)
                        Text(
                          widget.title!,
                          style: TextStyle(
                            color: widget.titleColor ?? Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (widget.description != null)
                        Text(
                          widget.description!,
                          style: TextStyle(
                              color: widget.titleColor ?? Colors.white,
                              fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
