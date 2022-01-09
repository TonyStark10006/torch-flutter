import 'dart:async';
import 'package:torch/widget/sos_button.dart';
import 'package:torch/widget/torch_button.dart';
import 'package:torch/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:torch_controller/torch_controller.dart';
import 'package:torch_light/torch_light.dart';

class Torch extends StatefulWidget {
  @override
  State<Torch> createState() => _Torch();
}

class _Torch extends State<Torch> {
  bool sosIsOn = false;
  bool lightIsOn = false;
  Timer? _timer;
  Timer? _timerCancel;
  // static final torchController = TorchController();

  // static Future<bool?> _toggle() async {
  //   try {
  //     return await torchController.toggle();
  //   } on Exception catch (error) {
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: '很赞手电筒',
      home: PlatformScaffold(
        iosContentPadding: true,
        appBar: PlatformAppBar(
          title: PlatformText('很赞手电筒'),
          material: (context, platform) => MaterialAppBarData(
            backgroundColor: Colors.grey[850],
          ),
        ),
        body: FutureBuilder<bool>(
          future: _isTorchAvailable(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data!) {
              return genContent(context);
            } else if (snapshot.hasData) {
              return Center(
                child: PlatformText('闪光灯不可用'),
              );
            } else {
              return Center(
                child: PlatformCircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget genContent(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Expanded(
              child: SOSButton(
                isOn: sosIsOn,
                SOSButtonCallback: () => {
                  setState(() {
                    sosIsOn = !sosIsOn;
                    lightIsOn = false;
                  }),
                  // _toggle(),
                  sosIsOn ? cycleTorch() : cancelTimer(),
                  debugPrint('sosIsOn:$sosIsOn'),
                },
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 3.0,
            ),
            Expanded(
              child: TorchButton(
                isOn: lightIsOn,
                torchButtonCallback: () => {
                  setState(() {
                    lightIsOn = !lightIsOn;
                    sosIsOn = false;
                  }),
                  if (lightIsOn)
                    {
                      cancelTimer(),
                      _enableTorch(),
                    }
                  else
                    {
                      _disableTorch(),
                    },
                  // lightIsOn
                  //     ? document.documentElement?.requestFullscreen()
                  //     : document.exitFullscreen(),
                  debugPrint('lightIsOn:$lightIsOn'),
                },
              ),
            ),
          ],
        ));
  }

  Future<bool> _isTorchAvailable() async {
    try {
      return await TorchLight.isTorchAvailable();
    } on Exception catch (_) {
      showToast('无法确认设备是否有闪光灯');
      rethrow;
    }
  }

  Future<void> _enableTorch() async {
    try {
      await TorchLight.enableTorch();
    } on Exception catch (_) {
      showToast('无法开启闪光灯');
    }
  }

  Future<void> _disableTorch() async {
    try {
      await TorchLight.disableTorch();
    } on Exception catch (_) {
      showToast('无法关闭闪光灯');
    }
  }

  Future<void> cycleTorch() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _enableTorch();

      _timerCancel = Timer(
          const Duration(milliseconds: 600),
          () async => {
                await _disableTorch(),
                debugPrint('cycle嵌套timer'),
              });
    });
  }

  Future<void> cancelTimer() async {
    if (_timer != null) {
      _timer!.cancel();
      _timerCancel!.cancel();
      await _disableTorch();
    }
  }
}
