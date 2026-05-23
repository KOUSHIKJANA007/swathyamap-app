import 'package:swasthyamap/core/network/dio_client.dart';
import 'package:swasthyamap/feature/auth/data/model/login_response_dto_model.dart';
import 'package:swasthyamap/feature/auth/data/model/user_model.dart';

import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDatasource {
  Future<LoginResponseDtoModel> login(Map<String,dynamic> data);
  Future<UserModel> findCurrentLoggedInUser();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl(this._dioClient);

  @override
  Future<LoginResponseDtoModel> login(Map<String, dynamic> data)async {
    try{
      final response = await _dioClient.post(url: "/v1/auth/login",data: data);
      if(response==null){
        throw ServerException("Login result is empty");
      }
      return LoginResponseDtoModel.fromJson(response);
    }on ServerException catch(e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> findCurrentLoggedInUser()async {
    try{
      final response = await _dioClient.get(url: "/v1/user/currentLoggedInUser");
      if(response==null){
        throw ServerException("Current user is empty");
      }
      return UserModel.fromJson(response);
    }on ServerException catch(e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
