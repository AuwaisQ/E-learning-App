import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../controllers/wallet_history_controller.dart';

class WalletHistoryView extends GetView<WalletHistoryController> {
  WalletHistoryController walletController = Get.put(WalletHistoryController());
  WalletHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProgressHud(buildUi(context), walletController.apiLoading.value);
  }

  Widget buildUi(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: ()=> Get.back(),
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: const Text('Wallet History',style: titleStyle,),
        centerTitle: true,
        backgroundColor: secondaryColor,
      ),
      body: const Center(
        child: Text(
          'WalletHistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
