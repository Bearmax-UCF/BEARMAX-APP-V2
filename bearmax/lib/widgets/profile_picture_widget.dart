import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String image;
  final VoidCallback onClicked;

  const ProfilePicture({
    Key? key,
    required this.image,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
        ],
      ),
    );
  }

  Widget buildImage() {
    return Container(
      width: 125,
      height: 125,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Palette.grey, 
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: const AssetImage('assets/images/panda-pfp.png'),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: onClicked,
            ),
          ),
        ),
      ),
    );
  }
}
