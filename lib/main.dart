import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1
          Container(
            color: const Color.fromARGB(255, 110, 188, 252),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Click Button',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 7, 10),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Hello!'),
                        content: Text(
                          'This is an alert dialog for Tab 1.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    ),
                    child: Text('Show Alert'),
                  ),
                ],
              ),
            ),
          ),

          // Tab 2  
          Container(
            color: const Color.fromARGB(255, 240, 168, 101),
            child: Center(
              
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/fall.png',
                    width: 200,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Fall Time',
                        hintText: 'What is your favorite thing about fall..',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab 3
          Container(
            color: const Color.fromARGB(255, 110, 223, 144),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Button pressed in ${tabs[2]} tab!'),
                    ),
                  );
                },
                child: Text('Click me'),
              ),
            ),
          ),

          // Tab 4
          Container(
            color: const Color.fromARGB(255, 255, 151, 165),
            child: ListView(
              children: [
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.flutter_dash),
                    title: Text('Item 1'),
                    subtitle: Text('Details displayed inside a Card')
                  ),
                ),
                Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Icon(Icons.flutter_dash),
                    title: Text('Item 2'),
                    subtitle: Text('details displaued inside a Card')
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            'In-Class 01 · My First Tabs App',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),  
    );
  }
}