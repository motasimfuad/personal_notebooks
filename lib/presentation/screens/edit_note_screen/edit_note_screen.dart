import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/features/note/data/models/note.dart';
import 'package:notebooks/features/notebook/data/models/notebook.dart';
import 'package:notebooks/presentation/widgets/k_add_label_sheet.dart';
import 'package:notebooks/presentation/widgets/k_appbar.dart';
import 'package:notebooks/presentation/widgets/k_fab.dart';
import 'package:notebooks/presentation/widgets/k_labels.dart';
import 'package:notebooks/presentation/widgets/k_select_color_sheet.dart';
import 'package:notebooks/presentation/widgets/k_text_field.dart';

class EditNoteScreen extends StatefulWidget {
  Note note;
  EditNoteScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    descriptionController.text = widget.note.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Notebook notebook = sampleNotebook;
    // Note note = sampleNote;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: [
                  Column(
                    children: [
                      KAppbar(
                        label: 'Edit Note',
                        context: context,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: KLabels(
                          notebook: notebook,
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) =>
                                KAddLabelSheet(notebook: notebook),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 22.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                KTextField(
                                  controller: titleController,
                                  labelText: 'Title',
                                  isBold: true,
                                ),
                                Container(
                                  height: 490.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.r),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: descriptionController,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 26,
                                    maxLines: 30,
                                    decoration: InputDecoration(
                                      hintText: 'Description',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.r),
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey.shade100,
                                      contentPadding: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 20.h,
                                        bottom: 0.h,
                                      ),
                                    ),
                                    scrollPadding: EdgeInsets.all(160.w),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: KFab(
        label: 'SAVE',
        onPressed: () {},
        icon: Icons.save_rounded,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: const KSelectColorSheet(),
                    ),
                    isDismissible: false,
                    isScrollControlled: false,
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.color_lens,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
