import 'package:fedi/refactored/app/notification/notification_bloc.dart';
import 'package:fedi/refactored/app/ui/fedi_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCreatedAtWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var notificationBloc = INotificationBloc.of(context, listen: false);

    return StreamBuilder<DateTime>(
        stream: notificationBloc.createdAtStream,
        initialData: notificationBloc.createdAt,
        builder: (context, snapshot) {
          var createdAt = snapshot.data;

          // todo: locale
          return Text(
            timeago.format(createdAt, locale: 'en_short'),
            style: TextStyle(color: FediColors.grey),
          );
        });
  }
}
