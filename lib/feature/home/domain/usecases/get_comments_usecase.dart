import 'package:gitty/feature/home/domain/entity/comment_entity.dart';
import 'package:gitty/feature/home/domain/repositories/posts_repository.dart';

class GetCommentsUsecase {
  final PostsRepoSitory postsRepoSitory;

  GetCommentsUsecase({required this.postsRepoSitory});

  Future<CommentEntity?> getAllComments({required int postId}) async {
    return await postsRepoSitory.getAllComments(postId: postId);
  }
}
