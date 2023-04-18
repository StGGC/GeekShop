import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/profile/profile_model.dart';
import 'package:text/ui/screens/profile/user_model.dart';
import '../../theme/theme_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();

    return ListView(
      children: [
        const _ProfileHeader(),
        _ProfileImg(
            imgURL: model.myuser?.imgUrl != '' && model.myuser?.imgUrl != null
                ? "${model.myuser?.imgUrl}"
                : 'https://image.jimcdn.com/app/cms/image/transf/none/path/s3974dcc17bc4f3da/image/i7aa4144b4a73597c/version/1630076935/image.jpg'),
        Text('${model.myuser?.name}'),
        const _TextFields(),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<MyThemeNotifier>(
          builder: (context, themeModel, _) => IconButton(
            onPressed: () => themeModel.toggTheme(),
            icon: themeModel.getTheme == MyThemeNotifier.darkTheme
                ? const Icon(Icons.toggle_off)
                : const Icon(Icons.toggle_on),
          ),
        ),
      ],
    );
  }
}

class _ProfileImg extends StatelessWidget {
  final String imgURL;
  const _ProfileImg({required this.imgURL});

  @override
  Widget build(BuildContext context) {
    const hImgAvatar = 70.0;
    const hImgBG = 200.0;
    return SizedBox(
      height: hImgBG + hImgAvatar,
      child: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: hImgBG,
            child: Image(
              fit: BoxFit.cover,
              image: AssetImage('assets/imgs/AvBackImg.jpg'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: hImgAvatar + hImgAvatar,
              width: hImgAvatar + hImgAvatar,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imgURL),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TextFields extends StatelessWidget {
  const _TextFields();
  @override
  Widget build(BuildContext context) {
    const InputBorder styleField = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    Widget myTextField({
      required String name,
      required IconData icon,
      required controller,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            isCollapsed: true,
            filled: true,
            fillColor: const Color.fromARGB(255, 164, 152, 152),
            prefixIcon: Icon(icon, size: 18),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: name,
            hintStyle: const TextStyle(fontSize: 16),
            enabledBorder: styleField,
            focusedBorder: styleField,
          ),
        ),
      );
    }

    final controller = context.read<ProfileModel>();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          myTextField(
              name: 'Имя',
              icon: Icons.person,
              controller: controller.nameController),
          myTextField(
              name: 'Адрес',
              icon: Icons.location_city,
              controller: controller.adresController),
          myTextField(
              name: 'Иконка профиля',
              icon: Icons.label_important,
              controller: controller.imgUrlController),
          myTextField(
              name: 'Телефон',
              icon: Icons.phone,
              controller: controller.phoneController),
          _UpdateProfileInfo(),
          SizedBox(height: 15.0),
          _Logout(),
        ],
      ),
    );
  }
}

class _Logout extends StatelessWidget {
  const _Logout();
  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileModel>();
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Center(child: Text('Выход')),
      ),
      onTap: () => model.justLogOut(context),
    );
  }
}

class _UpdateProfileInfo extends StatelessWidget {
  const _UpdateProfileInfo();
  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileModel>();
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: const Center(child: Text('Сохранить')),
      ),
      onTap: () => model.upDateUser(),
    );
  }
}
