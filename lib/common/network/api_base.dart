import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'dio_client.dart';
import 'dio_exception.dart';

abstract class ApiBase<T> {
  final DioClient dioClient = DioClient();
  late final T data;

  //metodo generico del tema para agarrar datos
  Future<Either<String, List<T>>> getData(Future<Response<dynamic>> apiCallback,
      T Function(Map<String, dynamic> json) getJsonCallback) async {
    try {
      final Response response = await apiCallback;

      final List<T> dataList = List<T>.from(
        json.decode(json.encode(response.data)).map(
              (item) => getJsonCallback(item),
            ),
      );
      return right(dataList);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }

  //metodo generico para crear actualizar y borarr en la clase api
  Future<Either<String, bool>> requestMethodTemplate(
      Future<Response<dynamic>> apiCallback) async {
    try {
      await apiCallback;
      return right(true);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return left(errorMessage);
    }
  }
}
