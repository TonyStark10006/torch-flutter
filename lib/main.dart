import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:torch/bloc/torch/torch.dart';
import 'package:torch/contants.dart';
import 'package:torch/page/torch.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => TorchBloc(),
      child: PlatformApp(
        title: app_title_cn,
        home: Torch(),
      ),
    );
  }
}
