import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:torch/page/about.dart';

class CustomPlatfromScaffold extends StatelessWidget {
  const CustomPlatfromScaffold({
    Key? key,
    required this.title,
    required this.body, 
    this.trailingActions,
  }) : super(key: key);

  final String title;
  final Widget body;
  final List<Widget>? trailingActions; 

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: true,
      appBar: PlatformAppBar(
        title: PlatformText(title),
        material: (context, platform) => MaterialAppBarData(
          backgroundColor: Colors.grey[850],
        ),
        cupertino: (context, platform) => CupertinoNavigationBarData(
          backgroundColor: Colors.grey[850],
          title: PlatformText(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        trailingActions: trailingActions,
      ),
      body: body,
    );
  }
}
