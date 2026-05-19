import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../../feature/auth/data/model/user_model.dart';
import '../../../feature/auth/domain/entities/user.dart';
import 'local_auth_storage_service.dart';

abstract class AuthSessionService {
  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String token);
  Future<void> saveUserInfo(UserModel userInfo);
  Future<User?> getCurrentUser();
  Future<String> getAccessToken();
  Future<String> getRefreshToken();
  Future<String> getDeviceToken();
  Future<void> removeAllData();
}

class AuthSessionServiceImpl implements AuthSessionService{
  final LocalAuthStorageService authStorageService;
  AuthSessionServiceImpl(this.authStorageService);

  static final String accessToken = 'access_token';
  static final String refreshToken = 'refresh_token';
  static final String deviceToken = 'device_token';
  static final String isAppLock = 'is_app_lock';
  static final String currentUser = 'current_user';
  static final String selectedClub = 'selected_club';
  static final String isLogin = 'is_login';

  @override
  Future<void> saveAccessToken(String token)async {
    await authStorageService.setValue(accessToken, token);
    await authStorageService.setValue(isLogin,'true');
  }

  @override
  Future<void> saveRefreshToken(String token)async {
    await authStorageService.setValue(refreshToken, token);
  }

  @override
  Future<void> saveUserInfo(UserModel userInfo) async{
    await authStorageService.setValue(currentUser, jsonEncode(userInfo.toJson()));
  }

  @override
  Future<User?> getCurrentUser() async{
    try{
      var userInfo = await authStorageService.getValue(currentUser);
      if(userInfo != null){
        return UserModel.fromJson(jsonDecode(userInfo));
      }
      return null;
    }catch(e){
      debugPrint('error in getting current user --> $e');
      return null;
    }
  }

  @override
  Future<String> getAccessToken()async{
    try{
      var tokenInfo = await authStorageService.getValue(accessToken);
      if(tokenInfo != null){
        return tokenInfo;
      }
      return '';
    }catch(e){
      debugPrint('error in getting token info --> $e');
      return '';
    }
  }

  @override
  Future<String> getRefreshToken()async{
    try{
      var tokenInfo = await authStorageService.getValue(refreshToken);
      if(tokenInfo != null){
        return tokenInfo;
      }
      return '';
    }catch(e){
      debugPrint('error in getting refresh token info --> $e');
      return '';
    }
  }

  @override
  Future<String> getDeviceToken()async{
    try{
      var tokenInfo = await authStorageService.getValue(deviceToken);
      if(tokenInfo != null){
        return tokenInfo;
      }
      return '';
    }catch(e){
      debugPrint('error in getting token info --> $e');
      return '';
    }
  }

  @override
  Future<void> removeAllData()async{
    try{
      await authStorageService.deleteAllValue();
    }catch(e){
      debugPrint('error in clearing info from session --> $e');
    }
  }

}