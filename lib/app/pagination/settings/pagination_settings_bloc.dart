import 'package:fedi/app/pagination/page_size/pagination_page_size_model.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_model.dart';
import 'package:fedi/app/settings/global_or_instance/global_or_instance_settings_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IPaginationSettingsBloc
    implements IGlobalOrInstanceSettingsBloc<PaginationSettings> {
  static const PaginationPageSize defaultPageSizeValue =
      PaginationPageSize.size20;

  static IPaginationSettingsBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IPaginationSettingsBloc>(
        context,
        listen: listen,
      );

  PaginationPageSize get pageSize;

  Stream<PaginationPageSize> get pageSizeStream;

  Future changePageSize(PaginationPageSize value);
}
