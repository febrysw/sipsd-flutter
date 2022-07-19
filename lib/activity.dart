import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _aktivitasController = TextEditingController();
  final TextEditingController _mapelController = TextEditingController();

  final CollectionReference _activities =
      FirebaseFirestore.instance.collection('aktivitas');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namaController.text = documentSnapshot['nama'];
      _aktivitasController.text = documentSnapshot['aktivitas'];
      _mapelController.text = documentSnapshot['mapel'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _aktivitasController,
                decoration: const InputDecoration(
                  labelText: 'Aktivitas',
                ),
              ),
              TextField(
                controller: _mapelController,
                decoration: const InputDecoration(
                  labelText: 'Mapel',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Buat'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                onPressed: () async {
                  final String nama = _namaController.text;
                  final String aktivitas = _aktivitasController.text;
                  final String mapel = _mapelController.text;
                  if (aktivitas != null) {
                    await _activities.add(
                        {"nama": nama, "aktivitas": aktivitas, "mapel": mapel});

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil buat')));

                    _namaController.text = '';
                    _aktivitasController.text = '';
                    _mapelController.text = '';
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _namaController.text = documentSnapshot['nama'];
      _aktivitasController.text = documentSnapshot['aktivitas'];
      _mapelController.text = documentSnapshot['mapel'];
    }

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
              ),
              TextField(
                controller: _aktivitasController,
                decoration: const InputDecoration(
                  labelText: 'Isi',
                ),
              ),
              TextField(
                controller: _mapelController,
                decoration: const InputDecoration(
                  labelText: 'Mapel',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Ubah'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                onPressed: () async {
                  final String nama = _namaController.text;
                  final String aktivitas = _aktivitasController.text;
                  final String mapel = _mapelController.text;
                  if (aktivitas != null) {
                    await _activities.doc(documentSnapshot!.id).update(
                        {"nama": nama, "aktivitas": aktivitas, "mapel": mapel});

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil ubah')));

                    _namaController.text = '';
                    _aktivitasController.text = '';
                    _mapelController.text = '';
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    await _activities.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Berhasil hapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aktivitas"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.people_sharp,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _activities.snapshots(), //build connection
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length, //number of rows
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['nama']),
                    subtitle: Text(documentSnapshot['aktivitas'] +
                        ' - ' +
                        documentSnapshot['mapel']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
// Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.amber,
                              onPressed: () => _update(documentSnapshot)),
// This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () => _delete(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
