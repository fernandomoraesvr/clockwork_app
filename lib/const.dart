import 'package:flutter_dotenv/flutter_dotenv.dart';

final String token = dotenv.env['CLOCKWORK_TOKEN'] ?? "";

const String endpoint = "https://api.clockwork.report/v1/";
