import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tms_partner_app/base/base.dart';
import 'package:tms_partner_app/data/model/models.dart';
import 'package:tms_partner_app/generated/l10n.dart';
import 'package:tms_partner_app/res/colors.dart';
import 'package:tms_partner_app/routes/screen_arguments.dart';
import 'package:tms_partner_app/utils/screen_util.dart';
import 'package:tms_partner_app/widgets/bottom_sheet/select_image_bottom_sheet.dart';

import '../../pages.dart';

class UserInfoPage extends BasePage {
  UserInfoPage({required this.data});

  static const routeName = '/UserInfo';
  final ScreenArguments data;

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _UserInfoPagePageState();
}

class _UserInfoPagePageState extends BasePageState<UserInfoPage> {
  late ProfileModel? profileModel;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imagePicked = [];

  @override
  void onCreate() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    profileModel = widget.data.arg1;
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
          S.current.account_information,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: ScreenUtil.getInstance().getAdapterSize(18)),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: AppColor.colorWhiteDark,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: AppColor.colorWhiteDark,
          padding: EdgeInsets.only(
              bottom: ScreenUtil.getInstance().getAdapterSize(50)),
          child: Column(
            children: [
              _imageInfoUser(),
              _itemInfo(
                  text: S.current.username,
                  trailingText: profileModel?.fullName ?? ''),
              _showDivider(),
              _itemInfo(
                  text: S.current.phone_number,
                  trailingText: profileModel?.phone.toString() ?? ''),
              _showDivider(),
              _itemInfo(
                  text: S.current.email,
                  trailingText: profileModel?.email.toString() ?? ''),
              _showDivider(),
              _itemInfo(
                  text: S.current.id_number,
                  trailingText: profileModel?.identityNumber ?? ''),
              _showDivider(),
              _itemBank(
                  text: S.current.account_information,
                  trailingText: profileModel?.bank?.agency ?? '',
                  iconData: Icons.chevron_right,
                  onTap: () {}),
              _showDivider(),
              _itemInfo(
                  text: S.current.escrow,
                  trailingText: profileModel?.loyaltyPoint.toString() ?? ''),
              _showDivider(),
              _itemInfo(
                  text: S.current.address,
                  trailingText:
                      '${profileModel?.address?.street ?? ''}, ${profileModel?.address?.districtName ?? ''}, ${profileModel?.address?.cityName ?? ''}'),
              Container(
                color: Colors.grey[200],
                height: ScreenUtil.getInstance().getAdapterSize(10),
              ),
              Padding(
                padding:
                    EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(15)),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      S.current.registration_means,
                      style: TextStyle(
                          fontSize: ScreenUtil.getInstance().getAdapterSize(20),
                          fontWeight: FontWeight.bold),
                    )),
              ),
              _itemInfo(
                  text: S.current.vehicle,
                  trailingText:
                      '${profileModel?.vehicle?.name ?? ''} / ${profileModel?.vehicle?.number ?? ''}'),
              _showDivider(),
              _itemTeam(
                  text: S.current.joining_service,
                  teamModel: profileModel!.teamModel!,
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemTeam(
      {required String text,
      required List<TeamModel>? teamModel,
      GestureTapCallback? onTap}) {
    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(45),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getAdapterSize(20)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(15))),
            Flexible(
              child: Text(
                _getItem(teamModel!) ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );
  }

  _getItem(List<TeamModel> teamModel) {
    StringBuffer result = new StringBuffer();
    for (int i = 0; i < teamModel.length; i++) {
      if (i == teamModel.length - 1) {
        result.write('${teamModel[i].name}');
      } else {
        result.write('${teamModel[i].name}' + ', ');
      }
    }
    return result.toString();
  }

  Widget _itemBank(
      {required String text,
      IconData? iconData,
      required String trailingText,
      GestureTapCallback? onTap}) {
    return Container(
      height: ScreenUtil.getInstance().getHeight(45),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getAdapterSize(20)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(15))),
            const Spacer(),
            Text(
              trailingText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
              overflow: TextOverflow.ellipsis,
            ),
            Icon(iconData)
          ],
        ),
      ),
    );
  }

  Widget _imageInfoUser() {
    return Padding(
      padding: EdgeInsets.all(ScreenUtil.getInstance().getAdapterSize(15)),
      child: Stack(
        children: [
          CachedNetworkImage(
            height: ScreenUtil.getInstance().getAdapterSize(90),
            width: ScreenUtil.getInstance().getAdapterSize(90),
            imageUrl: profileModel?.images?[0] ?? '',
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 150,
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/user.jpeg'),
          ),
          Positioned(
            bottom: ScreenUtil.getInstance().getAdapterSize(-25),
            left: ScreenUtil.getInstance().getAdapterSize(40),
            child: Container(
              height: ScreenUtil.getInstance().getAdapterSize(70),
              width: ScreenUtil.getInstance().getAdapterSize(70),
              child: IconButton(
                  onPressed: () {
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
                  icon: SvgPicture.asset(
                      'assets/icon/svg/ic_camera_picture.svg')),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePicked.add(image);
      });
    }
  }

  Future<void> _getImageGallery() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      if (images.length > 5) {
        // _bloc.showMsg('Số lượng ảnh không vượt quá 5');
      } else {
        setState(() {
          _imagePicked.addAll(images);
        });
      }
    }
  }

  Widget _headerOrder() {
    return Container(
      width: ScreenUtil.getInstance().screenWidth,
      height: ScreenUtil.getInstance().getAdapterSize(50),
      child: Stack(
        children: [
          Positioned(
            top: ScreenUtil.getInstance().getAdapterSize(20),
            left: ScreenUtil.getInstance().getAdapterSize(18),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
          ),
          Center(
            child: Text(
              S.current.avatar,
              style: TextStyle(
                  fontSize: ScreenUtil.getInstance().getAdapterSize(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemUploadPicture(String title, SvgPicture imageData,
      {GestureTapCallback? onTap}) {
    return ListTile(
      leading: imageData,
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _itemInfo(
      {required String text,
      required String trailingText,
      GestureTapCallback? onTap}) {
    return Container(
      height: ScreenUtil.getInstance().getAdapterSize(45),
      margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil.getInstance().getAdapterSize(20)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().getAdapterSize(15))),
            Flexible(
                child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil.getInstance().getAdapterSize(25)),
              child: Text(
                trailingText,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(15)),
                maxLines: 2,
                textAlign: TextAlign.right,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _showDivider() {
    return Divider(
      thickness: 1,
      indent: ScreenUtil.getScaleW(
          context, ScreenUtil.getInstance().getAdapterSize(15)),
      endIndent: ScreenUtil.getScaleW(
          context, ScreenUtil.getInstance().getAdapterSize(15)),
    );
  }
}
