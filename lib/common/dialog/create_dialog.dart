import 'package:flutter/material.dart';

import '../widget/drop_down.dart';
import '../../features/user/data/model/user.dart';
import '../widget/text_input.dart';

enum Type { create, update }

Future<dynamic> createDialog({
  User? user,
  required BuildContext context,
  required void Function(User) userData,
  Type type = Type.create,
}) {
//Si el usuario no es null entonces es update sino se crea
  //No se necesita id porque el server nos da al crear
  //son para revisar el null en algunos de estos valores

  String userName = user?.name ?? "";
  String email = user?.email ?? "";
  Gender gender = user?.gender ?? Gender.male;
  UserStatus userStatus = user?.status ?? UserStatus.inactive;
  int? id = user?.id;
  final formKey = GlobalKey<FormState>();

  var dialog = showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        // shape: const RoundedRectangleBorder(
        //   side: BorderSide(color: Color(0xFFF4511E), width: 1.0),
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(15.0),
        //   ),
        // ),
        title: Text(type == Type.create ? "Crear nuevo estudiante" : "Actualizar estudiante",
            textAlign: TextAlign.center),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput(
                  initialValue: userName,
                  hint: "Ingrese nombre",
                  onChanged: (String value) {
                    userName = value;
                  },
                  validator: (String? value) {
                    if (value!.isNotEmpty) return null;
                    return "Nombre no puede estar vacio";
                  },
                ),
                const SizedBox(height: 15),
                TextInput(
                  hint: "Ingrese email",
                  initialValue: email,
                  onChanged: (String value) {
                    email = value;
                  },
                  validator: (String? value) {
                    if (value!.contains(RegExp(r'@[a-zA-Z_]'))) return null;
                    return "Email es invalido";
                  },
                ),
                const SizedBox(height: 15),
                DropDown<Gender>(
                  initialItem: gender,
                  items: Gender.values.sublist(0, 2),
                  onChanged: (Gender value) {
                    gender = value;
                  },
                ),
                const SizedBox(height: 15),
                DropDown<UserStatus>(
                  initialItem: userStatus,
                  items: UserStatus.values.sublist(0, 2),
                  onChanged: (UserStatus value) {
                    userStatus = value;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        userData(
                          User(
                              id: id,
                              email: email,
                              status: userStatus,
                              name: userName,
                              gender: gender),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(type == Type.create ? "Crear" : "Actualizar"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancelar"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );

  return dialog.then((res) => res ?? false);
}
