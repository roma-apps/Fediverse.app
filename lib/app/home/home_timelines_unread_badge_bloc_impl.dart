import 'package:fedi/app/home/home_bloc.dart';
import 'package:fedi/app/ui/badge/bool/fedi_bool_badge_bloc.dart';
import 'package:easy_dispose/easy_dispose.dart';

class HomeTimelinesUnreadBadgeBloc extends DisposableOwner
    implements IFediBoolBadgeBloc {
  final IHomeBloc homeBloc;

  HomeTimelinesUnreadBadgeBloc({required this.homeBloc});

  @override
  Stream<bool> get badgeStream => homeBloc.isTimelinesUnreadStream;
}
