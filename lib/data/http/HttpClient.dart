abstract class HttpClient{
  Future<void>? request({required String url, Map body});
}