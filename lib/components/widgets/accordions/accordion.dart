import 'package:flutter/material.dart';
import 'package:high_bee/components/styles/colors.dart';

class Accordion extends StatefulWidget {
  const Accordion({
    super.key,
    required this.title,
    required this.content,
    this.description,
    this.auxiliarBtn,
    this.background,
  });

  final String title;
  final Widget content;
  final String? description;
  final String? auxiliarBtn;
  final Color? background;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: PrimaryColors.carvaoColor,  
        ),
        borderRadius: BorderRadius.circular(8.0),  
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          expandIconColor: PrimaryColors.carvaoColor,
          children: [
            ExpansionPanel(
              backgroundColor: widget.background ?? PrimaryColors.highBeeColor,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 20),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: PrimaryColors.carvaoColor,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          widget.description != null
                              ? Text(
                                widget.description!,
                                style: const TextStyle(
                                  color: PrimaryColors.carvaoColor,
                                  fontFamily: 'Urbanist',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      Visibility(
                        visible: widget.auxiliarBtn != null,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Text(
                            "DETALHES",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                              color: Colors.white,
                              fontFamily: 'AlegreyaSans',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              body: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: Alignment.topCenter,
                child: widget.content,
              ),
              isExpanded: _isExpanded,
            ),
          ],
        ),
      ),
    );
  }
}
