import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../common/controller/api_operation.dart';
import '../data/model/user.dart';
import '../data/provider/remote/user_api.dart';

class UserController extends GetxController
    with StateMixin<List<User>>, ApiOperationMixin {
  final UserApi _userApi = UserApi();//agarra el api de los usuarios de una pagina externa

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }
//Agarra el futuro de tipo void y toma la lista de usuarios segun o el genero o el status del usuario
  Future<void> getUserList(
      {Gender gender = Gender.all, UserStatus status = UserStatus.all}) async {
    change(null, status: RxStatus.loading());
    Either<String, List<User>> failureOrSuccess =
        (await _userApi.getUserList(gender: gender, status: status));
//verifica si hay usuario
    failureOrSuccess.fold(
      (String failure) {
        change(null, status: RxStatus.error(failure));
      },
      (List<User> users) {
        if (users.isEmpty) {
          change(null, status: RxStatus.empty());
        } else {
          change(users, status: RxStatus.success());
        }
      },
    );
  }
//crea estudiante
  void createUser(User user) {
    requestMethodTemplate(_userApi.createUser(user));
  }
//borra estudiante
  void deleteUser(User user) {
    requestMethodTemplate(_userApi.deleteUser(user));
  }
//actualiza estudiante
  void updateUser(User user) {
    requestMethodTemplate(_userApi.updateUser(user));
  }
}
