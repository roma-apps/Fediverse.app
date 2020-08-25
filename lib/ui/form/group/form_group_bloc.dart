import 'package:fedi/ui/form/form_item_bloc.dart';

abstract class IFormGroupBloc<T extends IFormItemBloc> extends IFormItemBloc {
  List<T> get items;

  Stream<List<T>> get itemsStream;
}
