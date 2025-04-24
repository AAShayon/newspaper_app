import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/home/presentation/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        backgroundColor: AppColor.primaryColor(context),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AppColor.textColor(context)),
        ),
      ),
    );
  }
}