import 'dart:async';
import 'dart:ffi';

import 'package:golang/api/service.dart';
import 'package:golang/model/github_model.dart';
import 'package:golang/model/user_model.dart';

class GithubBaseApi {
  final _endpointBookMark = '/bookmark';
  final _endpointUser = '/user';
  Future<List<GithubModel>> githubTrending() async {
    var c = Completer<List<GithubModel>>();
    try {
      var response = await GithubService.instance.dio.get(
        '/github/trending',
      );
      var result = GithubModel.parseRepoList(response.data);
      c.complete(result);
      print(response.data.toString());
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<Void> bookmark(String repoName) async {
    var c = Completer<Void>();

    try {
      var response = await GithubService.instance.dio.post(
        '$_endpointBookMark/add',
        data: {'repo': repoName},
      );
      if (response.statusCode == 200) {
        c.complete();
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<Void> delBookmark(String repoName) async {
    var c = Completer<Void>();

    try {
      var response = await GithubService.instance.dio
          .delete('$_endpointBookMark/delete', data: {
        'repq': repoName,
      });

      if (response.statusCode == 200) {
        c.complete();
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<List<GithubModel>> listBookmarks() async {
    var c = Completer<List<GithubModel>>();

    try {
      var response =
          await GithubService.instance.dio.get('$_endpointBookMark/list');
      if (response.statusCode == 200) {
        var result = GithubModel.parseRepoList(response.data);
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<UserModel> profile() async {
    var c = Completer<UserModel>();

    try {
      var response =
          await GithubService.instance.dio.get('$_endpointUser/profile');
      if (response.statusCode == 200) {
        var result = UserModel.fromJson(response.data['data']);
        c.complete(result);
      }
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<UserModel> updateProfile(UserModel userModel) async {
    var c = Completer<UserModel>();

    try {
      var response = await GithubService.instance.dio
          .put('$_endpointUser/profile/update', data: {
        'fullName': userModel.fullName,
        'email': userModel.email,
      });
      var result = UserModel.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<UserModel> signUp(String email, String pass, String fullName) async {
    var c = Completer<UserModel>();

    try {
      var response =
          await GithubService.instance.dio.post('/user/sign_up', data: {
        "email": email,
        "password": pass,
        "fullName": fullName,
      });
      var result = UserModel.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }

  Future<UserModel> signIn(String email, String pass) async {
    var c = Completer<UserModel>();

    try {
      var response =
          await GithubService.instance.dio.post('/user/sign-in', data: {
        "email": email,
        "password": pass,
      });
      var result = UserModel.fromJson(response.data['data']);
      c.complete(result);
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
