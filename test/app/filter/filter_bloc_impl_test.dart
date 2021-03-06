import 'package:fedi/app/database/app_database.dart';
import 'package:fedi/app/filter/filter_bloc.dart';
import 'package:fedi/app/filter/filter_bloc_impl.dart';
import 'package:fedi/app/filter/filter_model.dart';
import 'package:fedi/app/filter/filter_model_adapter.dart';
import 'package:fedi/app/filter/repository/filter_repository.dart';
import 'package:fedi/app/filter/repository/filter_repository_impl.dart';
import 'package:fedi/pleroma/api/filter/pleroma_api_filter_service.dart';
import 'package:fedi/pleroma/api/pleroma_api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moor/ffi.dart';

import 'filter_bloc_impl_test.mocks.dart';
import 'filter_test_helper.dart';

// ignore_for_file: no-magic-number, avoid-late-keyword
@GenerateMocks([
  IPleromaApiFilterService,
])
void main() {
  late IFilter filter;
  late IFilterBloc filterBloc;
  late MockIPleromaApiFilterService pleromaFilterServiceMock;
  late AppDatabase database;
  late IFilterRepository filterRepository;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    filterRepository = FilterRepository(
      appDatabase: database,
    );

    pleromaFilterServiceMock = MockIPleromaApiFilterService();

    when(pleromaFilterServiceMock.isConnected).thenReturn(true);
    when(pleromaFilterServiceMock.pleromaApiState)
        .thenReturn(PleromaApiState.validAuth);

    filter = await FilterTestHelper.createTestFilter(
      seed: 'seed1',
    );

    filterBloc = FilterBloc(
      filter: filter,
      pleromaFilterService: pleromaFilterServiceMock,
      filterRepository: filterRepository,
      delayInit: false,
    );
  });

  tearDown(() async {
    await filterBloc.dispose();
    await filterRepository.dispose();
    await database.close();
  });

  Future _update(IFilter filter) async {
    await filterRepository.upsertInRemoteType(
      filter.toPleromaFilter(),
    );
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
  }

  test('filter', () async {
    FilterTestHelper.expectFilter(filterBloc.filter, filter);

    var newValue = await FilterTestHelper.createTestFilter(
      seed: 'seed2',
      remoteId: filter.remoteId,
    );

    var listenedValue;

    var subscription = filterBloc.filterStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    FilterTestHelper.expectFilter(
      listenedValue,
      filter,
    );

    await _update(newValue);

    FilterTestHelper.expectFilter(
      filterBloc.filter,
      newValue,
    );
    FilterTestHelper.expectFilter(
      listenedValue,
      newValue,
    );
    await subscription.cancel();
  });

  test('isExpired', () async {
    expect(
      filterBloc.isExpired,
      false,
    );
    expect(
      filterBloc.isExpired,
      filter.isExpired,
    );

    var listenedValue;

    var subscription = filterBloc.isExpiredStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(
      listenedValue,
      filter.isExpired,
    );

    await _update(filter.copyWith(expiresAt: DateTime(3000)));

    expect(
      filterBloc.isExpired,
      false,
    );
    expect(
      listenedValue,
      false,
    );

    await subscription.cancel();

    subscription = filterBloc.isExpiredStream.listen((newValue) {
      listenedValue = newValue;
    });
    // hack to execute notify callbacks
    await Future.delayed(Duration(milliseconds: 1));
    expect(listenedValue, filter.isExpired);

    await _update(filter.copyWith(expiresAt: DateTime(1990)));

    expect(
      filterBloc.isExpired,
      true,
    );
    expect(
      listenedValue,
      true,
    );
    await subscription.cancel();
  });
}
