import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:torch/bloc/torch/torch.dart';
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
        title: '很赞手电筒',
        home: PlatformScaffold(
          iosContentPadding: true,
          appBar: PlatformAppBar(
            title: PlatformText('很赞手电筒'),
            material: (context, platform) => MaterialAppBarData(
              backgroundColor: Colors.grey[850],
            ),
            cupertino: (context, platform) => CupertinoNavigationBarData(
              backgroundColor: Colors.grey[850],
              title: PlatformText(
                '很赞手电筒',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: Torch(),
        ),
      ),
    );
  }
}
