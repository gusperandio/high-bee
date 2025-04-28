import 'package:flutter/material.dart'; 
import 'package:flutter_svg/svg.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/components/widgets/loadings/loading_gif.dart' show Loading;
import 'package:high_bee/components/widgets/toasts/toast.dart';
import 'package:high_bee/components/widgets/topbar/topbar.dart'; 
import 'package:high_bee/viewmodel/post/demonstration_view_model.dart'; 
import 'package:provider/provider.dart';

class DemonstrationPostPage extends StatefulWidget {
  static const routeName = 'demonstration'; 
  const DemonstrationPostPage({super.key});

  @override
  State<DemonstrationPostPage> createState() => _DemonstrationPostPageState();
}

class _DemonstrationPostPageState extends State<DemonstrationPostPage> {
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null) {
      context.read<DemonstrationViewModel>().setArguments(args);
    }
  }

 @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DemonstrationViewModel>();

    return Consumer<DemonstrationViewModel>(
      builder: (context, vm, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.isLoading && !vm.isDialogVisible) {
            vm.isDialogVisible = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(child: Loading(size: 120)),
            );
          }

          if (!vm.isLoading && vm.isDialogVisible) {
            vm.isDialogVisible = false;
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (vm.errorMessage != null) {
            Toast.show(context, vm.errorMessage!, variant: Variant.danger);
            vm.errorMessage = null;
          }
        });

        return AppContainer(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              FocusScope.of(context).unfocus();
              viewModel.saveMyNews();
            },
            backgroundColor: const Color(0xFF000000),
            child: SvgPicture.asset(
              "assets/svg/book-up-2.svg",
              height: 28,
              width: 28,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
          appBar: TopBar(title: "Demonstração"),
          body: Center(child: Text("Conteudo")));
  });}
}