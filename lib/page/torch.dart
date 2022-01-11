import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torch/bloc/torch/event.dart';
import 'package:torch/bloc/torch/torch.dart';
import 'package:torch/widget/sos_button.dart';
import 'package:torch/widget/torch_button.dart';
import 'package:torch/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:torch_light/torch_light.dart';

class Torch extends StatefulWidget {
  @override
  State<Torch> createState() => _Torch();
}

class _Torch extends State<Torch> {
  static bool enabledWhenLaunch = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isTorchAvailable(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          return mainContent(context);
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
    );
  }

  Widget mainContent(BuildContext context) {
    var torchBloc = BlocProvider.of<TorchBloc>(context);
    var sosIsOn = context.watch<TorchBloc>().state.sosButton;
    var lightIsOn = context.watch<TorchBloc>().state.lightButton;

    if (!enabledWhenLaunch) {
      torchBloc.add(EnableTorch());
      enabledWhenLaunch = true;
    }
    
    return Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: Column(
          children: [
            Expanded(
              child: SOSButton(
                isOn: sosIsOn,
                SOSButtonCallback: () => {
                  sosIsOn
                      ? torchBloc.add(DisableCycleTorch())
                      : torchBloc.add(EnableCycleTorch()),
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
                  lightIsOn
                      ? torchBloc.add(DisableTorch())
                      : torchBloc.add(EnableTorch()),

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
}
