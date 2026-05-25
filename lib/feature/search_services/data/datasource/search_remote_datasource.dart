import 'package:swasthyamap/core/network/dio_client.dart';
import 'package:swasthyamap/core/utils/data_parse_helper/data_parse_helper.dart';
import 'package:swasthyamap/feature/search_services/data/model/doctor_search_res_dto_model.dart';
import 'package:swasthyamap/feature/search_services/domain/entities/doctor_search_res_dto.dart';

import '../../../../core/error/exceptions.dart';

abstract class SearchRemoteDatasource {
Future<List<DoctorSearchResDtoModel>> searchDoctors(Map<String,dynamic> data);
}

class SearchRemoteDatasourceImpl implements SearchRemoteDatasource{
  final DioClient _dioClient;
  SearchRemoteDatasourceImpl(this._dioClient);

  @override
  Future<List<DoctorSearchResDtoModel>> searchDoctors(Map<String, dynamic> data)async {
    try{
      final response = await _dioClient.post(url: "/v1/search/doctor",data: data);
      if(response==null){
        return [];
      }
      return DataParseHelper.safeList(response,parser: (data)=>DoctorSearchResDtoModel.fromJson(data));
    }on ServerException catch(e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}