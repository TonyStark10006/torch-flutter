class TorchBlocState {
  bool sosButton = false;
  bool lightButton = false ;

  TorchBlocState toggleSOSButton() {
    lightButton = false;
    return TorchBlocState()..sosButton = !sosButton;
  }

  TorchBlocState toggleLightButton() {
    sosButton = false;
    return TorchBlocState()..lightButton = !lightButton;
  }

  TorchBlocState clone() {
    return TorchBlocState()..lightButton = lightButton;
  }

  TorchBlocState enableTorchWhenLaunch() {
    return TorchBlocState()..lightButton = true;
  }

  TorchBlocState init() {
    return TorchBlocState();
  }
}
