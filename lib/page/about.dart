import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:torch/contants.dart';
import 'package:torch/widget/custom_platfrom_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPlatfromScaffold(
      title: about_about_cn,
      body: Container(
        width: double.maxFinite,
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('lib/asset/light-black-1024x1024.png'),
              height: 100,
              width: 100,
            ),
            PlatformText(
              app_title_cn,
              style: const TextStyle(fontSize: 20),
            ),
            InkWell(
              child: const Text(
                about_author,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onTap: () {
                _launchURL();
              },
            ),
            PlatformText(''),
            PlatformElevatedButton(
              color: Colors.grey[700],
              child: PlatformText(about_sponsor_cn),
              onPressed: () => {
                debugPrint('点击了赞助'),
              },
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    // canLaunch(about_about_cn).then((value) => debugPrint('能否打开url: ' + value.toString()));
    if (!await canLaunch(project_url)) throw '找不到可打开URL的应用';
    if (!await launch(project_url)) throw '不能打开URL: $project_url';
  }
}
