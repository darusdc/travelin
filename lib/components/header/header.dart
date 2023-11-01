import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, this.isStackScreen = false});
  final bool isStackScreen;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: isStackScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Flexible(child: CircleAvatar(child: Text("Bro"))),
                  ])
            : const CircleAvatar(child: Text("Bro")));
  }
}
