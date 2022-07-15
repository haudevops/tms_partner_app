import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import '../../data/model/demo/notificate_model.dart';
import 'notification_bloc.dart';

class NotificationPage extends BasePage<NotificationBloc> {
  NotificationPage({Key? key}) : super(bloc: NotificationBloc());

  static const routeName = '/NotificationPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _NotificationPageState();
}

class _NotificationPageState extends BasePageState<NotificationPage> {
  late NotificationBloc _bloc;
  int page = 1;
  bool isFinish = false;

  List<NotificationData> getItemsListOne() {
    return [
      NotificationData(
          name: 'Thông báo 1',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          day: '01/07/2020  05:20'),
      NotificationData(
          name: 'Thông báo 2',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          day: '01/07/2020  05:20'),
      NotificationData(
          name: 'Thông báo 3',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          day: '01/07/2020  05:20'),
      NotificationData(
          name: 'Thông báo 4',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
          day: '01/07/2020  05:20'),
    ];
  }

  @override
  void onCreate() {
    _bloc = getBloc();
    _bloc.getNotification();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).notification_title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
          ),
          centerTitle: true,
          elevation: 1,
          titleSpacing: ScreenUtil.getInstance().getAdapterSize(16),
          actions: <Widget> [
            Container(
              margin: EdgeInsets.only(
                  right: ScreenUtil.getInstance().getAdapterSize(16)),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: AlertDialog(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            title: Text(S.current.mark_as_read,
                                textAlign: TextAlign.center),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(S.current.you_want_mark_as_read,
                                    textAlign: TextAlign.center),
                                SizedBox(
                                    height: ScreenUtil.getInstance()
                                        .getAdapterSize(15)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ButtonSubmitWidget(
                                      title: S.current.cancel.toUpperCase(),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      colorTitle: AppColor.orderStatusYellow,
                                      backgroundColors: false,
                                      width: ScreenUtil.getInstance()
                                          .getAdapterSize(110),
                                      height: ScreenUtil.getInstance()
                                          .getAdapterSize(40),
                                    ),
                                    SizedBox(width: ScreenUtil.getInstance().getAdapterSize(12),),
                                    ButtonSubmitWidget(
                                        title:
                                            S.current.agree.toUpperCase(),
                                        onPressed: () {},
                                        width: ScreenUtil.getInstance()
                                            .getAdapterSize(110),
                                        height: ScreenUtil.getInstance()
                                            .getAdapterSize(40),
                                        colorTitle: Colors.white),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: SvgPicture.asset('assets/icon/svg/check_noti.svg'),
              ),
            )
          ],
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.colorWhiteDark,
        ),
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
        body: Container(
          width: ScreenUtil.getInstance().screenWidth,
          height: ScreenUtil.getInstance().screenHeight,
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil.getInstance().getAdapterSize(16)),
          color: Colors.white,
          child: Column(
            children: [
              _itemCard(getItemsListOne()),
            ],
          ),
        ));
  }

  Widget _listNotification(
      {required String text,
      required String content,
      required String day,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Container(
        height: ScreenUtil.getInstance().getAdapterSize(35),
        width: ScreenUtil.getInstance().getAdapterSize(35),
        child: SvgPicture.asset('assets/icon/svg/email.svg'),
      ),
      title: Text(
        text,
        style: TextStyle(color: AppColor.colorBlack),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            content,
            style: TextStyle(color: AppColor.colorTextGray),
          ),
          Text(
            day,
            style: TextStyle(color: AppColor.colorTextGray),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _itemCard(List<NotificationData> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: items
            .map((e) => Column(children: [
                  _listNotification(
                      text: e.name ?? '',
                      content: e.content ?? '',
                      day: e.day ?? '',
                      onTap: () {
                        Navigator.pushNamed(context, NotificationDetailPage.routeName, arguments: ScreenArguments(arg1: e.name, arg2: e.content));
                      }),
                ]))
            .toList(),
      ),
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
