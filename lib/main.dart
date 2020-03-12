import 'package:flutter/material.dart';
import 'package:myplan/provider/task_data.dart';
import 'package:myplan/screen/completed_screen.dart';
import 'package:myplan/screen/incomplete_screen.dart';
import 'package:myplan/screen/tasks_screen.dart';
import 'package:provider/provider.dart';
import 'package:myplan/screen/addtask_screen.dart';

void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return ChangeNotifierProvider(
          builder: (context) => TaskData(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyPlan()
      ),
    );
  }
}

class MyPlan extends StatefulWidget {
  @override
  _MyPlanState createState() => _MyPlanState();
}

class _MyPlanState extends State<MyPlan> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  int bottomSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Stack(
        children: <Widget>[
          _mainContent(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddTaskScreen()

                    ),
                  ));
        },
      ),
   //   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomSelectedIndex,
        items: buildBottomNavBarItems(),
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }

  Column _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: Icon(
                  Icons.list,
                  size: 30.0,
                  color: Colors.lightBlueAccent,
                ),
                backgroundColor: Colors.white,
                radius: 30.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('My Plan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 50.0)),
              ),
              //_button(context),
//              Padding(
//                padding: const EdgeInsets.only(top: 8.0),
//                child: Text( currentPage < 0.5 ? '${Provider.of<TaskData>(context).taskCount} Tasks' : '',
//                style: TextStyle(color: Colors.white, fontSize: 18),
//                ),
//              )
            ],
          ),
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    )
                ),
                child: buildPageView()
            )
                      // TasksScreen())
            )
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('All Tasks')
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.check),
        title: Text('Complete'),
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.cancel),
          title: Text('Incomplete')
      )
    ];
  }



  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        TasksScreen(),
        CompletedTasks(),
        InCompleteTasks(),
      ],
    );
  }

}
