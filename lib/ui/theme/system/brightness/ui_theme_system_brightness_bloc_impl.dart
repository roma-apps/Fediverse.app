import 'package:easy_dispose/easy_dispose.dart';
import 'package:fedi/ui/theme/system/brightness/ui_theme_system_brightness_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class UiThemeSystemBrightnessBloc extends DisposableOwner
    implements IUiThemeSystemBrightnessBloc {
  final BehaviorSubject<Brightness> systemBrightnessSubject =
      BehaviorSubject.seeded(Brightness.light);

  UiThemeSystemBrightnessBloc() {
    systemBrightnessSubject.disposeWith(this);
  }

  @override
  void onSystemBrightnessChanged(brightness) {
    systemBrightnessSubject.add(brightness);
  }

  @override
  Brightness? get systemBrightness => systemBrightnessSubject.valueOrNull;

  @override
  Stream<Brightness> get systemBrightnessStream =>
      systemBrightnessSubject.stream.distinct();
}
