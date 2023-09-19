import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_guru/app/apiServices/apiServices.dart';
import 'package:mini_guru/constants.dart';
import 'package:mini_guru/others/progressHud.dart';
import '../../myProjects/controllers/my_projects_controller.dart';
import '../../projectList/controllers/project_list_controller.dart';
import '../controllers/select_materials_controller.dart';

class SelectMaterialsView extends GetView<SelectMaterialsController> {
  SelectMaterialsController materialsController = Get.put(SelectMaterialsController());
  MyProjectsController projectsController = Get.put(MyProjectsController());
  ProjectListController projectListController = Get.put(ProjectListController());

  SelectMaterialsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ProgressHud(buildUi(context), projectsController.isLoading.value);
    });
  }

  Widget buildUi(BuildContext context) {
    const String demoImage = 'https://bsmedia.business-standard.com/_media/bs/img/article/2021-01/21/full/1611251685-5188.jpg';
    final size = MediaQuery.of(context).size;
    //Goin Total Button
    final itemTotalButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: size.width / 7,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Stack(
        children: [
          Center(
              child: InkWell(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                child: const Text('Create Project',style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                ),),
              )),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              CupertinoIcons.arrow_right_circle,
              size: 20,
              color: Colors.white,
            ),
          )
        ],
      ),
    );

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: itemTotalButton,
        ),
        appBar: AppBar(
          title: const Text('Select Materials'),
          centerTitle: true,
          backgroundColor: primaryColor,
          actions: [
            Row(children:[
              const Text('G ',style: TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
              Text('${materialsController.goinCount.value.toString()} / ',style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
              ),),
              Text(materialsController.totalValue.value.toString(),style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1
              ),),
              const SizedBox(width: 10,),
            ],)
          ],
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                      //----Search-TextField----
                      child:Container(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        width: size.width,
                        height: size.width * 0.13,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(150)),
                        child: CupertinoTextField(
                          controller: projectsController.searchController,
                          onChanged: (value) {
                            projectsController.filterNow(value);
                          },
                          placeholder: 'Search',
                          placeholderStyle: subTitle,
                          suffix: const Icon(Icons.search),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(15),
                          ),
                        ),
                      ),),
                  SizedBox(height: size.width * 0.05,),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: projectsController.filteredProductList.length,
                      itemBuilder: (_, int index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: size.width * 0.15,
                                width: size.width * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(image: NetworkImage(ApiServices().materialImageURL + projectsController.filteredProductList[index].image),fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              //Item Name
                              title: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      projectsController.filteredProductList[index].name.capitalizeFirst!,
                                      style: headline1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02,),
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      '₿${projectsController.filteredProductList[index].price.toString()}',
                                      style: headline1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),

                              //Counter Button
                              trailing: Checkbox(
                                onChanged: (bool? value) {
                                  projectsController.filteredProductList[index].isSelected = value!;
                                  projectsController.filteredProductList.refresh();
                                  if(projectsController.filteredProductList[index].isSelected){
                                    materialsController.addProjectMaterial(Get.arguments[0].toString(), projectsController.filteredProductList[index].materialId.toString());
                                    materialsController.totalValue.value = materialsController.totalValue.value + projectsController.filteredProductList[index].price;
                                    if(materialsController.totalValue.value < 0){
                                      materialsController.totalValue.value = 0;
                                    }
                                  }else{
                                    materialsController.deleteProjectMaterial(Get.arguments[0].toString(), projectsController.filteredProductList[index].materialId.toString());
                                    materialsController.totalValue.value = materialsController.totalValue.value - projectsController.filteredProductList[index].price;
                                  }
                                },
                                value: projectsController.filteredProductList[index].isSelected,),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                thickness: 1,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
          ),
        )
    );
  }
}
