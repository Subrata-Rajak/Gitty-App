import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitty/feature/home/domain/entity/post_entity.dart';
import 'package:gitty/feature/home/domain/usecases/get_posts_usecase.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_events.dart';
import 'package:gitty/feature/home/presentation/blocs/posts_screen_bloc/posts_screen_states.dart';

class PostScreenBloc extends Bloc<PostScreenEvents, PostScreenStates> {
  final GetPostsUsecase getPostsUsecase;
  PostScreenBloc({required this.getPostsUsecase}) : super(PostInitialState()) {
    on<FetchPostsEvent>(fetchPosts);
  }

  Future<void> fetchPosts(
    FetchPostsEvent event,
    Emitter<PostScreenStates> emit,
  ) async {
    emit(FetchingPostsState());
    print("aa raha hai");

    try {
      PostEntity? posts = await getPostsUsecase.getAllPosts();

      if (posts != null) {
        emit(PostsFetchingSuccessfulState(postEntity: posts));
      } else {
        emit(PostsFetchingFailedState(errorMessage: "Fetching posts failed"));
      }
    } catch (error) {
      print("Error while Fetching posts -- POST BLOC: $error");
      emit(PostsFetchingFailedState(errorMessage: "Internal error"));
    }
  }
}
