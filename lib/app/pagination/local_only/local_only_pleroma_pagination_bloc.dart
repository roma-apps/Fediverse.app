import 'package:fedi/pagination/local_only/local_only_pagination_bloc.dart';
import 'package:fedi/pagination/pagination_model.dart';

abstract class ILocalOnlyPleromaPaginationBloc<TItem>
    implements ILocalOnlyPaginationBloc<PaginationPage<TItem>, TItem> {}
