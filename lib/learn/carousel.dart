import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final _imgList = [
    'https://images.unsplash.com/photo-1498598457418-36ef20772bb9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfDB8MHx8&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1463725876303-ff840e2aa8d5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dmlld3xlbnwwfDB8MHx8&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1503363876019-10eaf537e61d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjJ8fHZpZXd8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1625489699279-0a5f3d4b6ec8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzB8fHZpZXd8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1445277547562-477f4b504b7b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDR8fHZpZXd8ZW58MHwwfDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'
  ];

  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Carousel'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _idx = index;
                  });
                },
                height: 140.0,
              ),
              items: _imgList
                  .map((e) => Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(e), fit: BoxFit.cover)),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 5,
            ),
            AnimatedSmoothIndicator(
              activeIndex: _idx,
              count: _imgList.length,
              effect: const ExpandingDotsEffect(),
            )
          ],
        ),
      ),
    );
  }
}
