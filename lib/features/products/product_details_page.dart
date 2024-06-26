import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../view/custom_appbar.dart';
import '../../view/dots_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>  with SingleTickerProviderStateMixin{
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
late TabController _tabController;          //
  final pageController = PageController();    //
  int pagedIndex = 0;                         //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);         //
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: const Icon(Icons.arrow_back_ios_new),
        //   title: const Text(
        //     "Product Details",
        //     style: TextStyle(
        //         fontSize: 25, fontWeight: FontWeight.w500, color: Colors.black),
        //   ),
        //   actions: const [
        //     Padding(
        //       padding: EdgeInsets.symmetric(horizontal: 12.0),
        //       child: Icon(Icons.shopping_cart_outlined),
        //     )
        //   ],
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(titleTxt: "Product Details",showNotificationIcon: false,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: PageView(
                  onPageChanged: (value) {
                    pagedIndex = value;
                    setState(() {});
                  },
                  controller: pageController,
                  children: const [
                    Page1(pagedIndex: 0,),
                    Page1(pagedIndex: 1,),
                   Page1(pagedIndex: 2,),
                    Page1(pagedIndex: 3,),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                labelColor: AppConstColors.appThemeCayan,
              indicatorColor: AppConstColors.appThemeCayan,
              unselectedLabelColor: Colors.white.withOpacity(0.4),
              indicatorSize: TabBarIndicatorSize.label,
                tabs:  [
                  Tab(
                    // text: "Description",
                    child: Text("Description",style: AppFonts().sego12bold,),
                  ),
                  Tab(
                    // text: "Ingratients",
                    child: Text("Ingratients",style: AppFonts().sego12bold,),
                  ),
                  Tab(
                    // text: "How to use",
                    child: Text("How to use",style: AppFonts().sego12bold,),
                  ),
                  Tab(
                    // text: "Reviews",
                    child: Text("Reviews",style: AppFonts().sego12bold,),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: TabBarView(
                  controller: _tabController,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("An ingredient is one part of a mixture. For example, if you're making chocolate chip cookies, flour is just one ingredient you'll need.",style: AppFonts().sego12normal,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("An ingredient is one part of a mixture. For example, if you're making chocolate chip cookies, flour is just one ingredient you'll need.",style: AppFonts().sego12normal,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("An ingredient is one part of a mixture. For example, if you're making chocolate chip cookies, flour is just one ingredient you'll need.",style: AppFonts().sego12normal,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("An ingredient is one part of a mixture. For example, if you're making chocolate chip cookies, flour is just one ingredient you'll need.",style: AppFonts().sego12normal,),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.cyanAccent,),width: double.infinity,height: 50,
                  child:  Center(child: Text("Add to cart",style: AppFonts().sego14bold.copyWith(color: Colors.white),)),),
              )
            ],
          ),
        ),
      ),
    );
  }
}




class Page1 extends StatelessWidget {
  const Page1({super.key, required this.pagedIndex});

final int pagedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),),
                height: MediaQuery.of(context).size.width*0.6,
                width: MediaQuery.of(context).size.width*0.6,
                child: Image.asset("assets/images/Dermatolgist6.png",fit: BoxFit.fill,),
              ),
          ),
        ),
DotsIndicator(pagedIndex: pagedIndex,),
        Text("Deep Raidance Cream ",style: AppFonts().sego18normal),
        Text("\$52",style: AppFonts().sego18normal),
      ],
    ),
    );
  }
}