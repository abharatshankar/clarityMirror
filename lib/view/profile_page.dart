import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/view/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'custom_appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: const CustomAppBar(titleTxt: "Profile",showNotificationIcon: true,),
              ),
              seperatorLine(),
              const SizedBox(
                height: 8,
              ),
              profilePic(),
              profileUserName(userName: "Lisa Mathray"),
              profileUserOccupation(userOccupation: "Beauty Vlogger"),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    profileStats(boldTxt: '12', titleTxt: 'Following'),
                    profileStats(boldTxt: '105.2 M', titleTxt: 'Followers'),
                    profileStats(boldTxt: '2.2K', titleTxt: 'Posts')
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage()));
                },
                child: editProfileButton()),
              const SizedBox(height: 12,),




              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade700,
                  borderRadius: BorderRadius.circular(40)),
                child: DefaultTabController(

                  length: 3,
                  child: Column(
                    children: <Widget>[
                      ButtonsTabBar(
                        backgroundColor: AppConstColors.appThemeCayan,
                        unselectedBackgroundColor: Colors.blueGrey.shade700,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        // borderWidth: 1,
                        
                        radius: 100,
                        tabs:  [
                          Tab(
                            
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/3,
                              child: Center(child: Text("Posts",style: AppFonts().sego14normal.copyWith(height: 1),))),
                          ),
                          Tab(
                            
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/4,
                              child: Center(child: Text("Photos",style: AppFonts().sego14normal.copyWith(height: 1),))),
                          ),
                          Tab(
                            
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width/4,
                              child: Center(child: Text("Videos",style: AppFonts().sego14normal.copyWith(height: 1),))),
                          ),
                          
                        ],
                      ),
                      
                      // const Expanded(
                      //   child: TabBarView(
                      //     children: <Widget>[
                      //       Center(
                      //         child: Icon(Icons.directions_car),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_transit),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_bike),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_car),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_transit),
                      //       ),
                      //       Center(
                      //         child: Icon(Icons.directions_bike),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index){
                return profileListItem();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget profileUserName({required String userName}){
    return Text(
                userName,
                style: AppFonts().sego29normal.copyWith(
                    color: AppConstColors.appThemeCayan,
                    fontWeight: FontWeight.bold,
                    height: 1.4),
              );
  }

  Widget profileUserOccupation({required String userOccupation}){
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userOccupation,
                  style: AppFonts().sego14normal,
                ),
              );
  }

  Widget seperatorLine(){
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade700,
                ),
              );
  }

  Widget editProfileButton(){
    return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade600),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                  child: Text(
                    "Edit Profile",
                    style: AppFonts().sego14normal,
                  ),
                ),
              );
  }

  Widget profileListItem(){
    return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                        Container(decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),shape: BoxShape.circle),width: 40,height: 40,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('Lisa Mathray',style: AppFonts().sego14bold,),Text('Lisa Mathray',style: AppFonts().sego10bold,),],),
                        )
                                        ],),
                  
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Text("20 seconds ago",style: AppFonts().sego10bold,),
                                        ),
                      ],
                      
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 150,width: double.infinity,decoration: BoxDecoration(border: Border.all(color: Colors.white)),),
                    )
                    ],),
                );
  }

  Widget profileStats({required String boldTxt, required String titleTxt}) {
    return Column(
      children: [
        Text(
          boldTxt,
          style: AppFonts().sego18medium.copyWith(color: Colors.white),
        ),
        Text(
          titleTxt,
          style: AppFonts().sego14normal.copyWith(height: 1.8),
        )
      ],
    );
  }

  Widget profilePic() {
    return Stack(
      children: [
        Container(
          width: 120, // Adjust according to your needs
          height: 120, // Adjust according to your needs
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Border color white
              width: 5, // Border width 3
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 45, // Adjust according to your needs
            height: 45, // Adjust according to your needs
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey, // Example color for camera icon background
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white, // Example color for camera icon
            ),
          ),
        ),
      ],
    );
  }
}
