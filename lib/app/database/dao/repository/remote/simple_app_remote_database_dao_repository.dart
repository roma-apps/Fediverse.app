import 'package:fedi/app/database/dao/repository/remote/app_remote_database_dao_repository.dart';
import 'package:fedi/app/database/dao/repository/simple_app_database_dao_repository_mixin.dart';
import 'package:fedi/repository/repository_model.dart';
import 'package:moor/moor.dart';

abstract class SimpleAppRemoteDatabaseDaoRepository<
        DbItem extends DataClass,
        AppItem,
        RemoteItem,
        DbId,
        RemoteId,
        TableDsl extends Table,
        TableInfoDsl extends TableInfo<TableDsl, DbItem>,
        Filters,
        OrderingTerm extends RepositoryOrderingTerm>
    extends AppRemoteDatabaseDaoRepository<DbItem, AppItem, RemoteItem, DbId,
        RemoteId, TableDsl, TableInfoDsl, Filters, OrderingTerm>
    with
        SimpleDatabaseDaoRepositoryMixin<DbItem, AppItem, DbId, TableDsl,
            TableInfoDsl, Filters, OrderingTerm> {

  RemoteItem mapDbItemToRemoteItem(DbItem dbItem);

  @override
  Stream<AppItem?> watchByRemoteIdInAppType(RemoteId remoteId) {
          // var query = dao.startSelectQuery();
          //
          // addFindByRemoteIdWhereToSimpleSelectStatement(
          //     simpleSelectStatement: query, remoteId: remoteId);
          //
          // ret
          // convertSimpleSelectStatementToJoinedSelectStatement()
  }
}