import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/commons/widgets/buttons/custom_round_gradient_button.dart';
import 'package:todo/constants/app_size.dart';
import 'package:todo/constants/app_textstyle.dart';
import '../../commons/widgets/box_view.dart';
import '../../constants/app_colors.dart';
import '../../cutom_date_picker/date_picker_widget.dart';
import '../../provider/home_provider.dart';

class CompletedTaskListView extends StatefulWidget {
  CompletedTaskListView({super.key,});

  @override
  State<CompletedTaskListView> createState() => _CompletedTaskListViewState();
}

class _CompletedTaskListViewState extends State<CompletedTaskListView> {
  DateTime? _selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.firstProductsLoad();
    homeProvider.Sccontroller = ScrollController()
      ..addListener(homeProvider.loadMoreProducts);
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: width(context) * 0.2,
          leading: Center(
            child: RoundGradientButton(
              iconName: FontAwesomeIcons.arrowLeft,
              onTap: () {
                Get.back();
              },
            ),
          ),
          centerTitle: true,
          title: Text(
            "Completed Task",
            style: ubuntuMedium.copyWith(
                color: AppColors.kBlackTextColor, fontSize: kFont20),
          ),
        ),
        body: SingleChildScrollView(
          controller: provider.Sccontroller,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(context) * 0.04,
                vertical: height(context) * 0.04),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: DatePicker(
                    height: 100,
                    width: 60,
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.kPrimaryColor,
                    dateTextStyle: ubuntuMedium.copyWith(
                        color: Colors.black,
                        fontSize: kFont24
                    ),
                    dayTextStyle: ubuntuMedium.copyWith(
                        color: Colors.black,
                        fontSize: kFont14
                    ),
                    monthTextStyle: ubuntuMedium.copyWith(
                        color: Colors.black,
                        fontSize: kFont18
                    ),
                    selectedTextColor: Colors.black,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                ListView.builder(
                  itemCount: provider.completedTodoList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ToDoBoxViewWidget(
                      description: provider.completedTodoList[index].todo,
                      status: provider.completedTodoList[index].completed==1?true:false,
                      taskId: provider.completedTodoList[index].id,
                      onDelete: () async {
                        var result =await provider.deleteTask(provider.completedTodoList[index].id);
                        if(result!){
                          provider.removeIndex(index);
                        }
                      },
                      onEdit: (){

                      },
                    );
                  },
                ),
                if (provider.isLoadMoreRunning == true)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (provider.hasNextPage == false)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ));
  }
}
