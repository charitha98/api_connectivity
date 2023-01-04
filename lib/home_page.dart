import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:login_page/rest_api_service.dart';
import 'package:login_page/user.dart';
import 'package:login_page/user_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final apiService = RestApiServices();

  List<User> userList = <User>[];
  List<bool> favouriteStatusList = [];
  List<User> favouriteUsersList = [];
  late Icon favouriteIcon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService.getUsers().then((value){
      // if(value != null){
      //   userList = value;
      // }
      if(value.isNotEmpty){
        for(User user in value){
          favouriteStatusList.add(false);
        }
      }
      favouriteIcon = const Icon(Icons.favorite_border, color: Colors.red);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: FutureBuilder(
              future: apiService.getUsers(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(
                              user: snapshot.data![index]
                          )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 3,
                                color: Colors.grey.withOpacity(0.3)
                              )
                            ]
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: ListTile(
                            title: Text(snapshot.data![index].name ?? '', style: const TextStyle(fontSize: 20, color: Colors.black),),
                            subtitle: Text(snapshot.data![index].city ?? '', style: const TextStyle(fontSize: 20, color: Colors.black),),
                            leading: ClipOval(
                              child: Image.network(snapshot.data![index].image ?? '', fit: BoxFit.cover, width: 60, height: 60,),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  // favouriteStatusList[index] = false;
                                  favouriteStatusList[index] = !favouriteStatusList[index];

                                  if(favouriteUsersList.contains(snapshot.data![index])){
                                    favouriteUsersList.remove(snapshot.data![index]);
                                  }else{
                                    favouriteUsersList.add(snapshot.data![index]);
                                  }
                                });

                                for(var item in favouriteUsersList){
                                  print(item.name);
                                }
                              },
                              icon: getFavoriteIcon(index),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }else{
                  return Container(
                    child: const Center(
                      child: SpinKitCircle(
                        color: Colors.orange,
                      ),
                    ),
                  );
                }
              }
            ))
            // Expanded(child: ListView.builder(
            //   itemCount: userList.length ?? 0,
            //   itemBuilder: (context, index){
            //     if(userList != null && userList.isNotEmpty){
            //       return InkWell(
            //         onTap: (){
            //           Navigator.push(context, MaterialPageRoute(builder: (context) => UserScreen(
            //               user: userList[index]
            //           )));
            //         },
            //         child: Container(
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(10),
            //               boxShadow: [
            //                 BoxShadow(
            //                     blurRadius: 3,
            //                     spreadRadius: 3,
            //                     color: Colors.grey.withOpacity(0.3)
            //                 )
            //               ]
            //           ),
            //           margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //           child: ListTile(
            //             title: Text(userList[index].name ?? '', style: const TextStyle(fontSize: 20, color: Colors.black),),
            //             subtitle: Text(userList[index].city ?? '', style: const TextStyle(fontSize: 20, color: Colors.black),),
            //             leading: ClipOval(
            //               child: Image.network(userList[index].image ?? '', fit: BoxFit.cover, width: 60, height: 60,),
            //             ),
            //             trailing: IconButton(
            //               icon: Icon(Icons.favorite_border), onPressed: () {},
            //             ),
            //           ),
            //         ),
            //       );
            //     }else{
            //       return Container(
            //         child: const Center(
            //           child: Text('Loading...', style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 15
            //           ),),
            //         ),
            //       );
            //     }
            //   }
            // ))
          ],
        ),
      ),
    );
  }

  Icon getFavoriteIcon(int index){
    if(favouriteStatusList[index]){
      return Icon(Icons.favorite, color: Colors.red);
    }else{
      return Icon(Icons.favorite_border, color: Colors.red);
    }
  }

}
