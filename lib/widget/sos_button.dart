import 'package:flutter/material.dart';

class SOSButton extends StatelessWidget {
  SOSButton({Key? key, required this.isOn, this.SOSButtonCallback})
      : super(key: key);
  bool isOn;
  Function()? SOSButtonCallback;

  @override
  Widget build(BuildContext context) {
    var image = isOn
        ? const Image(
            image: AssetImage(
                'lib/asset/lightning-semi-transparent-1024x1024.png'))
        : const Image(image: AssetImage('lib/asset/lightning-1024x1024.png'));
    return SOSButtonCallback == null
        ? image
        : GestureDetector(
            child: image,
            onTap: SOSButtonCallback,
          );
  }
}
