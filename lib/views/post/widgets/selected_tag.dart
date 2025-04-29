import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/widgets/tags/tag.dart';

class TagSelector extends StatefulWidget {
  final Function(String) onTagSelected;
  final List<Map<String, String>> tags;
  final String? initialValue; 

  const TagSelector({
    super.key,
    required this.onTagSelected,
    required this.tags,
    this.initialValue,  
  });

  @override
  TagSelectorState createState() => TagSelectorState();
}

class TagSelectorState extends State<TagSelector> {
  String? selectedTag;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null &&
        widget.tags.any((tag) => tag['name'] == widget.initialValue)) {
      selectedTag = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children:
          widget.tags.map((tag) {
            final tagName = tag['name']!;
            final isSelected = selectedTag == tagName;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTag = tagName;
                });
                widget.onTagSelected(tagName);
              },
              child:
                  isSelected
                      ? Tag.blackHigh(
                        title: tagName,
                        startContent: SvgPicture.asset(
                          "assets/svg/check-check.svg",
                          height: 12,
                          width: 12,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      )
                      : Tag.defHigh(title: tagName),
            );
          }).toList(),
    );
  }
}
