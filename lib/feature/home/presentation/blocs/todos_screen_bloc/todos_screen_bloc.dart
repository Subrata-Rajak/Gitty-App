import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitty/feature/home/domain/entity/todo_entity.dart';
import 'package:gitty/feature/home/domain/usecases/get_todos_usecase.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_events.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_states.dart';

class TodosScreenBloc extends Bloc<TodosScreenEvents, TodosScreenStates> {
  final GetTodosUsecase getTodosUsecase;

  TodosScreenBloc({required this.getTodosUsecase})
      : super(TodosInitialState()) {
    on<FetchTodosEvent>(fetchTodos);
  }

  FutureOr<void> fetchTodos(
    FetchTodosEvent event,
    Emitter<TodosScreenStates> emit,
  ) async {
    emit(FetchingTodosState());

    try {
      TodoEntity? todos = await getTodosUsecase.getAllTodos();

      if (todos != null) {
        emit(TodosFetchingSuccessfulState(todoEntity: todos));
      } else {
        emit(TodosFetchingFailedState(errorMessage: "Fetching todos failed"));
      }
    } catch (error) {
      print("Error while Fetching todos -- POST BLOC: $error");
      emit(TodosFetchingFailedState(errorMessage: "Internal error"));
    }
  }
}
