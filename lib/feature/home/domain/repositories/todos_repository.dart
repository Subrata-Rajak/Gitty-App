import 'package:gitty/feature/home/domain/entity/todo_entity.dart';

abstract class TodosRepository {
  Future<TodoEntity?> getAllTodos();
}
