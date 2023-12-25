import 'package:gitty/feature/home/domain/entity/post_entity.dart';
import 'package:gitty/feature/home/domain/repositories/posts_repository.dart';

class GetPostsUsecase {
  final PostsRepoSitory postsRepoSitory;

  GetPostsUsecase({required this.postsRepoSitory});

  Future<PostEntity?> getAllPosts() async {
    return await postsRepoSitory.getAllPosts();
  }
}
