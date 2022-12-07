import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/features/comment/data/model/comment.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/api_config.dart';
//este es el ayudante para las conexiones y ediciones de los comentarios
class CommentApi extends ApiBase<Comment> {
  Future<Either<String, List<Comment>>> getUserComments(int postId) async {
    final queryParameters = {'post_id': "$postId"};

    Future<Either<String, List<Comment>>> result = getData(
        dioClient.dio!
            .get(ApiConfig.comments, queryParameters: queryParameters),
        Comment.fromJson);

    return result;
  }
//creacion del comentario con la api
  Future<Either<String, bool>> createComment(Comment comment) async {
    return await requestMethodTemplate(
      dioClient.dio!.post(ApiConfig.comments, data: comment),
    );
  }
//borrar el comentario con la api
  Future<Either<String, bool>> deleteComment(Comment comment) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.comments}/${comment.id}"),
    );
  }
}
