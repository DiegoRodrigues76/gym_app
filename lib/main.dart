import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gym App',
      theme: ThemeData(primarySwatch: Colors.blue
      ),
      routerConfig: Modular.routerConfig,
    ); //added by extension
  }
}

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child('/', child: (context) => MyHomePage());
    // r.child('/second', child: (context) => SecondPage());
  }
}

// class MyHomePage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Home Page')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Modular.to.navigate('/second'),
//           child: Text('Navigate to Second Page'),
//         ),
//       ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    WelcomeScreen(),
    GymClasses(),
    Schedule(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym App'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Exercícios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Agenda',
          ),
        ],
      ),
    );
  }
}

// class SecondPage extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Second Page')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () => Modular.to.navigate('/'),
//           child: Text('Back to Home'),
//         ),
//       ),
//     );
//   }
// }

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bem-vindo(a) ao Gym App!'),
    );
  }
}


class GymClasses extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Exercícios'),
      ),
      body: ListView.builder(
        itemCount: exerciseList.length,
        itemBuilder: (context, index) {
          final exercise = exerciseList[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text('${exercise.sets} sets x ${exercise.reps} reps'),
            onTap: () {
              // Navegar para a tela de detalhes do exercício
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetailPage(exercise),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  ExerciseDetailPage(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Exercício'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text('Sets: ${exercise.sets}'),
            Text('Reps: ${exercise.reps}'),
            Text('Descrição: ${exercise.description}'),
          ],
        ),
      ),
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final String description;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.description,
  });
}

final List<Exercise> exerciseList = [
  Exercise(
    name: 'Flexões',
    sets: 3,
    reps: 10,
    description: 'Flexões para trabalhar o peito e os braços.',
  ),
  Exercise(
    name: 'Agachamentos',
    sets: 3,
    reps: 12,
    description: 'Agachamentos para trabalhar as pernas e os glúteos.',
  ),
  Exercise(
    name: 'Prancha',
    sets: 3,
    reps: 30,
    description: 'Prancha para fortalecer o core e melhorar a estabilidade.',
  ),
];

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Lista de Exercícios'),
//     );
//   }
// }

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Agenda de Horários'),
    );
  }
}