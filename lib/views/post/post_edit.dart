import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';

class PostEditPage extends StatefulWidget {
  static const routeName = 'post';
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      backgroundColor: PrimaryColors.claudeColor,
      body: Expanded(child: Center(child: Text("Texto"))),
    );
  }
}
