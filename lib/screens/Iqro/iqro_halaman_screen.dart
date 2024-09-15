import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quranhealer/screens/Iqro/iqro_detail.dart';
import 'package:quranhealer/screens/Iqro/iqro_view_model.dart';

class IqroHalamanScreen extends StatefulWidget {
  final int id;
  const IqroHalamanScreen({
    super.key,
    required this.id,
  });

  @override
  State<IqroHalamanScreen> createState() => _IqroHalamanScreenState();
}

class _IqroHalamanScreenState extends State<IqroHalamanScreen> {
  // firestore
  final IqroViewModel firestoreService = IqroViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jilid ${widget.id}"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E6969),
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(
            id: widget.id > 2 ? 1 : widget.id,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  // get each individual doc

                  DocumentSnapshot document = notesList[index];

                  // get note from each doc

                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  int noteText = data['id'];

                  // display as a list tile
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IqroDetail(
                              image: data['image'],
                              id: data['id'],
                            ),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Halaman $noteText"),
                              const Text("اقرأ"),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color.fromARGB(255, 168, 168, 168),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text('No notes...');
            }
          }),
    );
  }
}
