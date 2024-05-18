import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todo/commons/widgets/buttons/custom_to_do_button.dart';
import 'package:todo/commons/widgets/empty_data/empty_box.dart';
import 'package:todo/constants/app_size.dart';
import 'package:todo/constants/app_strings.dart';
import 'package:todo/constants/app_textstyle.dart';
import 'package:todo/provider/session_provider.dart';
import 'package:todo/screens/auth/login.dart';
import 'package:todo/screens/home_page/pending_task_list.dart';
import 'package:todo/screens/home_page/view_all_task.dart';
import 'package:todo/screens/to_do/add_task.dart';
import '../../commons/widgets/box_view.dart';
import '../../commons/widgets/buttons/custom_round_gradient_button.dart';
import '../../constants/app_colors.dart';
import '../../provider/home_provider.dart';
import 'completed_task_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.uploadLocallySavedNewTask();
    homeProvider.checkDeletedLocalSavedTask();
    homeProvider.firstProductsLoad();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);

    SessionProvider sessionProvider = Provider.of<SessionProvider>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Todo App",
          style: ubuntuSemiBold.copyWith(
              color: AppColors.kBlackColor, fontSize: 20),
        ),
        automaticallyImplyLeading: false,

        /// drawer button is here
        leadingWidth: width(context) * 0.2,
        leading: Center(
          child: RoundGradientButton(
            iconName: FontAwesomeIcons.user,
            onTap: () {},
          ),
        ),
        actions: [
          RoundGradientButton(
            iconName: FontAwesomeIcons.signOut,
            onTap: () {
              provider.sessionProvider.logout();
              Get.offAll(() => const LoginPage());
            },
          ),
          SizedBox(
            width: width(context) * 0.03,
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width(context) * 0.04,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height(context) * 0.03,
              ),
              Text(
                "${provider.getGreeting()}, ${sessionProvider.loginData.username.toString().capitalizeFirst}!",
                style: ubuntuSemiBold.copyWith(
                  color: AppColors.kGreyTextColor,
                  fontSize: kFont20,
                ),
              ),
              SizedBox(
                height: height(context) * 0.03,
              ),

              /// todo button ishere
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// to do button is here
                  ToDoButton(
                    buttonText: "Add Task",
                    iconName: FontAwesomeIcons.clipboardCheck,
                    onTap: () {
                      Get.to(() => AddTaskView(
                            isUpdate: false,
                          ));
                    },
                  ),

                  /// progress button is here
                  ToDoButton(
                    buttonText: "Pending",
                    iconName: FontAwesomeIcons.barsProgress,
                    onTap: () {
                      Get.to(()=>PendingTaskListView(
                      ));
                    },
                  ),

                  /// completed
                  ToDoButton(
                    buttonText: "Completed",
                    iconName: FontAwesomeIcons.circleCheck,
                    onTap: () {
                      Get.to(()=>CompletedTaskListView(
                      ));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),

              /// view all task heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ToDo Task's",
                    style: ubuntuSemiBold.copyWith(
                        color: AppColors.kBlackTextColor, fontSize: kFont20),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=>TaskListView(
                        completed: false,
                        pending: false,
                      ));
                    },
                    child: Text(
                      AppStrings.viewAll,
                      style: ubuntuMedium.copyWith(
                          color: AppColors.kGreyTextColor, fontSize: kFont14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              provider.isFirstLoadRunning
                  ? SizedBox(
                      height: height(context) * 0.6,
                      width: width(context),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : provider.todoList.isEmpty
                      ? SizedBox(
                          height: height(context) * 0.6,
                          child: const Center(child: EmptyWidget()))
                      : ListView.builder(
                          itemCount: provider.todoList.length > 6
                              ? 6
                              : provider.todoList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ToDoBoxViewWidget(
                              description: provider.todoList[index].todo,
                              status: provider.todoList[index].completed==1?true:false,
                              taskId: provider.todoList[index].id,
                              onDelete: () async {
                                var result =await provider.deleteTask(provider.todoList[index].id);
                                if(result!){
                                  provider.removeIndex(index);
                                }
                              },
                              onEdit: () {
                                provider.setTaskData(
                                    provider.todoList[index], context);
                                Get.to(() => AddTaskView(
                                      isUpdate: true,
                                    ));
                              },
                            );
                          },
                        ),
              // const EmptyWidget()
            ],
          ),
        ),
      ),
    );
  }
}
