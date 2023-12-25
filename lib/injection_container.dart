import 'package:get_it/get_it.dart';
import 'package:gitty/feature/auth/data/data_source/auth_service.dart';
import 'package:gitty/feature/auth/data/repositories/auth_repository_implement.dart';
import 'package:gitty/feature/auth/domain/repositories/auth_repository.dart';
import 'package:gitty/feature/auth/domain/usecases/login_usecase.dart';
import 'package:gitty/feature/auth/domain/usecases/register_usecase.dart';
import 'package:gitty/feature/auth/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:gitty/feature/auth/presentation/blocs/register_screen_bloc/register_screen_bloc.dart';
import 'package:gitty/feature/home/data/data_source/posts_service.dart';
import 'package:gitty/feature/home/data/data_source/todos_service.dart';
import 'package:gitty/feature/home/data/repositories/post_repository_implement.dart';
import 'package:gitty/feature/home/data/repositories/todos_repository_implement.dart';
import 'package:gitty/feature/home/domain/repositories/posts_repository.dart';
import 'package:gitty/feature/home/domain/repositories/todos_repository.dart';
import 'package:gitty/feature/home/domain/usecases/get_comments_usecase.dart';
import 'package:gitty/feature/home/domain/usecases/get_posts_usecase.dart';
import 'package:gitty/feature/home/domain/usecases/get_todos_usecase.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_bloc.dart';
import 'package:gitty/feature/home/presentation/blocs/todos_screen_bloc/todos_screen_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependency() async {
  //blocs
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUsecase: sl.call(),
    ),
  );

  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUsecase: sl.call(),
    ),
  );

  sl.registerFactory<PostScreenBloc>(
    () => PostScreenBloc(
      getPostsUsecase: sl.call(),
    ),
  );

  sl.registerFactory<TodosScreenBloc>(
    () => TodosScreenBloc(
      getTodosUsecase: sl.call(),
    ),
  );

  //services
  sl.registerSingleton<AuthService>(AuthService());

  sl.registerSingleton<PostsService>(PostsService());

  sl.registerSingleton<TodosService>(TodosService());

  //repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authService: sl.call(),
    ),
  );

  sl.registerSingleton<PostsRepoSitory>(
    PostRepositoryImpl(
      postsService: sl.call(),
    ),
  );

  sl.registerSingleton<TodosRepository>(
    TodosRepositoryImpl(
      todosService: sl.call(),
    ),
  );

  //usecases
  sl.registerSingleton<LoginUsecase>(
    LoginUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetPostsUsecase>(
    GetPostsUsecase(
      postsRepoSitory: sl.call(),
    ),
  );

  sl.registerSingleton<GetCommentsUsecase>(
    GetCommentsUsecase(
      postsRepoSitory: sl.call(),
    ),
  );

  sl.registerSingleton<GetTodosUsecase>(
    GetTodosUsecase(
      todosRepository: sl.call(),
    ),
  );
}
