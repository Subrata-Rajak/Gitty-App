import 'package:gitty/feature/home/domain/entity/todo_entity.dart';
import 'package:gitty/feature/home/domain/repositories/todos_repository.dart';

class GetTodosUsecase {
  final TodosRepository todosRepository;

  GetTodosUsecase({required this.todosRepository});

  Future<TodoEntity?> getAllTodos() async {
    return await todosRepository.getAllTodos();
  }
}
