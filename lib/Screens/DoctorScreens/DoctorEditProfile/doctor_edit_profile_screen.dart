import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Providers/Profile/profile_provider.dart';
import '../../../Providers/TwilioProvider/twilio_provider.dart';
import '../../../constant.dart';
import '../../../model/res/constant/app_fonts.dart';
import '../../../model/res/widgets/header.dart';
import '../../../model/res/widgets/image_loader.dart';
import '../../../model/res/widgets/input_field.dart';
import '../../../model/res/widgets/submit_button.dart';
import '../../../model/res/widgets/text_widget.dart';

class DoctorEditProfileScreen extends StatelessWidget {
  const DoctorEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Header(text: "Edit Profile"),
            SizedBox(height: 20),
            Expanded(child: _ProfileEditForm()),
          ],
        ),
      ),
    );
  }
}

class _ProfileEditForm extends StatelessWidget {
  const _ProfileEditForm();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        const _ProfileImagePicker(),
        const SizedBox(height: 20),
        Consumer<ProfileProvider>(
          builder: (context, provider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provider.nameFields
                  .asMap()
                  .entries
                  .map((entry) {
                int index = entry.key;
                String label = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _FormLabel(text: label),
                    const SizedBox(height: 10),
                    _DynamicNameInputField(index: index),
                    const SizedBox(height: 20),
                  ],
                );
              })
                  .toList(),
            );
          },
        ),
        const _FormLabel(text: "Date of Birth"),
        const SizedBox(height: 10),
        const _DateOfBirthPicker(),
        const SizedBox(height: 20),
        const _SaveButton(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _DynamicNameInputField extends StatelessWidget {
  final int index;

  const _DynamicNameInputField({required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, provider, child) {
        return InputField(
          inputController: provider.getNameController(index),
          hintText: "Enter ${provider.nameFields[index]}",
        );
      },
    );
  }
}

class _ProfileImagePicker extends StatelessWidget {
  const _ProfileImagePicker();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return Center(
          child: InkWell(
            onTap: () => _showImagePicker(context, value),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                _ProfileImage(value: value),
                _EditIcon(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showImagePicker(BuildContext context, ProfileProvider provider) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SubmitButton(
              title: "Gallery",
              press: provider.pickImage,
            ),
            const SizedBox(height: 20),
            SubmitButton(
              title: "Camera",
              press: provider.pickImageFromCamera,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  final ProfileProvider value;

  const _ProfileImage({required this.value});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 150,
        width: 150,
        decoration: const BoxDecoration(
          color: greyColor,
          shape: BoxShape.circle,
        ),
        child: value.image != null
            ? Image.file(value.image!, fit: BoxFit.cover)
            : ImageLoaderWidget(imageUrl: value.profileUrl),
      ),
    );
  }
}

class _EditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(10.sp),
      decoration: const BoxDecoration(
        color: themeColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.camera_alt_outlined, color: bgColor),
    );
  }
}

class _FormLabel extends StatelessWidget {
  final String text;

  const _FormLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      text: text,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      isTextCenter: false,
      textColor: textColor,
      fontFamily: AppFonts.semiBold,
    );
  }
}

class _DateOfBirthPicker extends StatelessWidget {
  const _DateOfBirthPicker();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () async {
            final pickedDate = await _pickDate(context);
            if (pickedDate != null) value.setDate(pickedDate);
          },
          child: _DatePickerContainer(value: value),
        );
      },
    );
  }

  Future<DateTime?> _pickDate(BuildContext context) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) {
        return DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime.now(),
        );
      },
    );
  }
}

class _DatePickerContainer extends StatelessWidget {
  final ProfileProvider value;

  const _DatePickerContainer({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: greyColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: value.dateOfBirth,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.medium,
          ),
          const Icon(Icons.calendar_month_rounded, color: greyColor),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return value.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SubmitButton(
          title: "Save Changes",
          press: () => value.image != null
              ? value.updateProfileWithImage()
              : value.updateProfile(),
        );
      },
    );
  }
}
