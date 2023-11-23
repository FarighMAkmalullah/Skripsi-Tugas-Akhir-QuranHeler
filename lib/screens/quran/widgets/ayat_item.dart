import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AyatItem extends StatefulWidget {
  final int index;
  final ValueChanged<double> onBuild;
  final String textArab;
  final int nomorAyat;
  final String textLatin;
  final String textIndonesia;
  final bool isPlaying;
  final Function(bool) onPlayToggle;

  const AyatItem({
    super.key,
    required this.index,
    required this.onBuild,
    required this.nomorAyat,
    required this.textIndonesia,
    required this.textLatin,
    required this.textArab,
    required this.isPlaying,
    required this.onPlayToggle,
  });

  @override
  State<AyatItem> createState() => _AyatItemState();
}

class _AyatItemState extends State<AyatItem> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  final GlobalKey _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _key.currentContext?.findRenderObject() as RenderBox;
      final double height = renderBox.size.height;
      widget.onBuild(height);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RichText(
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                  text: "${widget.textArab}  ",
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                WidgetSpan(
                  child: Stack(
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0E6927),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: Center(
                          child: Text(
                            "${widget.nomorAyat}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.textLatin,
                      style: const TextStyle(color: Color(0xFFA7711F)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(widget.textIndonesia)
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  widget.onPlayToggle(!widget.isPlaying);
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 8, 6, 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isPlaying ? Colors.blue : Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(
                    widget.isPlaying
                        ? 'assets/icons/quran/stop.png'
                        : 'assets/icons/quran/play.png',
                    height: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 1,
            color: Color(0xFF8B8A8A),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
