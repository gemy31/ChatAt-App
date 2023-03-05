import 'dart:async';

import 'package:chat/model/category.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/rooms/add_room_navigator.dart';
import 'package:chat/ui/rooms/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/utils.dart' as utils;

class AddRoom extends StatefulWidget {
static const String routeName ='addRoom';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom>implements AddRoomNavigator {
  String roomtitle = '';
  String roomDescription = '';

  var formKey = GlobalKey<FormState>();
  var categoryList = Category.getCategories();
  late Category selectedItem ;
  AddRoomViewModel viewModel =AddRoomViewModel();
  @override
  void initState() {
    super.initState();
    selectedItem = categoryList[0];
    viewModel.navigator =this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Add Room'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 24,vertical: 32),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //SizedBox(height: 16,),
                    Text('Create New Room',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,),
                    SizedBox(height: 20,),
                    Image.asset('assets/images/persons.png',
                    height: 80,
                    width: 80,
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline ,
                      decoration: InputDecoration(
                        hintText: 'Enter Room title',
                      ),
                      onChanged: (text){
                        roomtitle = text ;
                      },
                    ),
                    SizedBox(height: 10,),
                    DropdownButton<Category>(
                      value:selectedItem ,
                        items: categoryList.map((category) =>
                            DropdownMenuItem<Category>(
                                value: category,
                                child: Row(
                              children: [
                                Image.asset(category.image,height: 30,width: 30,),
                                SizedBox(width:20,),
                                Text(category.title),
                              ],
                            ))).toList(),
                        onChanged: (newSelectedItem){
                         setState(() {
                           selectedItem = newSelectedItem! ;
                         });
                        },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      keyboardType: TextInputType.multiline ,
                      decoration: InputDecoration(
                        hintText: 'Enter Room Description',
                      ),
                      onChanged: (text){
                        roomDescription = text ;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*.05,),
                    ElevatedButton(
                      style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      ),
                      onPressed: (){
                      validateForm();
                    }, child: Text('Create',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),),



                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  void validateForm() {
    if(formKey.currentState?.validate() == true){
      viewModel.createRoom(roomtitle, roomDescription,selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    utils.hideLoading(context);
  }

  @override
  void showLoading() {
    utils.showLoading(context, 'Create Room Loading...');
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'Ok', (context){
      Navigator.pop(context);
    });
  }

  @override
  void navigateTo() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }
}
