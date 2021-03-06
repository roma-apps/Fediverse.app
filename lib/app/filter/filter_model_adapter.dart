import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/filter/filter_model.dart';
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_model.dart';

extension IPleromaFilterExtension on IPleromaApiFilter {
  IFilter toDbFilterPopulatedWrapper() => DbFilterPopulatedWrapper(
        dbFilterPopulated: DbFilterPopulated(
          dbFilter: toDbFilter(),
        ),
      );

  DbFilter toDbFilter() => DbFilter(
      id: null,
      remoteId: id,
      phrase: phrase,
      context: context,
      irreversible: irreversible,
      wholeWord: wholeWord,
      expiresAt: expiresAt,
    );
}

extension IFilterExtension on IFilter {
  PleromaApiFilter toPleromaFilter() {
    return PleromaApiFilter(
      id: remoteId,
      phrase: phrase,
      context: context,
      irreversible: irreversible,
      wholeWord: wholeWord,
      expiresAt: expiresAt,
    );
  }
}
