import 'package:dio/dio.dart';
import 'package:swasthyamap/core/error/exceptions.dart';
import 'package:swasthyamap/core/network/dio_client.dart';
import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/feature/institution/data/model/institute_res_dto_model.dart';

abstract class InstituteRemoteDatasource {
  Future<List<InstituteResDtoModel>> findAllInstituteByOwner(String userId,int pageSize, int pageNumber, String searchKey);
  Future<InstituteResDtoModel> createInstitute(FormData formData);
}

class InstituteRemoteDatasourceImpl implements InstituteRemoteDatasource{
  final DioClient _dioClient;
  InstituteRemoteDatasourceImpl(this._dioClient);

  @override
  Future<List<InstituteResDtoModel>> findAllInstituteByOwner(String userId, int pageSize, int pageNumber, String searchKey)async {
    try{
      final resp = await _dioClient.get(url: "/v1/institute/user/$userId?pageNumber=$pageNumber&pageSize=$pageSize&searchKey=$searchKey");
      if(resp == null){
        return [];
      }
      return DataParseHelper.safeList(resp,parser: (e)=>InstituteResDtoModel.fromJson(e));
    }on ServerException catch(e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<InstituteResDtoModel> createInstitute(FormData formData)async {
    try{
      final response = await _dioClient.upload(url: "/v1/institute/create", formData: formData, method: 'POST');
      if(response == null){
        throw ServerException("create institute result is null");
      }
      return InstituteResDtoModel.fromJson(response);
    }catch(e){
      throw ServerException(e.toString());
    }
  }


}