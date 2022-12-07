import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../common/controller/api_operation.dart';
import '../../user/data/model/user.dart';
import '../data/model/post.dart';
import '../data/provider/remote/post_api.dart';

//controlador del post da formato a los datos.
class PostController extends GetxController with StateMixin<List<Post>>,ApiOperationMixin {
  final PostApi _postApi = PostApi();

  RxInt postLength = 0.obs;

  Future<void> getPosts(User user) async {
    change(null, status: RxStatus.loading());
    Either<String, List<Post>> failureOrSuccess = await _postApi.getPosts(user);
    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<Post> posts) {
        postLength.value = posts.length;
        if (posts.isEmpty) {
          change(posts, status: RxStatus.empty());
        } else {
          change(posts, status: RxStatus.success());
        }

      },
    );
  }
//metodo que llama al molde de la api para publicar el post
  void createPost(Post post) {
    requestMethodTemplate(_postApi.createPost(post));
  }
//metodo que actualiza el post con la api
  void updatePost(Post post) async {
    requestMethodTemplate(_postApi.updatePost(post));
  }
//borrar el post.
  void deletePost(Post post) async {
    requestMethodTemplate(_postApi.deletePost(post));
  }
}
