import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/styles/colors.dart';
import 'package:high_bee/util/navigate.dart';
import 'package:high_bee/viewmodel/post/post_view_model.dart';
import 'package:provider/provider.dart';

class PostPage extends StatelessWidget {
  static const routeName = 'post';
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PostViewModel>();

    return Consumer<PostViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {});

        return AppContainer(
          body: KeyboardDismissOnTap(
            child: Column(
              children: [
                Container(
                  height: 72,
                  width: double.infinity,
                  color: PrimaryColors.highBeeColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: GestureDetector(
                          onTap: () => {MSNavigate.toRoot(context)},
                          child: SvgPicture.asset(
                            'assets/svg/arrow-left.svg',
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 35,
                      bottom: 15,
                    ),
                    color: PrimaryColors.claudeColor,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 20,
                        children: [
                          const SizedBox(height: 100),
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 6,
                              children: [
                                TextFormField(
                                  controller: viewModel.titleController,
                                  cursorWidth: 1,
                                  cursorColor: PrimaryColors.carvaoColor,
                                  decoration: InputDecoration(
                                    floatingLabelStyle: const TextStyle(
                                      color: PrimaryColors.carvaoColor,
                                    ),
                                    labelText: 'Título',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: PrimaryColors.carvaoColor,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  // validator:
                                  //     (value) =>
                                  //         FieldValidator.validateEmail(value),
                                ),
                                SizedBox(height: 16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class ParagrafosScreen extends StatefulWidget {
//   @override
//   _ParagrafosScreenState createState() => _ParagrafosScreenState();
// }

// class _ParagrafosScreenState extends State<ParagrafosScreen> {
//   List<TextEditingController> controllers = [TextEditingController()];
//   static const int maxParagrafos = 5;

//   void _adicionarParagrafo() {
//     if (controllers.length < maxParagrafos) {
//       setState(() {
//         controllers.add(TextEditingController());
//       });
//     }
//   }

//   @override
//   void dispose() {
//     for (var controller in controllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Parágrafos')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: controllers.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(bottom: 16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: controllers[index],
//                       minLines: 4,
//                       maxLines: 6,
//                       decoration: InputDecoration(
//                         labelText: 'Parágrafo ${index + 1}',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                   ),
//                   if (index == controllers.length - 1 &&
//                       controllers.length < maxParagrafos)
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       onPressed: _adicionarParagrafo,
//                     ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
