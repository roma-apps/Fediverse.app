import 'package:fedi/app/notification/tab/notification_tab_bloc.dart';
import 'package:fedi/app/ui/async/fedi_async_init_loading_widget.dart';
import 'package:flutter/cupertino.dart';

class NotificationTabBlocLoadingWidget extends StatelessWidget {
  final Widget child;

  NotificationTabBlocLoadingWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => FediAsyncInitLoadingWidget(
        asyncInitLoadingBloc: INotificationTabBloc.of(context),
        loadingFinishedBuilder: (_) => child,
      );
}
