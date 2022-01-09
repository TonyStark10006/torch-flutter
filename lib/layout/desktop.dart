import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({Key? key, required Widget this.child}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: '很赞手电筒',
      home: PlatformScaffold(
        // appBar: PlatformAppBar(
        //   title: PlatformText('很赞手电筒'),
        // ),
        body: Container(
          child: this.child,
        ),
      ),
    );
  }
}
