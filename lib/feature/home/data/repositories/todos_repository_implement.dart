import 'package:gitty/feature/home/data/data_source/todos_service.dart';
import 'package:gitty/feature/home/domain/entity/todo_entity.dart';
import 'package:gitty/feature/home/domain/repositories/todos_repository.dart';

class TodosRepositoryImpl implements TodosRepository {
  final TodosService todosService;

  TodosRepositoryImpl({required this.todosService});

  @override
  Future<TodoEntity?> getAllTodos() async {
    return await todosService.getAllTodos();
  }
}
