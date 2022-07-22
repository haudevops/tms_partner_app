
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/common_utils/screen_util.dart';
import 'package:tms_partner_app/widgets/widgets.dart';

import '../scan_widget.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget(
      {Key? key,
      required this.onFilter,
      this.collections,
      this.orderStatus,
      this.service,
      this.filterModel})
      : super(key: key);
  final List<FilterModel>? collections;
  final List<FilterModel>? orderStatus;
  final List<FilterModel>? service;
  final Function(OrderWorkingFilterModel) onFilter;
  final OrderWorkingFilterModel? filterModel;

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  final _orderCodeController = TextEditingController();
  final _externalCodeController = TextEditingController();
  final _storeCodeController = TextEditingController();
  bool _checkedServices = false;
  bool _checkedOrderStatus = false;
  bool _checkCollections = false;
  List<String> _selectedServices = [];
  List<String> _selectedOrderStatus = [];
  List<String> _selectedCollections = [];
  final _filterModel = OrderWorkingFilterModel();

  @override
  void initState() {
    super.initState();

    if (widget.filterModel != null) {
      _orderCodeController.text = widget.filterModel?.code ?? '';
      _externalCodeController.text = widget.filterModel?.externalCode ?? '';
      _storeCodeController.text = widget.filterModel?.store ?? '';

      final filterServices = widget.filterModel?.services;
      if (filterServices != null) {
        _selectedServices = filterServices.split(',');
        _checkedServices = _selectedServices.length == widget.service?.length;
      }

      final filterStatus = widget.filterModel?.status;
      if (filterStatus != null) {
        _selectedOrderStatus = filterStatus.split(',');
        _checkedOrderStatus =
            _selectedOrderStatus.length == widget.orderStatus?.length;
      }

      final filterCollections = widget.filterModel?.submitted;
      if (filterCollections != null) {
        _selectedCollections = filterCollections.split(',');
        _checkCollections =
            _selectedCollections.length == widget.collections?.length;
      }
    }
  }

  void _openScanner(TextEditingController controller) {
    Navigator.pushNamed(context, ScanPage.routeName,
        arguments: ScreenArguments(arg1: (barCode) {
      setState(() {
        controller.text = barCode;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().screenHeight * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerWidget(),
          Divider(
            height: 1,
            color: AppColor.colorDivider,
          ),
          Expanded(
              child: ListView(
            children: [
              _itemScanCode(
                  title: S.current.package_code,
                  hintText: S.current.input_order_code,
                  isScan: true,
                  controller: _orderCodeController,
                  onTap: () {
                    _openScanner(_orderCodeController);
                  }),
              _itemScanCode(
                  title: S.current.external_code_title,
                  hintText: S.current.hint_external_filter,
                  isScan: true,
                  controller: _externalCodeController,
                  onTap: () {
                    _openScanner(_externalCodeController);
                  }),
              _itemScanCode(
                  title: S.current.store_code,
                  hintText: S.current.input_store_code,
                  isScan: true,
                  keyboardType: TextInputType.number,
                  controller: _storeCodeController),
              widget.service != null ? _serviceWidget() : Container(),
              widget.orderStatus != null ? _orderStatus() : Container(),
              widget.collections != null ? _collectionWidget() : Container(),
              const SizedBox(height: 10),
              _submitWidget(),
              const SizedBox(height: 10),
            ],
          )),
        ],
      ),
    );
  }

  Widget _serviceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _checkBoxWidget(
            title: S.current.service,
            isChecked: _checkedServices,
            onChanged: (value) {
              setState(() {
                _checkedServices = value!;
                if (value) {
                  _selectedServices = widget.service!.map((e) => e.id).toList();
                } else {
                  _selectedServices = [];
                }
              });
            }),
        Wrap(
            spacing: 10,
            children: _buildChoiceList(
                value: widget.service!, listSelected: _selectedServices)),
      ],
    );
  }

  Widget _orderStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _checkBoxWidget(
            title: S.current.order_status,
            isChecked: _checkedOrderStatus,
            onChanged: (value) {
              setState(() {
                _checkedOrderStatus = value!;
                if (value) {
                  _selectedOrderStatus =
                      widget.orderStatus!.map((e) => e.id).toList();
                } else {
                  _selectedOrderStatus = [];
                }
              });
            }),
        Wrap(
            spacing: 10,
            children: _buildChoiceList(
                value: widget.orderStatus!,
                listSelected: _selectedOrderStatus)),
      ],
    );
  }

  Widget _collectionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _checkBoxWidget(
            title: S.current.collected_money,
            isChecked: _checkCollections,
            onChanged: (value) {
              setState(() {
                _checkCollections = value!;
                if (value) {
                  _selectedCollections =
                      widget.collections!.map((e) => e.id).toList();
                } else {
                  _selectedCollections = [];
                }
              });
            }),
        Wrap(
            spacing: 10,
            children: _buildChoiceList(
                value: widget.collections!,
                listSelected: _selectedCollections)),
      ],
    );
  }

  Widget _headerWidget() {
    return SizedBox(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getAdapterSize(50),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
          ),
          Center(
            child: Text(
              S.current.filter,
              style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(16)),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                _orderCodeController.clear();
                _externalCodeController.clear();
                _storeCodeController.clear();
                setState(() {
                  _checkedServices = false;
                  _checkedOrderStatus = false;
                  _selectedServices = [];
                  _selectedOrderStatus = [];
                });
                widget.onFilter(_filterModel);
                Navigator.pop(context);
              },
              onDoubleTap: () {},
              child: Text(
                S.current.reset,
                style: TextStyle(fontSize: ScreenUtil.getInstance().getSp(14)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemScanCode(
      {required String title,
      required String hintText,
      required isScan,
      required TextEditingController controller,
      TextInputType? keyboardType,
      GestureTapCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            title,
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().getSp(15),
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 20,
              child: TextField(
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintStyle:
                      TextStyle(fontSize: ScreenUtil.getInstance().getSp(13)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: AppColor.colorDivider,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: AppColor.colorDivider,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Visibility(visible: isScan, child: const Spacer()),
            Visibility(
              visible: isScan,
              child: GestureDetector(
                onTap: onTap,
                child: SvgPicture.asset('assets/icon/ic_scan_qr_black.svg'),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _checkBoxWidget(
      {required String title,
      required bool isChecked,
      required ValueChanged<bool?> onChanged}) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.getInstance().getSp(15), color: Colors.black),
        ),
        value: isChecked,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: onChanged,
      ),
    );
  }

  List<Widget> _buildChoiceList(
      {required List<FilterModel> value, required List<String> listSelected}) {
    List<Widget> choices = [];
    value.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.name),
          labelStyle: TextStyle(
            color: AppColor.colorWhiteDark,
          ),
          backgroundColor: AppColor.colorItemDarkWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
                color: listSelected.contains(item.id)
                    ? AppColor.colorPrimaryButton
                    : AppColor.colorDivider,
                width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          selected: listSelected.contains(item),
          onSelected: (selected) {
            setState(() {
              listSelected.contains(item.id)
                  ? listSelected.remove(item.id)
                  : listSelected.add(item.id);
              //widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  Widget _submitWidget() {
    return Align(
      alignment: Alignment.center,
      child: ButtonSubmitWidget(
        onPressed: () {
          _filterModel.code = _orderCodeController.text;
          _filterModel.externalCode = _externalCodeController.text;
          _filterModel.store = _storeCodeController.text;
          _filterModel.services = _selectedServices.join(',');
          _filterModel.status = _selectedOrderStatus.isNotEmpty
              ? _selectedOrderStatus.join(',')
              : null;
          _filterModel.submitted = _selectedCollections.join(',');
          widget.onFilter(_filterModel);
          Navigator.pop(context);
        },
        title: S.current.apply,
        colorTitle: Colors.white,
        paddingHorizontal: ScreenUtil.getInstance().getAdapterSize(30),
        marginVertical: 10,
      ),
    );
  }
}
