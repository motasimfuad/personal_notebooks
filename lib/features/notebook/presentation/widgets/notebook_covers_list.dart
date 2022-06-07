import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/constants/colors.dart';

import '../../../../data/data_providers/notebook_covers_provider.dart';
import '../bloc/notebook_bloc.dart';

class NotebookCoversList extends StatelessWidget {
  const NotebookCoversList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nbCoversProvider = NotebookCoversProvider();
    return Container(
      padding: EdgeInsets.only(
        left: 15.h,
        right: 15.w,
        top: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 15.h),
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.70,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: nbCoversProvider.notebookCovers.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              BlocProvider.of<NotebookBloc>(context).add(
                ViewNotebookCover(
                  cover: nbCoversProvider.notebookCovers[index],
                ),
              );
            },
            child: BlocBuilder<NotebookBloc, NotebookState>(
              builder: (context, state) {
                if (state is ViewNotebookOnCreatePageState) {
                  if (state.cover == nbCoversProvider.notebookCovers[index]) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        border: Border.all(
                          color: KColors.primary,
                          width: 2.w,
                        ),
                        color: Colors.grey.shade300.withOpacity(0.5),
                        image: DecorationImage(
                          image: AssetImage(
                              nbCoversProvider.notebookCovers[index].url),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: KColors.primary,
                          size: 25.w,
                        ),
                      ),
                    );
                  }
                }
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.r),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          nbCoversProvider.notebookCovers[index].url),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
