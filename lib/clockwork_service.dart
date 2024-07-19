import 'package:clockwork_app/clockwork_response.dart';
import 'package:clockwork_app/const.dart';
import 'package:dio/dio.dart';

class ClockworkService {
  final Dio dio;

  ClockworkService(this.dio);

  Future<ClockworkResponse> startTimer(String issue) async {
    final response = await dio.post('${endpoint}start_timer',
        data: {'issue_key': issue},
        options: Options(headers: {'Authorization': 'Token $token'}));

    return ClockworkResponse.fromJson(response.data);
  }

  Future<ClockworkResponse> stopTimer(String issue) async {
    final response = await dio.post('${endpoint}stop_timer',
        data: {'issue_key': issue},
        options: Options(headers: {'Authorization': 'Token $token'}));

    return ClockworkResponse.fromJson(response.data);
  }
}
