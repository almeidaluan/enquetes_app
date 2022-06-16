abstract class HttpClient{
  Future<void>? request({String? url, Map? body});
}