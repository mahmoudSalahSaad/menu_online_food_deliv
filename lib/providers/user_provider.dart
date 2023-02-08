import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menu_egypt/models/City.dart';
import 'package:menu_egypt/models/Region.dart';
import 'package:menu_egypt/models/User.dart';
import 'package:menu_egypt/models/setting.dart';
import 'package:menu_egypt/services/http_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String _userCity;
  String _userRegion;
  String _emailExist;
  int forgetPasswordUserId;
  List<String> _sliders = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final _facebookLogin = FacebookAuth.instance;
  final HttpServiceImpl httpService = HttpServiceImpl();

  bool get isLoading {
    return _isLoading;
  }

  bool get isAuthenticated {
    return _isAuthenticated;
  }

  UserModel get user {
    return _user;
  }

  String get userCity {
    return _userCity;
  }

  String get userRegion {
    return _userRegion;
  }

  String get emailExist {
    return _emailExist;
  }

  List<String> get sliders {
    return _sliders;
  }

  Future<Map<String, dynamic>> signUp(formData) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _emailExist = '';
    final Map<String, dynamic> userData = {
      'full_name': formData['fullName'],
      'password': formData['password'],
      'email': formData['email'],
      'phone_number': formData['phoneNumber'],
      'city_id': formData['cityId'],
      'region_id': formData['regionId'],
      'gender': formData['gender'],
      'birth_date': formData['birth_date'],
      'fcm_token': 'dummyfcmtoken',
    };
    print(formData['gender']);
    _isLoading = true;
    notifyListeners();
    String url = '/register';
    httpService.init();

    try {
      Response response = await httpService.postRequest(url, userData, '');
      print(response.data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        var parsedUser = response.data['user'];
        UserModel user = UserModel(
          id: parsedUser['id'],
          regionId: parsedUser['region_id'],
          cityId: parsedUser['city_id'],
          email: parsedUser['email'],
          fullName: parsedUser['full_name'],
          phoneNumber: parsedUser['phone_number'],
          //avatarUrl: '',
          //authType: 'email',
          favorites: [],
          apiToken: parsedUser['api_token'],
          birthDate: parsedUser['birth_date'],
          gender: parsedUser['gender'],
        );
        _user = user;
        storeAuthUser(user, response.data['user']['api_token'], true);
        result['success'] = true;
        result['msg'] = response.data['message'];
        print('Register Success');
      } else {
        print('Register Failed');
        result['error'] = response.data['message'];
        if (result['error'].toString().contains('email')) {
          _emailExist = formData['email'];
        }
      }
    } catch (error) {
      print('Catch error');
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> editUserData(formData) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    final Map<String, dynamic> userData = {
      'full_name': formData['fullName'],
      'email': formData['email'],
      'phone_number': formData['phoneNumber'],
      'city_id': formData['cityId'],
      'region_id': formData['regionId'],
      'birth_date': formData['birth_date'],
      'gender': formData['gender'],
    };
    _isLoading = true;
    notifyListeners();
    String url = '/update-profile';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.postRequest(url, userData, token);
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        var parsedUser = response.data['user'];
        UserModel user = UserModel(
          id: parsedUser['id'],
          regionId: parsedUser['region_id'],
          cityId: parsedUser['city_id'],
          email: parsedUser['email'],
          fullName: parsedUser['full_name'],
          phoneNumber: parsedUser['phone_number'],
          //avatarUrl: '',
          //authType: 'email',
          favorites: [],
          apiToken: token,
          birthDate: parsedUser['birth_date'],
          gender: parsedUser['gender'],
        );
        _user = user;
        storeAuthUser(_user, token, true);
        result['success'] = true;
      } else {
        result['error'] = response.data['message'];
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> signIn(formData) async {
    _emailExist = '';
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'verified': 0
    };
    final Map<String, dynamic> userData = {
      'password': formData['password'],
      'email': formData['email'],
    };
    _isLoading = true;
    notifyListeners();
    String url = '/login';
    httpService.init();
    try {
      Response response = await httpService.postRequest(url, userData, '');
      print(response.data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        var parsedUser = response.data['user'];
        var parsedFavorites = parsedUser['favorites'] as List;
        UserModel user = UserModel(
          id: parsedUser['id'],
          regionId: parsedUser['region_id'],
          cityId: parsedUser['city_id'],
          email: parsedUser['email'],
          fullName: parsedUser['full_name'],
          phoneNumber: parsedUser['phone_number'],
          //avatarUrl: '',
          //authType: 'email',
          favorites: [],
          apiToken: parsedUser['api_token'],
          birthDate: parsedUser['birth_date'],
          gender: parsedUser['gender'],
        );

        parsedFavorites.forEach((fav) {
          user.favorites.add(fav['restaurant_id']);
        });

        _user = user;

        if (response.data['user']['verified'] == 1) {
          storeAuthUser(_user, response.data['user']['api_token'], true);
          result['success'] = true;
          result['verified'] = 1;
          print('Login Success & Verified');
        } else {
          final SharedPreferences preferences =
              await SharedPreferences.getInstance();
          preferences.setString('apiToken', response.data['user']['api_token']);

          result['success'] = false;
          result['verified'] = 0;
          print('Login Success & Unverified');
        }
        result['error'] = response.data['message'];
      } else {
        result['error'] = response.data['message'];
        print('Login Failed');
      }
    } catch (error) {
      print('catch error');
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> sendEmailForResetPassword(String email) async {
    Map<String, dynamic> result = {'success': true, 'error': null};
    _isLoading = true;
    notifyListeners();
    try {
      await _auth.sendPasswordResetEmail(email: email).catchError((error) {
        result['success'] = false;
        result['error'] = error;
      });
    } catch (error) {
      result['success'] = false;
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> signOut() async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    String url = '/logout';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.postRequest(url, null, token);
      print(response);
      if (response.statusCode == 200 &&
          response.data['message']
              .toString()
              .contains('تم تسجيل الخروج بنجاح')) {
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }

    await _auth.signOut().then((value) {
      result['success'] = true;
    }).catchError((error) {
      result['error'] = error;
    });

    _user = null;
    storeAuthUser(_user, '', false);
    return result;
  }

  /*
  Future<Map<String, dynamic>> signInWithSocialMedia(String social) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    User user;
    Map<String, dynamic> postUser;
    _isLoading = true;
    notifyListeners();
    String url = '/loginWithSocial';
    httpService.init();
    try {
      UserCredential userCredential;

      if (social == "Fb") {
        userCredential = await facebookConfigurations();
      } else {
        userCredential = await googleConfigurations();
      }
      user = userCredential.user;
      if (user != null) {
        assert(user.providerData[0].displayName != null);
        postUser = {
          'full_name': user.providerData[0].displayName,
          'email': user.providerData[0].email == null
              ? null
              : user.providerData[0].email,
          'phone_number': user.providerData[0].phoneNumber == null
              ? null
              : user.providerData[0].phoneNumber,
          'auth_type': social == "Fb" ? 'facebook' : 'google',
          'avatar_url': user.providerData[0].photoURL != null
              ? user.providerData[0].photoURL
              : "",
        };
        Response response = await httpService.postRequest(url, postUser, '');
        if (response.statusCode == 200 && response.data['status_code'] == 201) {
          var parsedUser = response.data['data']['user'];
          var parsedFavorites = response.data['data']['favorites'] as List;
          UserModel userData = UserModel(
              id: parsedUser['id'],
              cityId: parsedUser['city_id'] == null
                  ? parsedUser['city_id']
                  : parsedUser['city_id'],
              regionId: parsedUser['region_id'] == null
                  ? parsedUser['region_id']
                  : parsedUser['region_id'],
              email: parsedUser['email'],
              fullName: parsedUser['full_name'],
              phoneNumber: parsedUser['phone_number'],
              avatarUrl: '',
              authType: social == "Fb" ? 'facebook' : 'google',
              favorites: []);
          parsedFavorites.forEach((fav) {
            userData.favorites.add(fav['restaurant_id']);
          });
          _user = userData;
          storeAuthUser(_user, response.data['data']['access_token'], true);
          result['success'] = true;
        } else {
          result['error'] = response.data['errors'];
        }
      } else {
        result['error'] = user;
      }
    } catch (error) {
      result['error'] = error;
      print(error);
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
  */
  /*
  Future<UserCredential> facebookConfigurations() async {
    UserCredential userCredential;

    final LoginResult result = await _facebookLogin.login();
    if (result.status == LoginStatus.success) {
      FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken.token);
      userCredential = await _auth.signInWithCredential(facebookAuthCredential);
    }
    print(userCredential);
    return userCredential;
  }
  */
  Future<UserCredential> googleConfigurations() async {
    UserCredential userCredential;
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    GoogleAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    userCredential = await _auth.signInWithCredential(googleAuthCredential);
    return userCredential;
  }

  Future<Map<String, dynamic>> addFavorite(int restaurantId) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/favoritesrestaurants';
    httpService.init();
    try {
      Response response = await httpService.postRequest(
          url, {'restaurant_id': restaurantId, 'user_id': _user.id}, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> removeFavorite(int restaurantId) async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/removefavorite';
    httpService.init();
    try {
      Response response = await httpService.postRequest(
          url, {'restaurant_id': restaurantId, 'user_id': _user.id}, '');

      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> getUser() async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    final Map<String, dynamic> userData = {
      'user_id': _user.id,
    };
    _isLoading = true;
    notifyListeners();
    String url = '/getuser';

    httpService.init();
    try {
      Response response = await httpService.postRequest(url, userData, '');
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        var parsedUser = response.data['data']['user'];
        var parsedFavorites = parsedUser['favorites'] as List;
        UserModel userData = UserModel(
            id: parsedUser['id'],
            cityId: parsedUser['city_id'],
            regionId: parsedUser['region_id'],
            email: parsedUser['email'],
            fullName: parsedUser['full_name'],
            phoneNumber: parsedUser['phone_number'],
            avatarUrl: parsedUser['avatar_url'],
            authType: parsedUser['auth_type'],
            favorites: []);
        parsedFavorites.forEach((fav) {
          userData.favorites.add(fav['restaurant_id']);
        });
        _user = userData;
        storeAuthUser(_user, response.data['data']['access_token'], true);
        result['success'] = true;
      } else {
        result['error'] = response.data['errors'];
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  void fetchUserCity(List<CityModel> cities) {
    if (_user.cityId != null) {
      var city = cities.firstWhere((city) => city.cityId == _user.cityId);
      _userCity = city.nameAr;
    }
  }

  void fetchUserRegion(List<RegionModel> regions) {
    if (_user.regionId != null) {
      var region =
          regions.firstWhere((region) => region.regionId == _user.regionId);
      _userRegion = region.nameAr;
    }
  }

  Future<void> autoAuthenticated() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isAuthenticated;
    preferences.getBool('userExistence') != null
        ? isAuthenticated = preferences.getBool('userExistence')
        : isAuthenticated = false;
    if (isAuthenticated) {
      var user = preferences.getString('user');
      print("USER::: " + user.toString());
      if (user != null) {
        _user = UserModel.fromJson(json.decode(user));
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
      }
    } else {
      return;
    }
  }

  Future<Map<String, dynamic>> sliderImages() async {
    final Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/sliderimages';
    httpService.init();
    final List<String> slidersImages = [];
    try {
      Response response = await httpService.getRequest(url, '');
      var parsedSlidersImages = response.data['data']['images'] as List;
      if (response.statusCode == 200 && response.data['status_code'] == 201) {
        parsedSlidersImages.forEach((sliderObject) {
          slidersImages.add('https://menuegypt.com/' + sliderObject['pic']);
        });

        _sliders = slidersImages;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> forgetPassword(String emailPhone) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'msg': null,
      'email': emailPhone
    };
    final Map<String, dynamic> userData = {
      'email': emailPhone,
    };
    _isLoading = true;
    notifyListeners();
    String url = '/forget-password';
    httpService.init();
    try {
      Response response = await httpService.postRequest(url, userData, '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        result['success'] = true;
        result['msg'] = response.data['message'];
      } else {
        result['error'] = response.data['message'];
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> verifyPassword(String email, String code) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'msg': null,
      'userToken': null,
      'userId': null
    };
    final Map<String, dynamic> userData = {'code': code, 'email': email};
    _isLoading = true;
    notifyListeners();
    String url = '/verify-code-reset-password';
    httpService.init();
    try {
      Response response = await httpService.postRequest(url, userData, '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        result['success'] = true;
        result['msg'] = response.data['message'];
        result['userToken'] = response.data['data']['token'];
        result['userId'] = response.data['data']['user_id'];
        print('success');
      } else {
        print('failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('catch');
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> changePassword(
      int userId, String userToken, String password) async {
    Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'msg': null
    };
    final Map<String, dynamic> userData = {
      'password': password,
      'user_id': userId,
      'token': userToken
    };
    _isLoading = true;
    notifyListeners();
    String url = '/reset-password';
    httpService.init();
    try {
      Response response = await httpService.postRequest(url, userData, '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        var parsedUser = response.data['data']['user'];
        var parsedFavorites = response.data['data']['favorites'] as List;
        UserModel user = UserModel(
          id: parsedUser['id'],
          regionId: parsedUser['region_id'],
          cityId: parsedUser['city_id'],
          email: parsedUser['email'],
          fullName: parsedUser['full_name'],
          phoneNumber: parsedUser['phone_number'],
          //avatarUrl: '',
          //authType: 'email',
          favorites: [],
          birthDate: parsedUser['birth_date'],
          gender: parsedUser['gender'],
        );

        parsedFavorites.forEach((fav) {
          user.favorites.add(fav['restaurant_id']);
        });

        _user = user;
        storeAuthUser(_user, response.data['data']['token'], true);
        result['success'] = true;
        print('sucsess');
      } else {
        result['error'] = response.data['message'];
        print('failed');
      }
    } catch (error) {
      print('catch');
      throw result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  void storeAuthUser(UserModel user, String apiToken, [isAuth = false]) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isAuth) {
      preferences.setStringList(
          "favList", user.favorites.map((i) => i.toString()).toList());
      preferences.setBool('userExistence', true);
      Map<String, dynamic> userMap = user.toJson();
      preferences.setString('user', jsonEncode(userMap));
      preferences.setString('apiToken', apiToken);
    } else {
      preferences.remove('favList');
      preferences.remove('user');
      preferences.remove('userExistence');
      preferences.remove('apiToken');
    }
  }

  Future<Map<String, dynamic>> verifyWithOtp(String otp) async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    Map<String, dynamic> code = {'code': otp};
    _isLoading = true;
    notifyListeners();
    String url = '/verify-user';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.postRequest(url, code, token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print('Success');
        result['msg'] = response.data['message'] ;
        result['success'] = true;
      } else {
        print('Failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> resendOtp() async {
    Map<String, dynamic> result = {'success': false, 'error': null};
    _isLoading = true;
    notifyListeners();
    String url = '/resent-verify-code';
    httpService.init();
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      String token = preferences.getString('apiToken');
      print(token);
      Response response = await httpService.getRequest(url, token ?? '');
      print(response);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print('Success');
        result['msg'] = response.data['message'] ;
        result['success'] = true;
      } else {
        print('Failed');
        result['error'] = response.data['message'];
      }
    } catch (error) {
      print('Catch');
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> getAppSetting() async {
    final Map<String, dynamic> result = {
      'success': false,
      'error': null,
      'setting': null
    };
    _isLoading = true;
    notifyListeners();
    String url = '/api-setting';
    httpService.init();
    try {
      Response response = await httpService.getRequest(url, null);
      print(response);

      if (response.statusCode == 200 && response.data['status'] == true) {
        Setting setting = Setting();
        setting = Setting.fromJson(response.data['setting']);
        result['setting'] = setting;
        result['success'] = true;
      }
    } catch (error) {
      result['error'] = error;
    }
    _isLoading = false;
    notifyListeners();
    return result;
  }
}
