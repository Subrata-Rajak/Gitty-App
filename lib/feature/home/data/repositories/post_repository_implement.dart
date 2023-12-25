import 'package:gitty/feature/home/data/data_source/posts_service.dart';
import 'package:gitty/feature/home/domain/entity/comment_entity.dart';
import 'package:gitty/feature/home/domain/entity/post_entity.dart';
import 'package:gitty/feature/home/domain/repositories/posts_repository.dart';

class PostRepositoryImpl implements PostsRepoSitory {
  final PostsService postsService;

  PostRepositoryImpl({required this.postsService});

  @override
  Future<CommentEntity?> getAllComments({required int postId}) async {
    return await postsService.getAllComments(postId: postId);
  }

  @override
  Future<PostEntity?> getAllPosts() async {
    return await postsService.getAllPosts();
  }
}
