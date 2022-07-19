import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  final CollectionReference _infos =
      FirebaseFirestore.instance.collection('info');

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _judulController.text = documentSnapshot['judul'];
      _isiController.text = documentSnapshot['isi'];
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
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                controller: _isiController,
                decoration: const InputDecoration(
                  labelText: 'Isi',
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
                  final String judul = _judulController.text;
                  final String isi = _isiController.text;
                  if (isi != null) {
                    await _infos.add({"judul": judul, "isi": isi});

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil buat')));

                    _judulController.text = '';
                    _isiController.text = '';
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
      _judulController.text = documentSnapshot['judul'];
      _isiController.text = documentSnapshot['isi'];
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
                controller: _judulController,
                decoration: const InputDecoration(labelText: 'Judul'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _isiController,
                decoration: const InputDecoration(
                  labelText: 'isi',
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
                  final String judul = _judulController.text;
                  final String isi = _isiController.text;
                  if (isi != null) {
                    await _infos
                        .doc(documentSnapshot!.id)
                        .update({"judul": judul, "isi": isi});

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Berhasil ubah')));

                    _judulController.text = '';
                    _isiController.text = '';
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
    await _infos.doc(productId).delete();

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Berhasil hapus')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informasi"),
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
        stream: _infos.snapshots(), //build connection
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
                    title: Text(documentSnapshot['judul']),
                    subtitle: Text(documentSnapshot['isi']),
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
