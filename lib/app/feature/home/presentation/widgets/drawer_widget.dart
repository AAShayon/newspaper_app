import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/feature/auth/presentation/controllers/auth_controller.dart';

import '../../../auth/domain/entities/user_entity.dart';

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
    final AuthController authController=Get.find<AuthController>();
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
          authController.logout();
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
    final AuthController authController = Get.find<AuthController>();

    return FutureBuilder<UserEntity?>(
      future: authController.fetchUserInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(child: Text('Failed to load user information'));
        } else {
          final UserEntity userInfo = snapshot.data!;
          return Container(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColor.borderColor(context),
                  backgroundImage: userInfo.photoURL != null
                      ? NetworkImage(userInfo.photoURL!)
                      : null, // Use profile image URL if available
                  child: userInfo.photoURL == null
                      ? Icon(Icons.person, color: AppColor.iconColor(context))
                      : null,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userInfo.displayName ?? 'No Name',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor(context),
                      ),
                    ),
                    Text(
                      userInfo.email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.secondaryTextColor(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}