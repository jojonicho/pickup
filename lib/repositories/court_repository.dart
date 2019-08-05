import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:scratch/models/models.dart';
import 'package:scratch/repositories/court_api_client.dart';

class CourtRepository {
  final CourtApiClient courtApiClient;

  CourtRepository({@required this.courtApiClient})
      : assert(courtApiClient != null);

  Future<List<Court>> getNearCourts(LocationData location) async {
    return await courtApiClient.fetchCourts(location);
  }
}
