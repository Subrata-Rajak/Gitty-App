import 'package:gitty/feature/home/domain/entity/comment_entity.dart';
import 'package:gitty/feature/home/domain/entity/post_entity.dart';

abstract class PostsRepoSitory {
  Future<PostEntity?> getAllPosts();
  Future<CommentEntity?> getAllComments({required int postId});
}
