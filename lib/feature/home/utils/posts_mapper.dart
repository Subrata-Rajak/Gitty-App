import 'package:gitty/feature/home/data/models/posts_model.dart';
import 'package:gitty/feature/home/domain/entity/post_entity.dart';

class PostsMapper {
  static PostsMapper instance = PostsMapper();

  PostEntity mapModelToEntity({required PostsModel postsModel}) {
    return PostEntity(
      statusCode: postsModel.statusCode,
      data: postsModel.data
          .map(
            (e) => PostDataEntity(
              userId: e.userId,
              id: e.id,
              title: e.title,
              body: e.body,
            ),
          )
          .toList(),
      message: postsModel.message,
      success: postsModel.success,
    );
  }

  PostsModel mapEntityToModel({required PostEntity postEntity}) {
    return PostsModel(
      statusCode: postEntity.statusCode,
      data: postEntity.data
          .map(
            (e) => PostDatum(
              userId: e.userId,
              id: e.id,
              title: e.title,
              body: e.body,
            ),
          )
          .toList(),
      message: postEntity.message,
      success: postEntity.success,
    );
  }
}
