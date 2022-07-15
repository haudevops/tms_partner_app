
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

// @Auth: hau.tran
// @Description: OrderHistory Page
// @Date: 2/1/2022

class OrderHistoryPage extends BasePage {
  OrderHistoryPage({Key? key}) : super(bloc: OrderHistoryBloc());
  static const routeName = '/OrderHistoryPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends BasePageState<OrderHistoryPage> {
  OrderWorkingFilterModel _filterModel = OrderWorkingFilterModel();
  late OrderHistoryBloc _bloc;
  late List<GlobalKey> _dataKeys;
  OrderModel? order;

  @override
  void onCreate() {
    _bloc = getBloc();
    _doGetOrdersHistory();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void _doGetOrdersHistory() {
    _bloc.getOrdersHistory(
        code: _filterModel.code,
        external: _filterModel.externalCode,
        phone: _filterModel.phone,
        serviceType: _filterModel.services,
        status: _filterModel.status,
        submitted: _filterModel.submitted);
  }

  void _showFilter() {
    BaseBottomSheet().show(
        context: context,
        widget: FilterWidget(
          filterModel: _filterModel,
          onFilter: (data) {
            _filterModel = data;
            _doGetOrdersHistory();
          },
          service: [
            FilterModel(id: ServiceType.DELIVERY, name: S.current.delivery),
            FilterModel(id: ServiceType.INSTALL, name: S.current.installation),
            FilterModel(
                id: ServiceType.DELIVERY_INSTALL,
                name: S.current.delivery_and_installation)
          ],
          collections: [
            FilterModel(id: Collections.FULL, name: S.current.paid),
            FilterModel(id: Collections.NONE, name: S.current.not_paid),
            FilterModel(id: Collections.APART, name: S.current.partial_payment)
          ],
          orderStatus: [
            FilterModel(id: '7', name: S.current.processing),
            FilterModel(id: '4,5,6', name: S.current.cancel),
            FilterModel(id: '9', name: S.current.return_order),
            FilterModel(id: '10', name: S.current.problem),
            FilterModel(id: '19', name: S.current.installation_failed),
            FilterModel(id: '8', name: S.current.complete),
            FilterModel(id: '22', name: S.current.complete_with_refund),
          ],
        ));
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.menu_history, style: const TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
        actions: [
          Padding(
            padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(8)),
            child: GestureDetector(
                onTap: () {
                  _showFilter();
                },
                child: SvgPicture.asset('assets/icon/ic_filter.svg')),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _doGetOrdersHistory();
        },
        child: Container(
          padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(5)),
          child: StreamBuilder<List<OrderModel>?>(
            stream: _bloc.streamOrderHistory,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return SizedBox(
                  width: ScreenUtil.getInstance().getAdapterSize(200),
                  height: ScreenUtil.getInstance().getAdapterSize(200),
                );
              }
              if (snapshot.data == null) {
                return const ShimmerOrders();
              }
              _dataKeys =
                  List.generate(snapshot.data!.length, (index) => GlobalKey());

              if (snapshot.data!.isEmpty) {
                return Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: ScreenUtil.getInstance().getAdapterSize(200),
                    height: ScreenUtil.getInstance().getAdapterSize(250),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/order_not_found.svg',
                          height: ScreenUtil.getInstance().getAdapterSize(200),
                          width: ScreenUtil.getInstance().getAdapterSize(200),
                        ),
                        Text(
                          S.current.no_oder,
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().getAdapterSize(16),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height: ScreenUtil.getInstance().getAdapterSize(10)),
                        Text(
                          S.current.no_new_order,
                          style: TextStyle(color: AppColor.colorGray),
                        )
                      ],
                    ),
                  ),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, int index) {
                    return Card(
                        elevation: 0,
                        child: OrderWidget(
                            order: snapshot.data![index],
                            globalKey: _dataKeys[index],
                            onTapOrder: (value) {}));
                  });
            },
          ),
        ),
        // child: Container(),
      ),
      backgroundColor: AppColor.colorDarkGray,
    );
  }
}
