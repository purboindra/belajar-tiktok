import 'package:flutter/material.dart';
import 'package:o3d/o3d.dart';

class O3DPage extends StatefulWidget {
  const O3DPage({super.key});

  @override
  State<O3DPage> createState() => _O3DPageState();
}

class _O3DPageState extends State<O3DPage> {
  O3DController controller = O3DController();
  O3DController o3dController = O3DController();
  PageController mainPageController = PageController();
  PageController textsPageController = PageController();
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('3D'),
        actions: [
          IconButton(
              onPressed: () => controller.cameraOrbit(20, 20, 5),
              icon: const Icon(Icons.change_circle)),
          IconButton(
              onPressed: () => controller.cameraTarget(1.2, 1, 4),
              icon: const Icon(Icons.change_circle_outlined)),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            O3D.network(
              src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
              controller: controller,
              ar: false,
              autoPlay: true,
              autoRotate: false,
              cameraControls: true,
              cameraTarget: CameraTarget(.15, 1.5, 3),
              cameraOrbit: CameraOrbit(0, 90, 1),
            ),
            PageView(
              controller: mainPageController,
              children: [
                ListView.builder(
                  padding: EdgeInsets.fromLTRB(12, height * 0.8, 12, 100),
                  itemCount: 100,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/image1.jpg',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'A simple way to stay healthy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Dr Babak',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.fromLTRB(12, height * 0.8, 12, 100),
                  itemCount: 100,
                  itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/image2.jpg',
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '10:24',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    'Morning walk',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '2 km in 30min',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.directions_walk_rounded,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: InvertedCircleClipper(),
                  child: Container(
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              width: 100,
              height: double.infinity,
              margin: const EdgeInsets.all(12),
              child: PageView(
                controller: textsPageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Daily goals"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            const Expanded(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("87"),
                              ),
                            ),
                            Transform.translate(
                                offset: const Offset(0, 20),
                                child: const Text("%"))
                          ],
                        ),
                      ),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.local_fire_department_outlined,
                                color: Colors.red),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("1,840"),
                              Text(
                                "calories",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child:
                                Icon(Icons.do_not_step, color: Colors.purple),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("3,480"),
                              Text(
                                "steps",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.hourglass_bottom,
                                color: Colors.lightBlueAccent),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("6.5"),
                              Text(
                                "hours",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Journal"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Transform.translate(
                                offset: const Offset(0, 20),
                                child: const Text("<")),
                            const Expanded(
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text("12"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "July 2020",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Profile"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text("Dis"),
                        ),
                      ),
                      Text(
                        "Astronaut",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,
          onTap: (page) {
            mainPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
            textsPageController.animateToPage(page,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);

            if (page == 0) {
              o3dController.cameraTarget(-.25, 1.5, 1.5);
              o3dController.cameraOrbit(0, 90, 1);
            } else if (page == 1) {
              o3dController.cameraTarget(0, 1.8, 0);
              o3dController.cameraOrbit(-90, 90, 1.5);
            } else if (page == 2) {
              o3dController.cameraTarget(0, 3, 0);
              o3dController.cameraOrbit(0, 90, -3);
            }

            setState(() {
              this.page = page;
            });
          },
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'home'),
          ]),
    );
  }
}

class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.45))
    ..addRect(Rect.fromLTRB(0, 0, size.width, size.height))
    ..fillType = PathFillType.evenOdd;

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
