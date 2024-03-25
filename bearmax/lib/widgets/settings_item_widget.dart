import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String label;
  final Color labelColor;
  final IconData icon;
  final Color iconColor;
  final Function() onTap;

  const SettingsItem(
      {super.key,
      required this.label,
      required this.labelColor,
      required this.icon,
      required this.iconColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        elevation: MaterialStateProperty.all(0),
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(120, 90),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: iconColor, size: 16),
        ],
      ),
    );
  }
}
