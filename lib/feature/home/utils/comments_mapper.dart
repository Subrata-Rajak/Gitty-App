import 'package:gitty/feature/home/data/models/comments_model.dart';
import 'package:gitty/feature/home/domain/entity/comment_entity.dart';

class CommentsMapper {
  static CommentsMapper instance = CommentsMapper();

  CommentEntity mapModelToEntity({required CommentsModel commentsModel}) {
    return CommentEntity(
      statusCode: commentsModel.statusCode,
      data: commentsModel.data
          .map(
            (e) => CommentsDataEntity(
              postId: e.postId,
              id: e.id,
              name: e.name,
              email: e.email,
              body: e.body,
            ),
          )
          .toList(),
      message: commentsModel.message,
      success: commentsModel.success,
    );
  }

  CommentsModel mapEntityToModel({required CommentEntity commentEntity}) {
    return CommentsModel(
      statusCode: commentEntity.statusCode,
      data: commentEntity.data
          .map(
            (e) => CommentsData(
              postId: e.postId,
              id: e.id,
              name: e.name,
              email: e.email,
              body: e.body,
            ),
          )
          .toList(),
      message: commentEntity.message,
      success: commentEntity.success,
    );
  }
}
