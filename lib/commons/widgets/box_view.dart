import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constants/app_size.dart';
import 'package:todo/constants/app_textstyle.dart';

import '../../constants/app_colors.dart';
class ToDoBoxViewWidget extends StatefulWidget {
  String? description;
  bool? status;
  int? taskId;
  VoidCallback onDelete;
  VoidCallback onEdit;
   ToDoBoxViewWidget({super.key,  this.description="", required this.status,required this.taskId,
   required this.onDelete, required this.onEdit});

  @override
  State<ToDoBoxViewWidget> createState() => _ToDoBoxViewWidgetState();
}

class _ToDoBoxViewWidgetState extends State<ToDoBoxViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding:  EdgeInsets.symmetric(horizontal: width(context)*0.04,vertical: height(context)*0.01),
            width: width(context) * 0.78,
            height: height(context) * 0.13,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withOpacity(0.7),
                gradient: AppColors.kButtonGradient,
                borderRadius: BorderRadius.circular(kRadius12)
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 25,
                  width: 80,
                  decoration: BoxDecoration(
                    color: widget.status==true?Colors.green:Colors.red,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(child: Text(widget.status==true?"Completed":"Pending",style: ubuntuMedium.copyWith(
                    color: Colors.white,
                    fontSize: 12
                  ),)),
                ),
                SizedBox(
                  height: height(context)*0.005,
                ),
                Text(
                  widget.description.toString(),
                  style: ubuntuMedium.copyWith(
                    color: Colors.black,
                    fontSize: kFont16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
          ),
          Container(
            width: width(context) * 0.12,
            height: height(context) * 0.13,
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withOpacity(0.5),
                gradient: AppColors.kDotGradient,
                borderRadius: BorderRadius.circular(kRadius12)
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.edit,
                    color: AppColors.kGreenColor,
                    size: 18,
                  ),
                  onPressed: widget.onEdit,
                  padding:const  EdgeInsets.all(0),
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.trash,
                    color: AppColors.kRedColor,
                    size: 18,
                  ),
                  onPressed: widget.onDelete,
                  padding:const  EdgeInsets.all(0),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
