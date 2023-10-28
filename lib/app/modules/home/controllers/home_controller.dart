import 'dart:convert';
import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:mini_guru/app/modules/model/video_display_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../../constants.dart';
import '../../projectList/views/project_list_view.dart';
import '../model/channel_model.dart';
import '../model/video_model.dart';

class HomeController extends GetxController {
  var userId = ''.obs;
  var goinData = ''.obs;
  var userName = ''.obs;
  var walletBal = 0.obs;
  var isLoading = false.obs;
  var playListId = ''.obs;
  var nextPageToken = ''.obs;
  var videosList = <VideoModel>[].obs;
  static const String _baseUrl = 'www.googleapis.com';
  static const String apiKey = "AIzaSyBS-BXPnpZN99Ewmu63f6KglojWExIJkD0";//Youtube API Key
  // static const channelId = 'UC6Dy0rQ6zDnQuHQ1EeErGUA';
  static const channelId = 'UCfk6tZ_HJ4412cxrNMXlSIA';//MiniGuru

  var fdrList = <VideoDisplayModel>[
    VideoDisplayModel(id: 1, title: "Motor Robot", subTitle: "This is a Robot making video", description: "This is a Robot making video", thumble: "thumble", author: "Author", rating: "2.5"),
    VideoDisplayModel(id: 2, title: "Clay Molding", subTitle: "This is a Clay molding video", description: "This is a Clay Molding video", thumble: "thumble", author: "Author", rating: "4.5"),
  ].obs;

  @override
  void onInit() async{
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getString('UserId')!;
    getYoutubeVideos();
    getWalletBal();
    getUserData();
    getGoinData();
    getNotification();
    super.onInit();
  }

  //Get GoinData
  void getGoinData() async{
    isLoading.value = true;
    var response = await ApiServices().getGoins(userId.value);
      if(response['status']){
        debugPrint('GoinData- ${response['data']}');
        goinData.value = response['data'].toString();
        isLoading.value = false;
      }else{
        goinData.value = '0';
      }
    isLoading.value = false;
  }

  //Project Update Notification
  void getNotification()async{
    isLoading.value = true;
    var response = await ApiServices().getNotification(userId.value);
    if(response['status']){
      print('Notification Response - $response');
      //Update Dialog
      Get.dialog(
        barrierDismissible: false,
        DelayedDisplay(
          delay: const Duration(milliseconds: 300),
          slidingBeginOffset: const Offset(0.0, 0.3),
          child: AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 75,left: 10),
                    child: Container(
                      height: 230,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 20,right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 55, left: 20),
                              child: Text("Your Project's are expiring soon please update them before they expire.",
                                style: TextStyle(fontSize: 14, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10,left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Get.back();
                                    },
                                    child: const Text('CANCEL',style: TextStyle(
                                        color: redColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1
                                    ),)
                                  ),
                                  InkWell(
                                      onTap: (){
                                        Get.back();
                                        Get.to(ProjectListView());
                                      },
                                      child: const Text('UPDATE NOW',style: TextStyle(
                                          color: greenColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1
                                      ),)
                                  ),
                                ],
                              ),
                            )
                          ],),
                      ),
                    ),
                  ),
                  //Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network('https://assets1.lottiefiles.com/packages/lf20_LiAA0PLQxS.json',height: 150,width:150,fit: BoxFit.cover),
                    ],
                  ),
                ],
              ),
            ),
        ),);
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  //Get UserData
  void getUserData() async{
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    var response = await ApiServices().getUserProfileDetails(userId.value);
    if(response['status']){
      if (kDebugMode) {print('userName- ${response['data'][0]['name']}');}
      userName.value = response['data'][0]['name'].toString();
      prefs.setString('userName', userName.value);
      isLoading.value = false;
    }else{
      userName.value = '';
    }
    isLoading.value = false;
  }

  //Wallet Balance API
  void getWalletBal() async{
    isLoading.value = true;
    try{
      var response = await ApiServices().getWalletBalance(int.parse(userId.value));
      if(response['status']){
        walletBal.value = response['data'];
        isLoading.value = false;
      }
    }catch(e){
      Get.snackbar(
          'Wallet Error 👻',
          'Please Refresh to get wallet balance',
          backgroundColor: redColor,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.white
      );
    }
    isLoading.value = false;
  }

  getYoutubeVideos() async {
    final response = await getChannelInfo();
    playListId.value = response.uploadPlaylistId;
    fetchVideosFromPlaylist(playlistId: response.uploadPlaylistId);
    print('playListId - ${playListId.value}');
  }

  //Get Channel Info
  Future<ChannelInfo> getChannelInfo() async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': channelId,
      'key': apiKey,
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      ChannelInfo channel = ChannelInfo.fromJson(data);
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  //Get Video List From Channel info
  Future<dynamic>fetchVideosFromPlaylist({required String playlistId}) async {
    var nextPageToken  = '';
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': nextPageToken,
      'key': apiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      videosJson.forEach(
            (json) => videosList.add(
          VideoModel.fromJson(json['snippet']),
        ),
      );
      print(videosList.length);
      return videosJson;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

}