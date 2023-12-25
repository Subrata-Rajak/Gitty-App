import 'package:gitty/feature/home/domain/entity/todo_entity.dart';

abstract class TodosScreenStates {}

class TodosInitialState extends TodosScreenStates {}

class FetchingTodosState extends TodosScreenStates {}

class TodosFetchingSuccessfulState extends TodosScreenStates {
  final TodoEntity? todoEntity;

  TodosFetchingSuccessfulState({required this.todoEntity});
}

class TodosFetchingFailedState extends TodosScreenStates {
  final String errorMessage;

  TodosFetchingFailedState({required this.errorMessage});
}
