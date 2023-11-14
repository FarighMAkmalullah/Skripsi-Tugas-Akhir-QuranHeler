import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DoaWidget extends StatefulWidget {
  String title;
  String arabic;
  String translation;
  String latin;
  // bool visibility;
  DoaWidget({
    super.key,
    required this.title,
    required this.arabic,
    required this.translation,
    required this.latin,
    // required this.visibility,
  });

  @override
  State<DoaWidget> createState() => _DoaWidgetState();
}

class _DoaWidgetState extends State<DoaWidget> {
  bool visibility = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(
            15,
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                  child: Image.asset(
                    visibility
                        ? 'assets/icons/pray/up.png'
                        : 'assets/icons/pray/down.png',
                    height: 23,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: visibility,
            child: Column(
              children: [
                const Divider(
                  thickness: 1,
                  color: Color(0xFF8B8A8A),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.arabic,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.latin,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(
                            0xFFA7711F,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.translation,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
