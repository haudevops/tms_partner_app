
import 'package:flutter/material.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/order/business_constant.dart';
import 'package:tms_partner_app/utils/order/order_utils.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import '../../data/model/models.dart';

class DetailPointPage extends BasePage<DetailPointBloc> {
  DetailPointPage({Key? key, required this.data}) : super(key: key, bloc: DetailPointBloc());
  static const routeName = '/DetailPointPage';
  final ScreenArguments data;


  @override
  State<StatefulWidget> createState() => _DetailPointPageState();
}

class _DetailPointPageState extends BasePageState<DetailPointPage, BaseBloc>
    with SingleTickerProviderStateMixin {
  Point? _pointCurrent;
  OrderModel? _orderModel;
  bool _isPickPoint = false;
  String? _title;
  late TabController _tabController;
  late DetailPointBloc _bloc;

  @override
  void onCreate() {
    _pointCurrent = widget.data.arg1;
    _orderModel = widget.data.arg2;
    if (_orderModel != null && _pointCurrent != null) {
      _initTitlePoint();
    }
    _tabController = TabController(length: 2, vsync: this);
    // _bloc = getBloc();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  void _initTitlePoint() {
    if (OrderUtils.isIncidentPoint(
        _orderModel?.status, _pointCurrent?.status)) {
      _title = 'Thông tin sự cố';
    } else {
      if (ServiceType.WARRANTY_REPAIR == _orderModel?.serviceType) {
        _pointCurrent = _orderModel?.detail?.points?.first;
        _title = 'Thông tin điểm bảo hành sửa chữa';
      } else {
        switch (_pointCurrent?.type) {
          case PointType.PICK_POINT:
            _isPickPoint = true;
            _title = 'Thông tin điểm lấy hàng';
            break;
          case PointType.DELIVERY_POINT:
          case PointType.DELIVERY_INSTALLATION_POINT:
            _title = 'Thông tin điểm giao hàng';
            break;
          case PointType.INSTALLATION_POINT:
            _title = 'Thông tin điểm lắp đặt';
            break;
          case PointType.RETURN_POINT:
          case PointType.RETURN_WAREHOUSE:
            _title = 'Thông tin điểm hoàn trả';
            break;
          default:
            _title = '';
        }
      }
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: ScreenUtil.getInstance().getAdapterSize(60)),
        child: FloatingActionButton(
          onPressed: () {
            if (_pointCurrent?.contact?.phone != null &&
                _pointCurrent!.contact!.phone!.isNotEmpty) {
              PhoneCallBottomSheet().show(
                  context: context,
                  phoneNumber: _pointCurrent!.contact!.phone!);
            }
          },
          child: Icon(Icons.phone, color: AppColor.colorItemDarkWhite),
          backgroundColor: AppColor.orderGreenLight,
        ),
      ),
      appBar: AppBar(
        title: Text(_title ?? ''),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pendingTimeWidget(),
            TabBar(
              labelColor: AppColor.colorPrimaryButton,
              unselectedLabelColor: Colors.black,
              controller: _tabController,
              indicator: UnderlineTabIndicator(
                  borderSide:
                      BorderSide(color: AppColor.colorPrimaryButton, width: 2)),
              indicatorWeight: 1,
              tabs: [
                Tab(
                  child: Text(
                    'Thông tin',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
                  ),
                ),
                Tab(
                  child: Text(
                    'Sản phẩm',
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
                  ),
                ),
              ],
            ),
            Container(height: 1, color: Theme.of(context).dividerColor),
            Expanded(
                child: TabBarView(
              children: [
                InfoDeliveryPoint(
                    orderModel: _orderModel,
                    pointCurrent: _pointCurrent,
                    isPickPoint: _isPickPoint),
                ProductsDeliveryPoint(
                  products:
                      OrderUtils.collectProducts(_orderModel, _pointCurrent),
                  pointCurrent: _pointCurrent,
                )
              ],
              controller: _tabController,
            ))
          ],
        ),
      ),
    );
  }

  Widget _pendingTimeWidget() {
    return Visibility(
      visible: _pointCurrent?.status == PointStatus.PENDING,
      child: Container(
        width: ScreenUtil.getInstance().screenWidth,
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        color: Color(0xFFEDEDED),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Đơn hàng đã tạm hoãn',
                style: TextStyle(
                    color: Color(0xFF007AFF),
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16))),
            SizedBox(height: ScreenUtil.getInstance().getAdapterSize(8)),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Lý do: ',
                  style: TextStyle(
                      color: Color(0xFF666462),
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
              TextSpan(
                  text: _pointCurrent?.partnerNote ?? '',
                  style: TextStyle(
                      color: Color(0xFF131312),
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14)))
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: 'Hẹn giao lại: ',
                  style: TextStyle(
                      color: Color(0xFF666462),
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14))),
              TextSpan(
                  text:
                      '${DateUtil.formatDateMs(_pointCurrent?.expectedTime ?? 0, format: DateFormats.minuteHourDayMonthYear)}',
                  style: TextStyle(
                      color: Color(0xFF131312),
                      fontSize: ScreenUtil.getInstance().getAdapterSize(14)))
            ]))
          ],
        ),
      ),
    );
  }
}
