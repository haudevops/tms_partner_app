import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/data/service/cloud_service.dart';
import 'package:tms_partner_app/pages/pages.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/common_utils/date_util.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/bottom_sheet/select_image_bottom_sheet.dart';
import 'package:tms_partner_app/widgets/photo_view.dart';
import 'dart:ui' as ui;
import '../../../utils/order/order_utils.dart';
import '../../../widgets/widgets.dart';
import 'confirm_pick_goods_success_bloc.dart';

class ConfirmPickGoodsSuccessPage
    extends BasePage<ConfirmPickGoodsSuccessBloc> {
  ConfirmPickGoodsSuccessPage({Key? key, required this.arguments})
      : super(bloc: ConfirmPickGoodsSuccessBloc());

  static const routeName = '/ConfirmPickGoodsSuccessPage';

  final ScreenArguments arguments;

  @override
  BasePageState<BasePage<BaseBloc>> getState() =>
      _ConfirmPickGoodsSuccessState();
}

class _ConfirmPickGoodsSuccessState
    extends BasePageState<ConfirmPickGoodsSuccessPage> {
  late OrderModel _orderModel;
  late PointTargetFinder _pointTargetFinder;
  late ConfirmPickGoodsSuccessBloc _bloc;
  late List<ProductModel> _products;
  List<XFile> _imageResult = [];
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<SfSignaturePadState> _signatureGlobalKey = GlobalKey();
  bool _checkSigned = false;
  final GlobalKey _imageKey = GlobalKey();
  final String _directoryName = 'Signature';

  @override
  void onCreate() {
    _orderModel = widget.arguments.arg1;
    _pointTargetFinder = widget.arguments.arg2;
    _bloc = getBloc();
    _products = _getProductPoints();
  }

  Future<void> _getImageCamera() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxHeight: 1280,
        maxWidth: 720);
    if (image != null) {
      setState(() {
        _imageResult.add(image);
      });
    }
  }

  Future<void> _getImageGallery() async {
    final List<XFile>? _imgSelected = await _picker.pickMultiImage(
        imageQuality: 90, maxHeight: 1280, maxWidth: 720);
    if (_imgSelected != null) {
      if (_imgSelected.length > 5) {
        _bloc.showMsg('Số lượng ảnh không vượt quá 5');
      } else {
        setState(() {
          _imageResult.addAll(_imgSelected);
        });
      }
    }
  }

  void _showPhotoView(XFile xFile) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return PhotoView(
            arguments: ScreenArguments(arg1: xFile.path),
          );
        },
        fullscreenDialog: true));
  }

  List<ProductModel> _getProductPoints() {
    List<ProductModel> productPoints = [];
    List<Point>? points = _orderModel.detail?.points;

    if (_orderModel.detail != null && points != null) {
      for (final orderPoint in points) {
        if (orderPoint.products != null && orderPoint.products!.isNotEmpty) {
          productPoints.addAll(orderPoint.products!);
        }
      }
    }
    return productPoints;
  }

  Future<ByteData?> _getSignaturePad() async {
    final ui.Image data =
        await _signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);

    return await data.toByteData(format: ui.ImageByteFormat.png);
  }

  double _getTotalCost() {
    double totalCost = 0;
    if (_orderModel.groups != null && _orderModel.groups!.isNotEmpty) {
      totalCost = (_pointTargetFinder.point?.userCost ?? 0) *
          _orderModel.groups!.length;
    } else {
      totalCost = _pointTargetFinder.point?.userCost ?? 0;
    }
    return totalCost;
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Xác nhận lấy hàng thành công',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: AppColor.colorWhiteDark,
      ),
      body: Container(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        color: AppColor.colorWhiteDark,
        child: CustomScrollView(
          slivers: [
            _imageWidget(),
            _dividerWidget(),
            _products.isNotEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                ScreenUtil.getInstance().getAdapterSize(16)),
                        child: Row(children: [
                          _textTitle('Sản phẩm lấy tại đây'),
                          const Spacer(),
                          _textTitle('Số lượng')
                        ])))
                : SliverToBoxAdapter(),
            _products.isNotEmpty
                ? SliverPadding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            ScreenUtil.getInstance().getAdapterSize(16)),
                    sliver: _listProductWidget())
                : SliverToBoxAdapter(),
            _signaturePadWidget(),
            // _totalCostWidget(),
            _submitWidget(_pointTargetFinder, _orderModel)
          ],
        ),
      ),
    );
  }

  SliverPadding _imageWidget() {
    return SliverPadding(
        padding: EdgeInsets.only(
            left: ScreenUtil.getInstance().getAdapterSize(16),
            top: ScreenUtil.getInstance().getAdapterSize(16)),
        sliver: SliverToBoxAdapter(
            key: _imageKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textTitle('Hình ảnh thực tế'),
                _margin(12),
                Container(
                  height: ScreenUtil.getInstance().getAdapterSize(54),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (_imageResult.length < 5)
                          ? _imageResult.length + 1
                          : _imageResult.length,
                      itemBuilder: (context, index) {
                        if (_imageResult.length == index &&
                            _imageResult.length < 5) {
                          return _addImageWidget();
                        }
                        return _photoWidget(_imageResult[index]);
                      }),
                )
              ],
            )));
  }

  Widget _addImageWidget() {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: DottedBorder(
        color: Color(0xFFA49F9B),
        radius: Radius.circular(6),
        borderType: BorderType.RRect,
        strokeWidth: 1,
        dashPattern: [5, 3],
        child: GestureDetector(
          onDoubleTap: () {},
          onTap: () {
            SelectImageBottomSheet().show(
                context: context,
                onSelect: (value) {
                  if (value == SelectOptionImage.Camera) {
                    _getImageCamera();
                  } else {
                    _getImageGallery();
                  }
                });
          },
          child: Container(
            width: ScreenUtil.getInstance().getAdapterSize(54),
            height: ScreenUtil.getInstance().getAdapterSize(54),
            color: const Color(0xFFFAFAFA),
            child:
                const Center(child: Icon(Icons.add, color: Color(0xFFA49F9B))),
          ),
        ),
      ),
    );
  }

  Widget _photoWidget(XFile imagePicked) {
    return Padding(
      padding:
          EdgeInsets.only(right: ScreenUtil.getInstance().getAdapterSize(12)),
      child: GestureDetector(
        onTap: () {
          _showPhotoView(imagePicked);
        },
        child: SizedBox(
          width: ScreenUtil.getInstance().getAdapterSize(54),
          height: ScreenUtil.getInstance().getAdapterSize(54),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.file(File(imagePicked.path),
                      fit: BoxFit.cover,
                      width: ScreenUtil.getInstance().getAdapterSize(54),
                      height: ScreenUtil.getInstance().getAdapterSize(54)),
              ),
              Positioned(
                  top: ScreenUtil.getInstance().getAdapterSize(2),
                  right: ScreenUtil.getInstance().getAdapterSize(2),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _imageResult.remove(imagePicked);
                        });
                      },
                      onDoubleTap: () {},
                      child: SvgPicture.asset(
                          'assets/icon/svg/ic_remove_image.svg')))
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _dividerWidget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
        child: Divider(
          height: 1,
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  SliverList _listProductWidget() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(
                top: ScreenUtil.getInstance().getAdapterSize(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Text(_products[index].name ?? '',
                          style: TextStyle(
                              color: const Color(0xFF666462),
                              fontSize:
                                  ScreenUtil.getInstance().getAdapterSize(14))),
                    ),
                    const Spacer(),
                    Text('${_products[index].quantity}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                ScreenUtil.getInstance().getAdapterSize(14)))
                  ],
                ),
                _margin(2),
                _itemProduct(title: 'Serial', content: _products[index].serial),
                _margin(2),
                _itemProduct(title: 'SKU', content: _products[index].sku),
                _margin(12),
                Divider(height: 1, color: Colors.black.withOpacity(0.2))
              ],
            ),
          );
        },
        childCount: _products.length,
      ),
    );
  }

  SliverToBoxAdapter _signaturePadWidget() {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textTitle('Chữ ký khách hàng'),
          _margin(12),
          Container(
              height: ScreenUtil.getInstance().getAdapterSize(180),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFA49F9B)),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  !_checkSigned
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  ScreenUtil.getInstance().getAdapterSize(65)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icon/svg/ic_pen.svg'),
                              _margin(12),
                              Text(
                                  'Hãy ký xác nhận tất cả thông tin là chính xác',
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance()
                                          .getAdapterSize(12),
                                      color: Colors.grey),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        )
                      : const SizedBox(),
                  SfSignaturePad(
                      key: _signatureGlobalKey,
                      strokeColor: Colors.black,
                      backgroundColor: Colors.transparent,
                      onDrawStart: () {
                        if (!_checkSigned) {
                          setState(() {
                            _checkSigned = true;
                          });
                        }
                        return false;
                      },
                      minimumStrokeWidth: 1.0,
                      maximumStrokeWidth: 4.0),
                  Positioned(
                    right: ScreenUtil.getInstance().getAdapterSize(12),
                    top: ScreenUtil.getInstance().getAdapterSize(12),
                    child: GestureDetector(
                      onTap: () {
                        _signatureGlobalKey.currentState!.clear();
                        setState(() {
                          _checkSigned = false;
                        });
                      },
                      child: Text('Xóa',
                          style: TextStyle(
                              fontSize:
                                  ScreenUtil.getInstance().getAdapterSize(12),
                              color: Colors.red)),
                    ),
                  )
                ],
              )),
          _margin(16),
          _textTitle('Họ và tên khách hàng:'),
          _margin(12),
          Text(_pointTargetFinder.point?.contact?.name ?? '',
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16))),
          _margin(4),
          Divider(height: 1, color: Colors.black.withOpacity(0.2)),
          _margin(16),
          _textTitle('Ghi chú:'),
          _margin(12),
          TextField(
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú',
                hintStyle: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2)),
                ),
              )),
          _margin(47),
        ],
      ),
    ));
  }

  Widget _itemProduct({required String title, String? content}) {
    return (content != null && content.isNotEmpty)
        ? Text('$title: $content',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil.getInstance().getAdapterSize(14)))
        : const SizedBox();
  }

  SliverToBoxAdapter _totalCostWidget() {
    return SliverToBoxAdapter(
      child: Container(
        color: const Color(0xFFFFF1E5),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil.getInstance().getAdapterSize(16),
            vertical: ScreenUtil.getInstance().getAdapterSize(7)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tổng tiền thực nhận',
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(12)),
                ),
                Text(OrderUtils.getCurrencyText(_getTotalCost()),
                    style: TextStyle(
                        fontSize: ScreenUtil.getInstance().getAdapterSize(16),
                        color: Colors.red,
                        fontWeight: FontWeight.w700))
              ],
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: SvgPicture.asset('assets/icon/svg/ic_warning.svg'),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _submitWidget(PointTargetFinder pointTargetFinder, OrderModel orderModel) {
    return SliverToBoxAdapter(
      child: ButtonSubmitWidget(
        title: 'XÁC NHẬN',
        colorTitle: Colors.white,
        height: ScreenUtil.getInstance().getAdapterSize(44),
        marginHorizontal: ScreenUtil.getInstance().getAdapterSize(16),
        marginVertical: ScreenUtil.getInstance().getAdapterSize(16),
        onPressed: () async {
          bool _checkValidate = await _validateData();
          if (_checkValidate) {
            var status = await Permission.storage.status;
            if (status.isGranted) {
              _saveSignaturePad();
            } else {
              await Permission.storage.request();
            }
          }
          CloudService().upload(_imageResult);
          _bloc.doPickupSuccess(pointTargetFinder, orderModel);
        },
      ),
    );
  }

  Future<void> _saveSignaturePad() async {
    Directory? directory = await getExternalStorageDirectory();
    String? path = directory?.path;
    print(path);

    if (path != null && path.isNotEmpty) {
      await Directory('$path/$_directoryName').create(recursive: true);

      ByteData? pngBytes = await _getSignaturePad();
      if (pngBytes != null) {
        File('$path/$_directoryName/${DateUtil.getNowDateMs()}.png')
            .writeAsBytesSync(pngBytes.buffer.asInt8List());
      }
    }
  }

  Future<bool> _validateData() async {
    if (_imageResult.length < 1) {
      Scrollable.ensureVisible(_imageKey.currentContext!);
      _bloc.showMsg('Vui lòng thêm hình ảnh thực tế.');
      return false;
    }

    if (!_checkSigned) {
      Scrollable.ensureVisible(_signatureGlobalKey.currentContext!);
      _bloc.showMsg('Vui lòng ký tên trước khi tiếp tục.');
      return false;
    }
    return true;
  }

  Widget _margin(double height) {
    return SizedBox(height: ScreenUtil.getInstance().getAdapterSize(height));
  }

  Widget _textTitle(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: ScreenUtil.getInstance().getAdapterSize(16),
            fontWeight: FontWeight.w600));
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
