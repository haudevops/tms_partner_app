
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import 'notification_bloc.dart';

class NotificationPage extends BasePage {
  NotificationPage({Key? key}) : super(key: key, bloc: NotificationBloc());

  // static const routeName = '/NavigationPage';

  @override
  State<StatefulWidget> createState()  => _NotificationPageState();
}

class _NotificationPageState extends BasePageState<NotificationPage, BaseBloc> {
  late NotificationBloc _bloc;
  int page = 1;
  bool isFinish = false;

  @override
  void onCreate() {
    // _bloc = getBloc();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).notification_title),
          titleSpacing: ScreenUtil.getInstance().getAdapterSize(16),
          actions: <Widget>[
            Container(
              child: Icon(Icons.check),
              margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().getAdapterSize(16)),
            )
          ]),
      // body: Container(
      //     child: StreamBuilder<ActivitiesModel>(
      //   stream: _bloc.listNotificationStream,
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return Center(
      //         child: Text(
      //           '${snapshot.error.toString()}',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       );
      //     }
      //     return Container(
      //       padding: EdgeInsets.only(
      //           top: ScreenUtil.getInstance().getAdapterSize(16)),
      //       child: LoadMore(
      //         onLoadMore: _loadMore,
      //         isFinish: snapshot.data?.data?.length == snapshot.data?.total,
      //         child: ListView.builder(
      //             itemCount: snapshot.data?.data?.length ?? 0,
      //             itemBuilder: (BuildContext context, int index) {
      //               return Padding(
      //                 padding: EdgeInsets.only(
      //                     left: ScreenUtil.getInstance().getAdapterSize(16),
      //                     right: ScreenUtil.getInstance().getAdapterSize(16),
      //                     top: ScreenUtil.getInstance().getAdapterSize(10),
      //                     bottom: ScreenUtil.getInstance().getAdapterSize(10)),
      //                 child: GestureDetector(
      //                   onTap: () => {print('click row $index')},
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         width: 35,
      //                         height: 35,
      //                         child: IconButton(
      //                           iconSize: 20,
      //                           color: Colors.orange[300],
      //                           onPressed: () => {},
      //                           icon: const Icon(
      //                             Icons.email_rounded,
      //                             color: Colors.orange,
      //                           ),
      //                         ),
      //                         decoration: BoxDecoration(
      //                             color: Colors.orange[100],
      //                             borderRadius: BorderRadius.circular(10)),
      //                       ),
      //                       SizedBox(
      //                         width: 10,
      //                       ),
      //                       Container(
      //                           child: Expanded(
      //                         child: Wrap(
      //                           children: [
      //                             Text(
      //                               snapshot.data!.data?[index].name ?? "",
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                   color: Colors.black87),
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Text(
      //                                   S.of(context).order_code + ": ",
      //                                 ),
      //                                 Padding(
      //                                     padding: EdgeInsets.only(
      //                                         bottom: ScreenUtil.getInstance()
      //                                             .getAdapterSize(10),
      //                                         top: ScreenUtil.getInstance()
      //                                             .getAdapterSize(10))),
      //                                 Text(
      //                                   snapshot.data!.data?[index].orderCode ??
      //                                       "",
      //                                   style: TextStyle(
      //                                       fontWeight: FontWeight.bold),
      //                                 ),
      //                               ],
      //                             ),
      //                             Row(
      //                               children: [
      //                                 Expanded(
      //                                   child: Text(
      //                                       '${DateUtil.formatDateMs(snapshot.data!.data?[index].createdAt ?? 0, format: "mm:HH dd-MM-yyyy")}'),
      //                                 ),
      //                               ],
      //                             )
      //                           ],
      //                         ),
      //                       )),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }),
      //       ),
      //     );
      //   },
      // )),
    );
  }

  Future<bool> _loadMore() async {
    page = page + 1;
    // _bloc.getNotification(page);
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 10000));
    return true;
  }
}
