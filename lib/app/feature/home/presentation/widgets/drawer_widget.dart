import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColor.drawerBackground(context), // Adaptive background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserProfileSection(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(context,Icons.bookmark, "Bookmarks", AppPages.bookmark),
                  _buildDrawerItem(context,Icons.settings, "Settings", AppPages.settings),
                  _buildDrawerItem(context,Icons.logout, "Logout", null, isLogout: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      IconData icon,
      String title,
      String? routeName, {
        bool isLogout = false,
      }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.iconColor(context)), // Adaptive icon color
      title: Text(
        title,
        style: TextStyle(
          color: AppColor.textColor(context), // Adaptive text color
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: () {
        NavigationService.goBack();
        if (isLogout) {
          // Handle logout logic here
          print("User logged out");
        } else if (routeName != null) {
          NavigationService.navigateTo(routeName);
        }


      },
    );
  }
}

class UserProfileSection extends StatelessWidget {
  const UserProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColor.borderColor(context), // Adaptive border color
            child: Icon(Icons.person, color: AppColor.iconColor(context)), // Adaptive icon color
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John Doe", // Replace with actual user name from Firebase or API
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.textColor(context), // Adaptive text color
                ),
              ),
              Text(
                "View Profile", // Placeholder text
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.secondaryTextColor(context), // Adaptive rich text color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}