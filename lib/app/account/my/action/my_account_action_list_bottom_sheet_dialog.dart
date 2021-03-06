import 'dart:core';

import 'package:fedi/app/auth/instance/chooser/auth_instance_chooser_bloc.dart';
import 'package:fedi/app/auth/instance/chooser/auth_instance_chooser_bloc_impl.dart';
import 'package:fedi/app/auth/instance/chooser/auth_instance_chooser_widget.dart';
import 'package:fedi/app/ui/fedi_padding.dart';
import 'package:fedi/app/ui/modal_bottom_sheet/fedi_modal_bottom_sheet.dart';
import 'package:easy_dispose_provider/easy_dispose_provider.dart';
import 'package:flutter/material.dart';

void showMyAccountActionListBottomSheetDialog(BuildContext context) {
  showFediModalBottomSheetDialog(
    context: context,
    child: DisposableProvider<IAuthInstanceChooserBloc>(
      create: (context) => AuthInstanceChooserBloc.createFromContext(context),
      child: Padding(
        padding: FediPadding.allBigPadding,
        child: const AuthInstanceChooserWidget(),
      ),
    ),
  );
}
