// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = 'https://miniguru.in/';
  final String checkMobileURL = '${baseUrl}checkMobile';
  final String addToCartGetIdURL = '${baseUrl}addToCart';
  final String createProfileURL = '${baseUrl}profileCreate';
  final String getCartItemsURL = '${baseUrl}displayCartItems1';
  final String deleteItemFromCartURL = '${baseUrl}removeItemFromCart';
  final String createProjectURL = '${baseUrl}createProject';
  final String getAddressURL = '${baseUrl}getAddress';
  final String getNotificationURL = '${baseUrl}getNotification';
  final String updateProjectURL = '${baseUrl}updateProjectInfo';
  final String addAddressURL = '${baseUrl}addAddress';
  final String getStatesURL = '${baseUrl}getStates';
  final String checkOutURL = '${baseUrl}checkOut';
  final String getProfileDetailsURL = '${baseUrl}getProfile';
  final String addCommentURL = '${baseUrl}addComment';
  final String getCityURL = '${baseUrl}getCityUsingState';
  final String materialListURL = '${baseUrl}getMaterialList';
  final String addToCartURL = '${baseUrl}addCart';
  final String walletBalanceURL = '${baseUrl}getWallet';
  final String updateWalletBalanceURL = '${baseUrl}updateWalletBalance';
  final String getGoinURL = '${baseUrl}getGoin';
  final String addProjectMaterialURL = '${baseUrl}addProjectMaterial';
  final String deleteProjectMaterialURL = '${baseUrl}deleteProjectMaterial';
  final String updateLikesURL = '${baseUrl}updateVideoLikes';
  final String increaseQuantityURL = '${baseUrl}increaseCartQty';
  final String decreaseQuantityURL = '${baseUrl}decreaseCartQty';
  final String completeProjectListURL = '${baseUrl}getNumberOfProjectsCompleted';
  final String ongoingProjectListURL = '${baseUrl}getNumberOfProjectsInProgress';
  final String getLikeTypesURL = '${baseUrl}materialGraph';
  final String getLikeURL = '${baseUrl}getLikeTypes';
  final String updateProjectProgressURL = '${baseUrl}updateProjectProgress';
  final String shopItemsURL = '${baseUrl}getProducts';
  final String selectOrderAddressURL = '${baseUrl}selectedOrderAddress';
  final String getCommentsURL = '${baseUrl}getComments';
  final String placeOrderURL = '${baseUrl}placeOrder';
  final String pendingOrderListURL = '${baseUrl}pendingOrderList';
  final String deliveredOrderListURL = '${baseUrl}deliveredOrderList';
  final String updateUserNameURL = '${baseUrl}userUpdate';
  final String videoUploadURL = '${baseUrl}uploadVideo';
  final String productImageURL = '${baseUrl}public/uploads/product-img/';
  final String materialImageURL = '${baseUrl}public/uploads/material-img/';
  final String userImageURL = '${baseUrl}public/uploads/user-img/';
  final String projectImageURl = '${baseUrl}public/uploads/project-img/';
  // final String projectImageURl = '${baseUrl}public/uploads/';
  static const String API_KEY = "AIzaSyB2CfZMmlEfbHvIX_RL033N2tAej54KyjE";

  //Check Login Post Api
  Future checkLogin(String userMobile) async {
    final response = await http.post(Uri.parse(checkMobileURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"MobileNumber": userMobile, "status": "active"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //User Profile registration data posting method
  Future createUserProfile(
      var image,
      var name,
      var fatherName,
      var address,
      var stateId,
      var cityId,
      var mobile,
      var gender,
      var email,
      var schoolName,
      var schoolAddress,
      var dob,
      ) async {
    if (kDebugMode) {print(createProfileURL);}
    final response = await http.post(Uri.parse(createProfileURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "image":"$image",
          "name":"$name",
          "father_name":"$fatherName",
          "address":"$address",
          "stateId":"$stateId",
          "cityId":"$cityId",
          "mobile":"$mobile",
          "gender":"$gender",
          "email":"$email",
          "school_name":"$schoolName",
          "school_address":"$schoolAddress",
          "dob":"$dob"
        }));

   if (kDebugMode) {
     print(({
     "image":"$image",
     "name":"$name",
     "father_name":"$fatherName",
     "address":"$address",
     "stateId":"$stateId",
     "cityId":"$cityId",
     "mobile":"$mobile",
     "gender":"$gender",
     "email":"$email",
     "school_name":"$schoolName",
     "school_address":"$schoolAddress",
     "dob":"$dob"
   }));
   }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Add Address
  Future addAddress(
      String userId,
      String address,
      String stateId,
      String cityId,
      String addressType
      ) async {
    if (kDebugMode) {
      print(addAddressURL);
    }
    final response = await http.post(Uri.parse(addAddressURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId": userId,
          "address": address,
          "stateId": stateId,
          "cityId": cityId,
          "addressType": addressType
        }));
    var convertDataToJson = jsonDecode(response.body);
    return convertDataToJson;
  }

  //Video Upload
  Future videoUpload(
      String userId,
      String projectId,
      File video,
      ) async {
    if (kDebugMode) {print(videoUploadURL);}

    var request = http.MultipartRequest('POST',Uri.parse(videoUploadURL));
    var videoStream = http.ByteStream(video.openRead());
    var videoLength = await video.length();
    request.fields['userId'] = '$userId';
    request.fields['projectId'] = '$projectId';
    request.files.add(http.MultipartFile(
        'projectVideo',
        videoStream,
        videoLength,
        filename: video.path
    ));
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error uploading video. Status code: ${response.statusCode}');
      return false;
    }
  }

  //Get State list
  Future getStateList() async {
    if (kDebugMode) {
      print(getStatesURL);
    }
    final response = await http.get(Uri.parse(getStatesURL));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Pending Order List
  Future getPendingOrderList(String userId) async {
    if (kDebugMode) {
      print(pendingOrderListURL);
    }
    final response = await http.post(Uri.parse(pendingOrderListURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId":"$userId"}));
    if (kDebugMode) {
      print({"userId":"$userId"});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Update User Name
  Future updateUserName(
      int userId,
      String name
      ) async {
    if (kDebugMode) {print(updateUserNameURL);}
    final response = await http.post(Uri.parse(updateUserNameURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId": userId,
          "userName":"$name"
        }));
    if (kDebugMode) {
      print({
        "userId": userId,
        "userName":"$name"
      });
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Update User Name
  Future updateUserImage(
      int userId,
      String image
      ) async {
    if (kDebugMode) {print(updateUserNameURL);}
    final response = await http.post(Uri.parse(updateUserNameURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId": userId,
          "userImage":"$image"
        }));
    if (kDebugMode) {
      print({
        "userId": userId,
        "userImage":"$image"
      });
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }


  //Get Delivered Order List
  Future getDeliveredOrderList(String userId) async {
    if (kDebugMode) {
      print(deliveredOrderListURL);
    }
    final response = await http.post(Uri.parse(deliveredOrderListURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId":"$userId"}));
    if (kDebugMode) {
      print({"userId":"$userId"});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get City list
  Future getCityList(int stateId) async {
    if (kDebugMode) {
      print(getCityURL);
    }
    final response = await http.post(Uri.parse(getCityURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"state": "$stateId"}));
    if (kDebugMode) {
      print({"stateId": "$stateId"});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }


  //Get Wallet balance
  Future getWalletBalance(int userId) async {
    if (kDebugMode) {print(walletBalanceURL);}
    final response = await http.post(Uri.parse(walletBalanceURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId": "$userId"}));
    if (kDebugMode) {
      print({"userId": "$userId"});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }


  //Update Wallet balance
  Future updateWalletBalance(
      int userId,
      String updatedBalance
      ) async {
    if (kDebugMode) {print(updateWalletBalanceURL);}
    final response = await http.post(Uri.parse(updateWalletBalanceURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId":"$userId",
          "updatedBalance":"$updatedBalance"
        }));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get City list
  Future getCartItems(int cartId) async {
    if (kDebugMode) {print(getCartItemsURL);}
    final response = await http.post(Uri.parse(getCartItemsURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({"userId": "$cartId"}));
    if (kDebugMode) {print({"userId": "$cartId"});}
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Goin Data
  Future getGoins(String userId) async {
    if (kDebugMode) {
      print(getGoinURL);
    }
    final response = await http.post(Uri.parse(getGoinURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId": userId}));
    if (kDebugMode) {
      print({"userId": userId});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Notification
  Future getNotification(String userId) async {
    if (kDebugMode) {
      print(getNotificationURL);
    }
    final response = await http.post(Uri.parse(getNotificationURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId": userId}));
    if (kDebugMode) {
      print({"userId": userId});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Notification
  Future getAddress(String userId) async {
    if (kDebugMode) {
      print(getAddressURL);
    }
    final response = await http.post(Uri.parse(getAddressURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId": "$userId"}));
    if (kDebugMode) {
      print({"userId": userId});
    }
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Cart Details
  // Future getCartDetails(String userId) async {
  //   final response = await http.post(Uri.parse(getCartURL),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: json.encode({"userId": "$userId"}));
  //   var convertDataToJson = await jsonDecode(response.body);
  //   return convertDataToJson;
  // }

  //Shop Items list
  Future shopItems() async {
    if (kDebugMode) {
      print(shopItemsURL);
    }
    final response = await http.get(Uri.parse(shopItemsURL));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Material List
  Future materialList() async {
    if (kDebugMode) {
      print(materialListURL);
    }
    final response = await http.get(Uri.parse(materialListURL));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Likes
  Future getLikes() async {
    if (kDebugMode) {
      print(getLikeURL);
    }
    final response = await http.get(Uri.parse(getLikeURL));
    var convertDataToJson = json.decode(response.body);
    return convertDataToJson;
  }

  //Get Like Types
  Future getLikeTypeList(var userId) async {
    if (kDebugMode) {
      print(getLikeTypesURL);
    }
    final response = await http.post(Uri.parse(getLikeTypesURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId":"$userId"
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Get Like Types
  Future selectOrderAddress(
      var addressId,
      var orderId
      ) async {
    if (kDebugMode){print(selectOrderAddressURL);}
    final response = await http.post(Uri.parse(selectOrderAddressURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "address_id":"$addressId",
          "orderId":"$orderId"
        }));
    if (kDebugMode) {print({
      "addressId":"$addressId",
      "orderId":"$orderId"
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Get Like Types
  Future deleteItem(
      var userId,
      var projectId
      ) async {
    if (kDebugMode) {
      print(deleteItemFromCartURL);
    }
    final response = await http.post(Uri.parse(deleteItemFromCartURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId":"$userId",
          "productId":"$projectId"
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Get User Profile Details
  Future getUserProfileDetails(var userId) async {
    if (kDebugMode) {print(getProfileDetailsURL);}
    final response = await http.post(Uri.parse(getProfileDetailsURL),

        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},

        body: json.encode({"userId":"$userId"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Update Likes
  Future updateLikes(
      var userId,
      var projectId,
      var likeTypeId,
      ) async {
    if (kDebugMode) {
      print(updateLikesURL);
    }
    final response = await http.post(Uri.parse(updateLikesURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"userId":"$userId","projectId":"$projectId","likeTypeId":"$likeTypeId"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Add Project Material
  Future addProjectMaterial(
      var projectId,
      var materialID,
      ) async {
    if (kDebugMode) {
      print(addProjectMaterialURL);
    }
    final response = await http.post(Uri.parse(addProjectMaterialURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "projectId":"$projectId",
          "materialId":"$materialID",
          "quantity":"1"}));
    if (kDebugMode) {
      print({
      "projectId":"$projectId",
      "materialId":"$materialID",
      "quantity":"1"
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Delete Project Material
  Future deleteProjectMaterial(
      var projectId,
      var materialId,
      ) async {
    if (kDebugMode) {
      print(deleteProjectMaterialURL);
    }
    final response = await http.post(Uri.parse(deleteProjectMaterialURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"projectId":"$projectId","materialId":"$materialId"}));

    if (kDebugMode) {print({"projectId":"$projectId","materialId":"$materialId"});}
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Delete Project Material
  Future placeOrder(
      var userId,
      var orderDate,
      ) async {
    if (kDebugMode) {print(placeOrderURL);}
    final response = await http.post(Uri.parse(placeOrderURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "userId":"$userId",
          "orderDate":"$orderDate",
          "billingAmt": 0
        }));
    if (kDebugMode) {print('Order Id API-${{"userId":"$userId","orderDate":"$orderDate"}}');}
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //CheckOut
  Future checkOut(
      var orderId,
      var billingAmt,
      var userId,
      ) async {
    if (kDebugMode) {print(checkOutURL);}
    final response = await http.post(Uri.parse(checkOutURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({
          "orderId":"$orderId",
          "billingAmt":"$billingAmt",
          "userId":"$userId"
        }));
    if (kDebugMode) {print({
      "orderId":"$orderId",
      "billingAmt":"$billingAmt",
      "userId":"$userId"
    });}
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //create Project
  Future createProject(
      String userId,
      String title,
      String description,
      String startDate,
      String endDate,
      String image,
      ) async {
    if (kDebugMode) {
      print(placeOrderURL);
    }
    final response = await http.post(Uri.parse(createProjectURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id":userId,
          "title":title,
          "description":description,
          "start_date":startDate,
          "end_date":endDate,
          "image":image,
        }));
    if (kDebugMode) {
      print({
      "user_id":userId,
      "title":title,
      "description":description,
      "start_date":startDate,
      "end_date":endDate,
      "image":image,
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Get Cart Id
  Future addToCartAndGetId(
      var userId,
      var productId,
      var qty,
      var date,
      var time
      ) async {
    if (kDebugMode) {
      print(addToCartGetIdURL);
    }
    final response = await http.post(Uri.parse(addToCartGetIdURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId":"$userId",
          "productId":"$productId",
          "qty":"$qty",
          "date":"$date",
          "time":"$time"
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Get Cart Id
  Future addToCartWithID(
      var userId,
      var productId,
      var qty,
      var cartId
      ) async {
    if (kDebugMode) {
      print(addToCartGetIdURL);
    }
    final response = await http.post(Uri.parse(addToCartGetIdURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId":"$userId",
          "productId":"$productId",
          "qty":"$qty",
          "cartID":"$cartId"
        }));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //update Project Progress
  Future addToCart(
      var userId,
      var productId,
      var qty,
      var cartId
      ) async {
    if (kDebugMode) {
      print(addToCartGetIdURL);
    }
    final response = await http.post(Uri.parse(addToCartGetIdURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId":"$userId",
          "productId":"$productId",
          "qty":"$qty",
          "cartId":"$cartId"
        }));
    if (kDebugMode) {
      print({
      "userId":"$userId",
      "productId":"$productId",
      "qty":"$qty",
      "cartId":"$cartId"
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Increase Cart Item Quantity
  Future increaseQuantity(
      var userId,
      var productId
      ) async {
    if (kDebugMode) {
      print(increaseQuantityURL);
    }
    final response = await http.post(Uri.parse(increaseQuantityURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId":"$userId",
          "productId":"$productId",
        }));
    if (kDebugMode) {
      print({
        "userId":"$userId",
        "productId":"$productId",
      });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //Increase Cart Item Quantity
  Future decreaseQuantity(
      var userId,
      var productId
      ) async {
    if (kDebugMode) {
      print(decreaseQuantityURL);
    }
    final response = await http.post(Uri.parse(decreaseQuantityURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          "userId":"$userId",
          "productId":"$productId",
        }));
    if (kDebugMode) {
      print({
        "userId":"$userId",
        "productId":"$productId",
      });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Get Completed Project List
  Future getCompletedProjectList(var userId) async {
    if (kDebugMode) {
      print(completeProjectListURL);
    }
    final response = await http.post(Uri.parse(completeProjectListURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({"userid":"$userId"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Get Ongoing Project List
  Future getOngoingProjectList(var userId) async {
    if (kDebugMode) {
      print(ongoingProjectListURL);
    }
    final response = await http.post(Uri.parse(ongoingProjectListURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({"userId":"$userId"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //Get Ongoing Project List
  Future getComments(var projectId) async {
    if (kDebugMode) {
      print(getCommentsURL);
    }
    final response = await http.post(Uri.parse(getCommentsURL),
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
        body: json.encode({"project_id":"$projectId"}));
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

  //create Project
  Future updateProject(
      String projectID,
      String title,
      String startDate,
      String endDate,
      String description,
      String image,
      // String image,
      ) async {
    if (kDebugMode) {
      print(updateProjectURL);
    }
    final response = await http.post(Uri.parse(updateProjectURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "projectId":projectID,
          "title":title,
          "start_date":startDate,
          "end_date":endDate,
          "description":description,
          "image":image,
        }));
    if (kDebugMode) {
      print({
      "projectId":projectID,
      "title":title,
      "start_date":startDate,
      "end_date":endDate,
      "description":description,
      "image":image,
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }


  //create Project
  Future addComment(
      String userID,
      String projectID,
      String comment,
      // String image,
      ) async {
    if (kDebugMode) {
      print(addCommentURL);
    }
    final response = await http.post(Uri.parse(addCommentURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId":userID,
          "projectId":projectID,
          "commentBody":comment
        }));
    if (kDebugMode) {
      print({
      "userId":userID,
      "projectId":projectID,
      "commentBody":comment
    });
    }
    var convertDataToJson = await jsonDecode(response.body);
    return convertDataToJson;
  }

}
