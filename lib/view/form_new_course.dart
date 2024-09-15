import 'package:flutter/material.dart';
import 'package:meuapp/controller/course_controller.dart';
import 'package:meuapp/model/course_model.dart';

class FormNewCourse extends StatefulWidget {
  const FormNewCourse({super.key, this.courseEdit});

  final CourseEntity? courseEdit;

  @override
  State<FormNewCourse> createState() => _FormNewCourseState();
}

class _FormNewCourseState extends State<FormNewCourse> {
  final formKey = GlobalKey<FormState>();
  CourseController controller = CourseController();

  String id = '';
  TextEditingController textNameController = TextEditingController();
  TextEditingController textDescriptionController = TextEditingController();
  TextEditingController textStartAtController = TextEditingController();

  postNewCourse() async {
    try {
      CourseEntity course = CourseEntity(
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt:
              controller.ptBrDateStringToApiFormat(textStartAtController.text));
      await controller.postNewCourse(course);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dados salvos com sucesso.")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
    }
  }

  putUpdateCourse() async {
    try {
      CourseEntity course = CourseEntity(
          id: id,
          name: textNameController.text,
          description: textDescriptionController.text,
          startAt:
              controller.ptBrDateStringToApiFormat(textStartAtController.text));
      await controller.putUpdateCourse(course);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dados atualizados com sucesso.")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
    }
  }

  @override
  void initState() {
    if (widget.courseEdit != null) {
      textNameController.text = widget.courseEdit?.name ?? 'Não informado';
      textDescriptionController.text =
          widget.courseEdit?.description ?? 'Não informado';
      textStartAtController.text =
          widget.courseEdit?.startAt ?? 'Não informado';
      id = widget.courseEdit?.id ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de curso"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Preencha este campo"),
              controller: textNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Preencha este campo"),
              controller: textDescriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onTap: () {
                showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  initialDate: DateTime.now(),
                ).then((DateTime? dateSelected) {
                  if (dateSelected != null) {
                    textStartAtController.text =
                        controller.dateTimeFormatToStringPtBr(dateSelected);
                  }
                });
              },
              controller: textStartAtController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Campo obrigatório";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //salvar os dados via api
                    if (widget.courseEdit != null) {
                      putUpdateCourse();
                    } else {
                      postNewCourse();
                    }
                  }
                },
                child: Text("Salvar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
