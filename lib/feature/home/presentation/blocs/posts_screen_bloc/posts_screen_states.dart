import 'package:gitty/feature/home/domain/entity/post_entity.dart';

abstract class PostScreenStates {}

class PostInitialState extends PostScreenStates {}

class FetchingPostsState extends PostScreenStates {}

class PostsFetchingSuccessfulState extends PostScreenStates {
  final PostEntity? postEntity;

  PostsFetchingSuccessfulState({required this.postEntity});
}

class PostsFetchingFailedState extends PostScreenStates {
  final String errorMessage;

  PostsFetchingFailedState({required this.errorMessage});
}
