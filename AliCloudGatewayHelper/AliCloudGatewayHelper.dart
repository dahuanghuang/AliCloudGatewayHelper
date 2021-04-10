import 'SignUtil.dart';
import 'dart:core';
import 'package:dio/dio.dart';

String apiGatewayAppKey = '24613452';
String apiGatewayAppSecret = 'b2572833a25319adf0bb4ea6b1d6010b';

class AliCloudGatewayReqeust {

  Map<String, dynamic> buildHeader(String method, String host, String path) {

    Map<String, dynamic> summaryHeaderParams = {};

    // 设置请求头中的时间
    String current = new DateTime.now().toString();
    summaryHeaderParams[CLOUDAPI_HTTP_HEADER_DATE] = current;

    // 设置请求头中的时间戳，以timeIntervalSince1970的形式
    String timeStamp = new DateTime.now().millisecondsSinceEpoch.toString();
    summaryHeaderParams[CLOUDAPI_X_CA_TIMESTAMP] = timeStamp;

    // 请求放重放Nonce,15分钟内保持唯一,建议使用UUID
    summaryHeaderParams[CLOUDAPI_X_CA_NONCE] = '';

    // 设置请求头中的UserAgent
    summaryHeaderParams[CLOUDAPI_HTTP_HEADER_USER_AGENT] = CLOUDAPI_USER_AGENT;

    // 设置请求头中的主机地址
    summaryHeaderParams[CLOUDAPI_HTTP_HEADER_HOST] = host;

    // 设置请求头中的Api绑定的的AppKey
    summaryHeaderParams[CLOUDAPI_X_CA_KEY] = apiGatewayAppKey;

    // 设置签名版本号
    summaryHeaderParams[CLOUDAPI_X_CA_VERSION] = CLOUDAPI_CA_VERSION;

    // 设置请求数据类型
    summaryHeaderParams[CLOUDAPI_HTTP_HEADER_CONTENT_TYPE] = CLOUDAPI_CONTENT_TYPE_JSON;

    // 设置响应数据类型
    summaryHeaderParams[CLOUDAPI_HTTP_HEADER_ACCEPT] = CLOUDAPI_CONTENT_TYPE_JSON;

    // 将Request中的httpMethod、headers、path、queryParam、formParam合成一个字符串用hmacSha256算法双向加密进行签名
    // 签名内容放到Http头中，用作服务器校验
    summaryHeaderParams[CLOUDAPI_X_CA_SIGNATURE] = sign(method, summaryHeaderParams, path, {}, {}, apiGatewayAppSecret);

    return summaryHeaderParams;
  }
}