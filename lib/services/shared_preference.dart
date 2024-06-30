import 'package:featheries/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {

  //=============== REMOVE all user info from local =============
  Future <bool> clearUserInfo () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    return true;
  }

  //=============== SAVE login user info to local =============
  Future <bool> saveUserInfoMap (Map userInfoMap) async{
    await SharedPreference().saveUserId(userInfoMap[userInfoMapId]);
    await SharedPreference().saveUserLoginId(userInfoMap[userInfoMapLoginId]);
    await SharedPreference().saveUserName(userInfoMap[userInfoMapName]);
    await SharedPreference().saveUserImage(userInfoMap[userInfoMapImage]);
    await SharedPreference().saveUserAdmin(userInfoMap[userInfoMapAdmin]);

    return true;
  }


  Future <bool> saveUserId (String userId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, userId);
  }

  Future <bool> saveUserLoginId (String userLoginId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userLoginIdKey, userLoginId);
  }
  Future <bool> saveUserName (String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName);
  }

  Future <bool> saveUserImage (String userLoginImage) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, userLoginImage);
  }

  Future <bool> saveUserAdmin (bool userAdmin) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(userAdminKey, userAdmin);
  }
  //=============== GET =============
  Future <String?> getUserId () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future <String?> getUserLoginId () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userLoginIdKey);
  }

  Future <String?> getUserName () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }
  Future <String?> getUserImage () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  Future <bool?> getUserAdmin () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userAdminKey);
  }

}