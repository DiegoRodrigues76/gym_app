import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/page1');

    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: Modular.routerConfig,
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage(), children: [
      ChildRoute('/page1', child: (context) => InternalPage(title: 'page 1', color: Colors.red)),
      ChildRoute('/page2', child: (context) => InternalPage(title: 'page 2', color: Colors.amber)),
      ChildRoute('/page3', child: (context) => InternalPage(title: 'page 3', color: Colors.green)),
    ]);
  }
}

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    final leading = SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          ListTile(
            title: Text('Page 1'),
            onTap: () => Modular.to.navigate('/page1'),
          ),
          ListTile(
            title: Text('Page 2'),
            onTap: () => Modular.to.navigate('/page2'),
          ),
          ListTile(
            title: Text('Page 3'),
            onTap: () => Modular.to.navigate('/page3'),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Row(
        children: [
          leading,
          Container(width: 2, color: Colors.black45),
          Expanded(child: RouterOutlet()),
        ],
      ),
    );
  }
}

class InternalPage extends StatelessWidget {
  final String title;
  final Color color;
  const InternalPage({Key? key, required this.title, required this.color}) : super(key: key);

  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Center(child: Text(title)),
    );
  }
}

class NavigatorHelper {
  String getFirstRouteHistory(String path) {
    var history = Modular.to.navigateHistory;

    return history.first.name;
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   return runApp(ModularApp(module: AppModule(), child: AppWidget()));
// }


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Gym App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _children = [
//     WelcomeScreen(),
//     GymClasses(),
//     Schedule(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Gym App'),
//       ),
//       body: _children[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Menu',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.fitness_center),
//             label: 'Exercícios',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.schedule),
//             label: 'Agenda',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class WelcomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Bem-vindo(a) ao Gym App!'),
//     );
//   }
// }

// class GymClasses extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Lista de Exercícios'),
//     );
//   }
// }

// class Schedule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Agenda de Horários'),
//     );
//   }
// }