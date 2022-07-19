import 'package:flutter/material.dart';
import 'package:sipsd/activity.dart';
import 'package:sipsd/information.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ActivityPage(),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Image(
                                  image: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/3050/3050525.png"),
                                ),
                              ),
                              const Text("Aktivitas Siswa"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Image(
                                image: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/1653/1653630.png"),
                              ),
                            ),
                            const Text("Chat"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InformationPage()),
                            );
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Image(
                                  image: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/943/943579.png"),
                                ),
                              ),
                              const Text("Informasi"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Image(
                                image: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/1924/1924347.png"),
                              ),
                            ),
                            const Text("Konsultasi"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Image(
                                image: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/2795/2795550.png"),
                              ),
                            ),
                            const Text("Kantin"),
                          ],
                        ),
                      ),
                      Container(
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Image(
                                image: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/4717/4717976.png"),
                              ),
                            ),
                            const Text("Catatan Siswa"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
