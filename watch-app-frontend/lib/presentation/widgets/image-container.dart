import 'dart:io';
import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/change_profil_image_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ImageContainer extends StatelessWidget {
  final String? imageUrl;

  final bool? edit;

  const ImageContainer({super.key, this.imageUrl, this.edit});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        id: ControllerID.UPDATE_USER_IMAGE,
        init: AuthenticationController(),
        builder: (controller) {
          return Stack(
            children: [
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: CircleAvatar(
                  backgroundImage: controller.currentUser.image == ''
                      ? Image.asset('assets/images/userImage.jpg').image
                      : NetworkImage(controller.currentUser.image!),
                  radius: 60.r,
                ),
              ),
              if (edit == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => const ProfileImageDialog());
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
