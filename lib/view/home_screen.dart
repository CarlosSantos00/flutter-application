import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';
import 'package:meuapp/view/form_new_course.dart';
import 'package:meuapp/view/menu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CourseEntity>> futureCourses;
  CourseController controller = CourseController();

  Future<List<CourseEntity>> getCourses() async {
    return await controller.getCourses();
  }

  @override
  void initState() {
    print("initState");
    futureCourses = getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
        drawer: MenuDrawer(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormNewCourse(),
                ),
              ).then((value) {
                futureCourses = getCourses();
                setState(() {});
              });
            }),
        appBar: AppBar(
          title: Text("Lista de cursos"),
        ),
        body: FutureBuilder(
          future: futureCourses,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("snapshot tem dados");
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: ScrollMotion(), children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormNewCourse(
                                  courseEdit: snapshot.data![index],
                                ),
                              ),
                            ).then((value) {
                              futureCourses = getCourses();
                              setState(() {});
                            });
                          },
                          icon: Icons.edit,
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.black,
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Confirmação"),
                                content: Text(
                                    "Deseja realmente excluir este curso?"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancelar"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      await controller.deleteCourse(
                                          snapshot.data![index].id!);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Confirmar"),
                                  ),
                                ],
                              ),
                            ).then((value) {
                              futureCourses = getCourses();
                              setState(() {});
                            });
                          },
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ]),
                      child: ListTile(
                        leading: CircleAvatar(child: Text("CS")),
                        title:
                            Text(snapshot.data![index].name ?? "Não informado"),
                        subtitle: Text(snapshot.data![index].description ??
                            "Não informado"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
