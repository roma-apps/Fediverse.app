import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/status/repository/status_repository_impl.dart';
import 'package:fedi/pleroma/tag/pleroma_tag_model.dart';
import 'package:flutter_test/flutter_test.dart';

Future<DbStatus> insertDbStatus(
  StatusRepository statusRepository,
  DbStatus statusData,
) async {
  var id = await statusRepository.insert(statusData);
  assert(id > 0, true);
  var dbStatus = statusData.copyWith(id: id);
  return dbStatus;
}

PleromaTag createTestPleromaTag({
  required String name,
}) {
  return PleromaTag.only(
    name: name,
    url: "https://fedi.app/#$name",
  );
}