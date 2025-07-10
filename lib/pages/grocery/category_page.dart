

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../controller/home_controller.dart';
import '../../model/menu/menu_model.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends StateMVC<CategoryPage> {

  late HomeController _con;

  _CategoryPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getMenu(context);
  }

  XFile? _image;

  Future<void> _pickImage(Function(String?) updateImage) async {

    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateImage(pickedFile.path);
    }
  }


  void _showEditMenuDialog(BuildContext context, Menu categoryBean) {
    var categoryController = TextEditingController(text: categoryBean.categoryName!);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            XFile? dialogImage = _image;

            void updateImage(XFile? newImage) {
              setState(() {
                dialogImage = newImage;
                _image = newImage; // Update the parent state if needed
              });
            }

            void updateImage1(String? newImage) {
              setState(() {
                imag = newImage!;
                _image = XFile(imag);
              });
            }

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[400],
                        ),
                        child: TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            hintText: 'Category Name',
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Category Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _pickImage(updateImage1);
                        },
                        child: dialogImage != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            dialogImage!.path!,
                            height: 80,
                            width: 80,
                          ),
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            categoryBean.image!,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _con.editMenu(context,categoryController.text,_image,categoryBean.id);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  XFile? dialogImage;
  String imag = "";

  void _showCustomDialog(BuildContext context) {
    var categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            XFile? dialogImage = _image;

            void updateImage(XFile? newImage) {
              setState(() {
                dialogImage = newImage;
                _image = newImage; // Update the parent state if needed
              });
            }

            void updateImage1(String? newImage) {
              setState(() {
                imag = newImage!;
                _image = XFile(imag);
              });
            }

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 350,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[400],
                        ),
                        child: TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            hintText: 'Category Name',
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Category Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _pickImage(updateImage1);
                        },
                        child: _image!=null
                            ? Image.network(
                          _image!.path,
                          height: 80,
                          width: 80,
                        )
                            : Image.asset(
                          "assets/images/upload_image.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _con.addMenu(context,categoryController.text,_image);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text("Category",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            _showCustomDialog(context);
                          },
                          child: Image.asset("assets/images/plus.png",height: 30,width: 30,)),

                    ],
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                        color: Colors.grey[200], // Gray fill color
                      ),
                      child: TextField(
                        onChanged: (e){
                          _con.searchMenu(context, e);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none, // Remove default border
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Optional: Adjust padding
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: _con.menuModel.data!=null ? ListView.builder(
                itemCount: _con.filterMenuModel.data!.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var categoryBean = _con.filterMenuModel.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Switch.adaptive(
                                  value: categoryBean.status == "1" ? true :false,
                                  onChanged: (newValue) async {
                                    _con.statusMenu(context, categoryBean.id!, newValue);
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveTrackColor: Colors.grey,
                                  inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                SizedBox(width: 5,),
                                Image.network(categoryBean.image!,height: 50,width: 50,),
                                SizedBox(width: 5,),
                                Text(categoryBean.categoryName!,style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Image.asset("assets/images/edit.png",height: 35,width: 35,),onTap: (){
                                  _showEditMenuDialog(context,categoryBean);
                                },),
                                SizedBox(width: 30,),
                                InkWell(
                                    onTap: (){
                                      _con.deleteMenu(context, categoryBean.id!);
                                    },
                                    child: Image.asset("assets/images/delete.png",height: 35,width: 35,)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }):Container(),
          )
        ],
      ),
    );
  }
}
