import 'package:chat/ui/home/home_navigator.dart';
import 'package:chat/ui/home/home_view_model.dart';
import 'package:chat/ui/rooms/add_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../rooms/room_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNavigator{
  HomeViewModel viewModel =HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;

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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Home'),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
               Navigator.of(context).pushNamed(AddRoom.routeName);
              },
              child: Icon(Icons.add),

            ),
            body:Consumer<HomeViewModel>(
             builder: (context,viewModel,child){
               return GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 16,
                     crossAxisSpacing: 16,
                   ),
                   itemBuilder: (context,index){
                     return RoomWidget(room: viewModel.rooms[index]);
                   },
                 itemCount: viewModel.rooms.length,
               );
             },
            ) ,
          ),
        ],
      ),
    );
  }
}
