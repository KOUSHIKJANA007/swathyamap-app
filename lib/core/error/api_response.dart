import 'package:equatable/equatable.dart';
import '../emuns/api_status_emun.dart';

class ApiResponse<T> extends Equatable{
  final Status? status;
  final T? data;
  final String? message;

  const ApiResponse(this.status, this.data, this.message);
  const ApiResponse.loading():status=Status.LOADING,data=null,message=null;
  const ApiResponse.init():status=Status.INITIAL,data=null,message=null;
  const ApiResponse.completed(this.data):status=Status.COMPLETED,message=null;
  const ApiResponse.error(this.message):status=Status.ERROR,data=null;

  @override
  List<Object?> get props => [status,data,message];
}