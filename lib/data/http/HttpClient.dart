abstract class HttpClient{
  Future<Map> request({ String url, Map body});
}