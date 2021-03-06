import 'package:fedi/app/async/pleroma/pleroma_async_operation_helper.dart';
import 'package:fedi/app/filter/edit/edit_filter_bloc.dart';
import 'package:fedi/app/ui/page/app_bar/fedi_page_app_bar_text_action_widget.dart';
import 'package:fedi/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

class EditFilterAppBarSaveActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var editFilterBloc = IEditFilterBloc.of(context);

    return StreamBuilder<bool>(
      stream: editFilterBloc.isReadyToSubmitStream,
      builder: (context, snapshot) {
        var isReadyToSave = snapshot.data ?? false;

        return FediPageAppBarTextActionWidget(
          text: S.of(context).app_filter_edit_action_save,
          onPressed: isReadyToSave
              ? () async {
                  await PleromaAsyncOperationHelper
                      .performPleromaAsyncOperation(
                    context: context,
                    asyncCode: () async {
                      await editFilterBloc.submit();
                    },
                  );

                  Navigator.of(context).pop();
                }
              : null,
        );
      },
    );
  }

  const EditFilterAppBarSaveActionWidget();
}
