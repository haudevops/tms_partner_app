import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import '../pages.dart';

class OrderStatusFilterPage extends BasePage<OrderStatusFilterBloc> {
  static const routeName = '/OrderStatusFilterPage';
  final ScreenArguments? data;

  OrderStatusFilterPage(this.data) : super(bloc: OrderStatusFilterBloc());

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _OrderStatusFilterState();
}

class _OrderStatusFilterState extends BasePageState<OrderStatusFilterPage> {
  late OrdersBloc _bloc;
  late List<GlobalKey> _dataKeys;
  late String status;
  OrderWorkingFilterModel _filterModel = OrderWorkingFilterModel();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lineLayout,
      appBar: AppBar(
        title: Text(
          S.current.order,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _doGetOrders(status);
        },
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            StreamBuilder<List<OrderModel>?>(
              stream: _bloc.ordersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SliverToBoxAdapter(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                    ),
                  );
                }
                if (snapshot.data == null) {
                  return const SliverToBoxAdapter(child: ShimmerOrders());
                }
                _dataKeys = List.generate(
                    snapshot.data!.length, (index) => GlobalKey());
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return OrderWidget(
                        order: snapshot.data![index],
                        globalKey: _dataKeys[index],
                        onTapOrder: (orderModel) {
                          _bloc.updateUIExpand(snapshot.data!, index);

                          if (!snapshot.data![index].expandGroup) {
                            Scrollable.ensureVisible(
                                _dataKeys[index].currentContext!);
                          }
                        },
                      );
                    },
                    childCount: snapshot.data?.length,
                  ),
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScanPage.routeName,
              arguments: ScreenArguments(arg1: (barCode) {
            print(barCode);
          }));
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        child: SvgPicture.asset('assets/icon/ic_scan_qr_black.svg'),
      ),
    );
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
    status = widget.data!.arg1.toString();
    _bloc = getBloc();
    _doGetOrders(status);
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void _doGetOrders(String? status) {
    _bloc.getOrders(status: status);
  }
}
