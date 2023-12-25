import 'package:gitty/feature/home/data/models/todos_model.dart';
import 'package:gitty/feature/home/domain/entity/todo_entity.dart';

class TodosMapper {
  static TodosMapper instance = TodosMapper();

  TodoEntity mapModelToEntity({required TodosModel todosModel}) {
    return TodoEntity(
      statusCode: todosModel.statusCode,
      data: todosModel.data
          .map(
            (e) => TodoDataEntity(
              userId: e.userId,
              id: e.id,
              title: e.title,
              completed: e.completed,
            ),
          )
          .toList(),
      message: todosModel.message,
      success: todosModel.success,
    );
  }

  TodosModel mapEntityToModel({required TodoEntity todoEntity}) {
    return TodosModel(
      statusCode: todoEntity.statusCode,
      data: todoEntity.data
          .map(
            (e) => TodoData(
              userId: e.userId,
              id: e.id,
              title: e.title,
              completed: e.completed,
            ),
          )
          .toList(),
      message: todoEntity.message,
      success: todoEntity.success,
    );
  }
}
