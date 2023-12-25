import 'package:gitty/core/common/constants.dart';
import 'package:gitty/core/common/services.dart';
import 'package:gitty/core/local_storage/keys.dart';
import 'package:gitty/core/local_storage/storage.dart';
import 'package:gitty/feature/home/data/models/todos_model.dart';
import 'package:gitty/feature/home/domain/entity/todo_entity.dart';
import 'package:gitty/feature/home/utils/todos_mapper.dart';

class TodosService {
  final client = HttpService.instance.httpClient;

  Future<TodoEntity?> getAllTodos() async {
    TodoEntity? todos;
    final userToken = await LocalStorage.instance
        .readStringFromLocalDb(key: AppLocalStorageKeys.instance.userToken);

    if (userToken == null) {
      return null;
    } else {
      try {
        final url = '${AppConstants.instance.baseUrl}todos';

        final headers = {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $userToken",
        };

        final uri = Uri.parse(url);

        final response = await client.get(
          uri,
          headers: headers,
        );

        if (response.statusCode == 200) {
          TodosModel todosModel = todosModelFromJson(response.body);
          todos = TodosMapper.instance.mapModelToEntity(todosModel: todosModel);
        }
      } catch (error) {
        print("Error while fetching todos -- API: $error");
      }
    }
    return todos;
  }
}
