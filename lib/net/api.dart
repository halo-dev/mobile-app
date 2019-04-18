import 'package:halo/net/http/http_manager.dart';
import 'package:halo/net/http/result_data.dart';
import 'package:rxdart/rxdart.dart';

const String BaseUrl = "http://www.apkdv.com";

class Api {
  ///邮箱账号
  Observable<ResultData> accountList() =>
      Observable.fromFuture(Http.post("/email_service/v3/accountList"));

  ///   /**
  //     * 登录,获取Token
  //     *
  //     * @param account   用户名
  //     * @param password  密码
  //     * @param companyId 公司id
  //     * @param memory    记住密码选择
  //     * @return 登录token
  //     */
  //    @POST("auth_center/v3/login")
  //    @FormUrlEncoded
  //    Observable<LoginSuccessEntity> login(@Field("account") String account,
  //                                         @Field("password") String password,
  //                                         @Field("company_id") String companyId,
  //                                         @Field("memory") String memory,
  //                                         @Field("device_id") String deviceId);
  ///
  /// 登录,获取Token
  ///
  Observable<ResultData> login(map) =>
      Observable.fromFuture(Http.post("/auth_center/v3/login", params: map));

  ///
  /// 获取用户信息
  /// @param system_type
  /// @return User
  Observable<ResultData> user(Map<String, dynamic> map) =>
      Observable.fromFuture(Http.post("/user_center/v3/member_info", params: map));

  Observable<ResultData> getPosts({Map<String, dynamic> query}) =>
      Observable.fromFuture(Http.get("/api/admin/posts", query: query));
}
