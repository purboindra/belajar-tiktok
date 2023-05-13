import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Slideable extends StatefulWidget {
  const Slideable({super.key});

  @override
  State<Slideable> createState() => _SlideableState();
}

class _SlideableState extends State<Slideable> {
  final _listItem = [
    {
      'name': 'Johan',
      'email': 'johanliebert@gmail.com',
      'photoUrl':
          'https://images.unsplash.com/photo-1488161628813-04466f872be2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60',
    },
    {
      'name': 'William Moriarty',
      'email': 'williammm@gmail.com',
      'photoUrl':
          'https://plus.unsplash.com/premium_photo-1674639437824-771a65f1738b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'
    },
    {
      'name': 'Ino',
      'email': 'thisisino@gmail.com',
      'photoUrl':
          'https://images.unsplash.com/photo-1564485377539-4af72d1f6a2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'
    },
    {
      'name': 'Perkins',
      'email': 'helloperkins@gmail.com',
      'photoUrl':
          'https://images.unsplash.com/photo-1562572159-4efc207f5aff?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fG1vZGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'
    },
  ];

  void removeItem(int index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('User ${_listItem[index]['name']} Succesfully Deleted!')));
    _listItem.remove(_listItem[index]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Slideable'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listItem.length,
              itemBuilder: (context, index) {
                return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    dragDismissible: false,
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: (context) => removeItem(index),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        flex: 2,
                        backgroundColor: const Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.archive,
                        label: 'Archive',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(_listItem[index]['name']!),
                    subtitle: Text(_listItem[index]['email']!),
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_listItem[index]['photoUrl']!)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
