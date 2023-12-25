import 'package:gitty/core/common/constants.dart';
import 'package:gitty/core/common/services.dart';
import 'package:gitty/core/local_storage/keys.dart';
import 'package:gitty/core/local_storage/storage.dart';
import 'package:gitty/feature/home/data/models/comments_model.dart';
import 'package:gitty/feature/home/data/models/posts_model.dart';
import 'package:gitty/feature/home/domain/entity/comment_entity.dart';
import 'package:gitty/feature/home/domain/entity/post_entity.dart';
import 'package:gitty/feature/home/utils/comments_mapper.dart';
import 'package:gitty/feature/home/utils/posts_mapper.dart';

class PostsService {
  final client = HttpService.instance.httpClient;

  Future<PostEntity?> getAllPosts() async {
    PostEntity? posts;
    final userToken = await LocalStorage.instance
        .readStringFromLocalDb(key: AppLocalStorageKeys.instance.userToken);

    if (userToken == null) {
      return null;
    } else {
      try {
        final url = '${AppConstants.instance.baseUrl}posts';

        final headers = {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $userToken",
        };

        final uri = Uri.parse(url);

        final response = await client.get(
          uri,
          headers: headers,
        );

        print(response.statusCode);

        if (response.statusCode == 200) {
          PostsModel postsModel = postsModelFromJson(response.body);
          posts = PostsMapper.instance.mapModelToEntity(postsModel: postsModel);
        }
      } catch (error) {
        print("Error while fetching posts -- API: $error");
      }
    }
    return posts;
  }

  Future<CommentEntity?> getAllComments({required int postId}) async {
    CommentEntity? comments;
    final userToken = await LocalStorage.instance
        .readStringFromLocalDb(key: AppLocalStorageKeys.instance.userToken);

    if (userToken == null) {
      return null;
    } else {
      try {
        final url = '${AppConstants.instance.baseUrl}posts/comments';

        final queryParams = {
          "postId": "$postId",
        };

        final headers = {
          "Content-Type": 'application/json',
          "Authorization": "Bearer $userToken",
        };

        final uri = Uri.parse(url).replace(queryParameters: queryParams);

        final response = await client.get(
          uri,
          headers: headers,
        );

        if (response.statusCode == 200) {
          CommentsModel commentsModel = commentsModelFromJson(response.body);
          comments = CommentsMapper.instance
              .mapModelToEntity(commentsModel: commentsModel);
        }
      } catch (error) {
        print("Error while fetching comments -- API: $error");
      }
    }
    return comments;
  }
}
