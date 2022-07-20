import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import '../pages.dart';

class OrdersPage extends BasePage<OrdersBloc> {
  OrdersPage() : super(bloc: OrdersBloc());

  @override
  BasePageState<BasePage> getState() => _OrdersPageState();
}

class _OrdersPageState extends BasePageState<OrdersPage> {
  late ScrollController _scrollController;
  late OrdersBloc _bloc;
  late List<GlobalKey> _dataKeys;
  bool _isExpanded = true;
  OrderWorkingFilterModel _filterModel = OrderWorkingFilterModel();

  @override
  void onCreate() {
    _handleScroll();
    _bloc = getBloc();
    _doGetOrders();
    _bloc.getStatistical();
  }

  void _handleScroll() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          setState(() {
            _isExpanded = true;
          });
        } else if (!_isAppBarExpanded && _isExpanded) {
          setState(() {
            _isExpanded = false;
          });
        }
      });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset == 0;
  }

  void _doGetOrders() {
    _bloc.getOrders(
        code: _filterModel.code,
        external: _filterModel.externalCode,
        phone: _filterModel.phone,
        serviceType: _filterModel.services,
        status: _filterModel.status ?? "1,2,3,7,9,20");
  }

  void _checkNavigation(OrderModel model) {
    switch (model.status) {
      case OrderStatus.FINDING:
      case OrderStatus.WAITING_CONFIRM:
        // New order
        break;
      case OrderStatus.INCIDENT:
      case OrderStatus.IN_PROGRESS_INCIDENT:
        // Incident order
        break;
      default:
        // Accepted order
        Navigator.pushNamed(context, DetailAcceptedOrderPage.routeName,
                arguments: ScreenArguments(arg1: model))
            .then((value) {
          if (value != null) {
            _doGetOrders();
          }
        });
        break;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lineLayout,
      body: RefreshIndicator(
        onRefresh: () async {
          _doGetOrders();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _appBarCustom(),
            _makeHeader(),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10),
            ),
            StreamBuilder<List<OrderModel>?>(
              stream: _bloc.ordersStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const SliverToBoxAdapter(
                      child: NoOrderWidget(title: 'Đã có lỗi xảy ra'));
                }
                if (snapshot.data == null) {
                  return const SliverToBoxAdapter(child: ShimmerOrders());
                }
                _dataKeys = List.generate(
                    snapshot.data!.length, (index) => GlobalKey());

                if (snapshot.data!.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: NoOrderWidget(
                    title: 'Không có đơn hàng',
                  ));
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return OrderWidget(
                          order: snapshot.data![index],
                          globalKey: _dataKeys[index],
                          onTapExpand: () {
                            _bloc.updateUIExpand(snapshot.data!, index);

                            if (!snapshot.data![index].expandGroup) {
                              Scrollable.ensureVisible(
                                  _dataKeys[index].currentContext!);
                            }
                          },
                          onTapOrder: _checkNavigation,
                          onTapChild: _checkNavigation);
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
            log(barCode);
          }));
        },
        backgroundColor: Colors.black,
        elevation: 0.0,
        child: SvgPicture.asset('assets/icon/svg/ic_scan_white.svg'),
      ),
    );
  }

  Widget _appBarCustom() {
    return SliverAppBar(
      pinned: true,
      expandedHeight: ScreenUtil.getInstance().getHeight(70),
      elevation: 0.5,
      backgroundColor:
          _isExpanded ? AppColor.lineLayout : AppColor.colorWhiteDark,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(left: _isExpanded ? 10 : 0, bottom: 10),
        title: SizedBox(
          width: ScreenUtil.getInstance().screenWidth,
          child: Stack(
            children: [
              SizedBox(
                width: ScreenUtil.getInstance().screenWidth,
                child: Text(
                  S.current.order,
                  textAlign: _isExpanded ? TextAlign.start : TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenUtil.getScaleSp(context, 18),
                      color: Colors.black),
                ),
              ),
              Positioned(
                  right: 10,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                      onTap: () {
                        _showFilter();
                      },
                      child: SvgPicture.asset('assets/icon/ic_filter.svg')))
            ],
          ),
        ),
        centerTitle: !_isExpanded,
      ),
    );
  }

  void _showFilter() {
    BaseBottomSheet().show(
        context: context,
        widget: FilterWidget(
          filterModel: _filterModel,
          onFilter: (data) {
            // _filterModel = data;
            // _doGetOrders();
          },
          service: [
            FilterModel(id: ServiceType.DELIVERY, name: S.current.delivery),
            FilterModel(id: ServiceType.INSTALL, name: S.current.installation),
            FilterModel(
                id: ServiceType.DELIVERY_INSTALL,
                name: S.current.delivery_and_installation)
          ],
          orderStatus: [
            FilterModel(id: 'accepted', name: S.current.accepted),
            FilterModel(id: 'processing', name: S.current.processing),
            FilterModel(
                id: 'order_status_pending',
                name: S.current.order_status_pending),
            FilterModel(id: 'delivery_return', name: S.current.delivery_return),
          ],
        ));
  }

  double _calculatorSize(double height) {
    if (ScreenUtil.getInstance().getAdapterSize(130) == height) {
      return 1;
    } else if (ScreenUtil.getInstance().getAdapterSize(125) < height &&
        height < ScreenUtil.getInstance().getAdapterSize(130)) {
      return 0.9;
    } else if (ScreenUtil.getInstance().getAdapterSize(120) < height &&
        height < ScreenUtil.getInstance().getAdapterSize(125)) {
      return 0.8;
    } else if (ScreenUtil.getInstance().getAdapterSize(110) < height &&
        height < ScreenUtil.getInstance().getAdapterSize(120)) {
      return 0.5;
    } else if (ScreenUtil.getInstance().getAdapterSize(100) < height &&
        height < ScreenUtil.getInstance().getAdapterSize(110)) {
      return 0.3;
    }
    return 0;
  }

  SliverPersistentHeader _makeHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: DynamicHeader(
          minHeight: ScreenUtil.getInstance().getAdapterSize(60),
          maxHeight: ScreenUtil.getInstance().getAdapterSize(130),
          child: StreamBuilder<StatisticalModel?>(
            stream: _bloc.statisticalStream,
            builder: (context, snapshot) {
              return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return constraints.biggest.height >
                        ScreenUtil.getInstance().getAdapterSize(70)
                    ? Container(
                        color: _isExpanded
                            ? AppColor.lineLayout
                            : AppColor.colorWhiteDark,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _itemStatistical(
                                icon: 'assets/icon/ic_order_accepted.svg',
                                qty: 0,
                                status: S.current.accepted,
                                size:
                                    _calculatorSize(constraints.biggest.height),
                                orderStatus: "${OrderStatus.NEW}"),
                            _itemStatistical(
                                icon: 'assets/icon/ic_order_processing.svg',
                                qty: snapshot.data?.current ?? 0,
                                status: S.current.processing,
                                size:
                                    _calculatorSize(constraints.biggest.height),
                                orderStatus:
                                    "${OrderStatus.ACCEPTED},${OrderStatus.PROCESSING}"),
                            // _itemStatistical(
                            //   icon: 'assets/icon/ic_order_finish.svg',
                            //   qty: snapshot.data?.finished ?? 0,
                            //   status: S.current.accomplished,
                            //   size: _calculatorSize(constraints.biggest.height),
                            //   orderStatus:
                            //       "${OrderStatus.FINISHED},${OrderStatus.FINISHED_RETURNED}",
                            // )
                          ],
                        ),
                      )
                    : Container(
                        //color: AppColor.colorBackground,
                        decoration: BoxDecoration(
                            color: AppColor.colorWhiteDark,
                            border: Border(
                              bottom: BorderSide(
                                //                   <--- left side
                                color: AppColor.lineLayout,
                                width: 0.5,
                              ),
                            )),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _itemIconHeader(
                                  'assets/icon/ic_order_accepted.svg',
                                  "${OrderStatus.NEW}"),
                              _itemIconHeader(
                                  'assets/icon/ic_order_processing.svg',
                                  "${OrderStatus.ACCEPTED},${OrderStatus.PROCESSING}"),
                              _itemIconHeader('assets/icon/ic_order_finish.svg',
                                  '${OrderStatus.FINISHED},${OrderStatus.FINISHED_RETURNED}')
                            ]),
                      );
              });
            },
          )),
    );
  }

  Widget _itemStatistical(
      {required String icon,
      required String status,
      required double size,
      int? qty,
      String? orderStatus}) {
    return Expanded(
      child: SizedBox(
        height: ScreenUtil.getInstance().getWidth(70),
        child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, OrderStatusFilterPage.routeName,
            //     arguments: ScreenArguments(arg1: orderStatus));
          },
          onDoubleTap: () {},
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: ScreenUtil.getInstance().getAdapterSize(13), left: ScreenUtil.getInstance().getAdapterSize(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(status,
                          style: TextStyle(
                              fontSize: ScreenUtil.getInstance()
                                  .getAdapterSize(12.0 * size))),
                      Text(
                        qty?.toString() ?? '0',
                        style: TextStyle(
                            fontSize: ScreenUtil.getInstance()
                                .getAdapterSize(22.0 * size),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SvgPicture.asset(icon,
                      width: ScreenUtil.getInstance().getAdapterSize(40),
                      height: ScreenUtil.getInstance().getAdapterSize(40)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemIconHeader(String icon, String? orderStatus) {
    return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, OrderStatusFilterPage.routeName,
                arguments: ScreenArguments(arg1: orderStatus));
          },
          onDoubleTap: () {},
          child: SvgPicture.asset(icon,
              width: ScreenUtil.getInstance().getWidth(40),
              height: ScreenUtil.getInstance().getHeight(40)),
        ));
  }

  @override
  void onDestroy() {}
}
