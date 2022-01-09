import 'package:flutter/material.dart';

// class TorchButton extends StatefulWidget {
//   const TorchButton({Key? key}) : super(key: key);
//
//   @override
//   State<TorchButton> createState() {
//     return _TorchButton();
//   }
// }
//
// class _TorchButton extends State<TorchButton> {
class TorchButton extends StatelessWidget {
  TorchButton(
      {Key? key, required this.isOn, this.torchButtonCallback})
      : super(key: key);
  bool isOn;
  Function()? torchButtonCallback;

  @override
  Widget build(BuildContext context) {
    var image = isOn
        ? const Image(
            image: AssetImage('lib/asset/semi-transparent1024x1024.png'))
        : const Image(image: AssetImage('lib/asset/light-black-1024x1024.png'));


    return torchButtonCallback == null
        ? image
        : GestureDetector(
            child: image,
            onTap: torchButtonCallback,
          );
  }
}
