import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:torch/bloc/torch/state.dart';
import 'package:torch/util/toast.dart';
import 'package:torch_light/torch_light.dart';

import 'event.dart';

class TorchBloc extends Bloc<TorchBlocEvent, TorchBlocState> {
  TorchBloc() : super(TorchBlocState().init())  {
    //TorchBlocState().enableTorch()
    on<EnableTorch>((event, emit) => {
          _disableCycleTorch(),
          _enableTorch(),
          emit(state.toggleLightButton()),
        });

    on<DisableTorch>((event, emit) => {
          _disableTorch(),
          emit(state.toggleLightButton()),
        });
    on<EnableCycleTorch>((event, emit) => {
          _cycleTorch(),
          emit(state.toggleSOSButton()),
        });

    on<DisableCycleTorch>((event, emit) => {
          _disableCycleTorch(),
          emit(state.toggleSOSButton()),
        });

    on<EnableTorchWhenLaunch>((event, emit) => {
          _disableCycleTorch(),
          _enableTorch(),
          // emit(state.clone()),
        });

    // on<InitEvent>((event, emit) => {
    //       emit(state.clone()),
    //     });

    // on<CheckTorch>((event, emit) => {
    //       _isTorchAvailable(),
    //       emit(state.clone()),
    //     });
  }

  Timer? _timer;
  Timer? _timerCancel;

  // Future<bool> _isTorchAvailable() async {
  //   try {
  //     return await TorchLight.isTorchAvailable();
  //   } on Exception catch (_) {
  //     showToast('无法确认设备是否有闪光灯');
  //     rethrow;
  //   }
  // }

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

  Future<void> _cycleTorch() async {
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

  Future<void> _disableCycleTorch() async {
    if (_timer != null) {
      _timer!.cancel();
      if (_timerCancel != null) _timerCancel!.cancel();
      await _disableTorch();
    }
  }
}
