// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Eton Partner`
  String get app_name {
    return Intl.message(
      'Eton Partner',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Request to API server was cancelled.`
  String get request_cancel {
    return Intl.message(
      'Request to API server was cancelled.',
      name: 'request_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Connect timeout.`
  String get connect_timeout {
    return Intl.message(
      'Connect timeout.',
      name: 'connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out.`
  String get request_timed_out {
    return Intl.message(
      'Request timed out.',
      name: 'request_timed_out',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout`
  String get receive_timed_out {
    return Intl.message(
      'Receive timeout',
      name: 'receive_timed_out',
      desc: '',
      args: [],
    );
  }

  /// `Syntax error request`
  String get syntax_error_request {
    return Intl.message(
      'Syntax error request',
      name: 'syntax_error_request',
      desc: '',
      args: [],
    );
  }

  /// `Access denied`
  String get access_denied {
    return Intl.message(
      'Access denied',
      name: 'access_denied',
      desc: '',
      args: [],
    );
  }

  /// `The server refused to execute.`
  String get the_server_refused_to_execute {
    return Intl.message(
      'The server refused to execute.',
      name: 'the_server_refused_to_execute',
      desc: '',
      args: [],
    );
  }

  /// `Can not connect to server`
  String get can_not_connect_to_server {
    return Intl.message(
      'Can not connect to server',
      name: 'can_not_connect_to_server',
      desc: '',
      args: [],
    );
  }

  /// `Method not allowed.`
  String get method_not_allowed {
    return Intl.message(
      'Method not allowed.',
      name: 'method_not_allowed',
      desc: '',
      args: [],
    );
  }

  /// `Server internal error`
  String get server_internal_error {
    return Intl.message(
      'Server internal error',
      name: 'server_internal_error',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request`
  String get invalid_request {
    return Intl.message(
      'Invalid request',
      name: 'invalid_request',
      desc: '',
      args: [],
    );
  }

  /// `The server has crashed`
  String get the_server_has_crashed {
    return Intl.message(
      'The server has crashed',
      name: 'the_server_has_crashed',
      desc: '',
      args: [],
    );
  }

  /// `Does not support HTTP protocol requests`
  String get does_not_support_HTTP_protocol_requests {
    return Intl.message(
      'Does not support HTTP protocol requests',
      name: 'does_not_support_HTTP_protocol_requests',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error`
  String get an_unknown_error {
    return Intl.message(
      'An unknown error',
      name: 'an_unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `No network connection`
  String get no_network_connection {
    return Intl.message(
      'No network connection',
      name: 'no_network_connection',
      desc: '',
      args: [],
    );
  }

  /// `HOME`
  String get navigation_home {
    return Intl.message(
      'HOME',
      name: 'navigation_home',
      desc: '',
      args: [],
    );
  }

  /// `ORDERS`
  String get navigation_order {
    return Intl.message(
      'ORDERS',
      name: 'navigation_order',
      desc: '',
      args: [],
    );
  }

  /// `COD`
  String get navigation_cod {
    return Intl.message(
      'COD',
      name: 'navigation_cod',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get navigation_notification {
    return Intl.message(
      'Notification',
      name: 'navigation_notification',
      desc: '',
      args: [],
    );
  }

  /// `MENU`
  String get navigation_more {
    return Intl.message(
      'MENU',
      name: 'navigation_more',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get pass_word {
    return Intl.message(
      'Password',
      name: 'pass_word',
      desc: '',
      args: [],
    );
  }

  /// `Phone number can not be empty`
  String get empty_phone_number {
    return Intl.message(
      'Phone number can not be empty',
      name: 'empty_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `invalid phone number`
  String get invalid_phone_number {
    return Intl.message(
      'invalid phone number',
      name: 'invalid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Password can not be empty`
  String get empty_pass_word {
    return Intl.message(
      'Password can not be empty',
      name: 'empty_pass_word',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, please try again!`
  String get something_went_wrong_please_try_again {
    return Intl.message(
      'Something went wrong, please try again!',
      name: 'something_went_wrong_please_try_again',
      desc: '',
      args: [],
    );
  }

  /// `FUNCTIONS`
  String get functions {
    return Intl.message(
      'FUNCTIONS',
      name: 'functions',
      desc: '',
      args: [],
    );
  }

  /// `Order history`
  String get menu_history {
    return Intl.message(
      'Order history',
      name: 'menu_history',
      desc: '',
      args: [],
    );
  }

  /// `Statistical`
  String get menu_statistical {
    return Intl.message(
      'Statistical',
      name: 'menu_statistical',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get menu_wallet {
    return Intl.message(
      'Wallet',
      name: 'menu_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Share code`
  String get menu_share_code {
    return Intl.message(
      'Share code',
      name: 'menu_share_code',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get menu_news {
    return Intl.message(
      'News',
      name: 'menu_news',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get menu_help {
    return Intl.message(
      'Help',
      name: 'menu_help',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get menu_setting {
    return Intl.message(
      'Setting',
      name: 'menu_setting',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get menu_logout {
    return Intl.message(
      'Logout',
      name: 'menu_logout',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Policy`
  String get terms_policy {
    return Intl.message(
      'Terms & Policy',
      name: 'terms_policy',
      desc: '',
      args: [],
    );
  }

  /// `point`
  String get point {
    return Intl.message(
      'point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification_title {
    return Intl.message(
      'Notification',
      name: 'notification_title',
      desc: '',
      args: [],
    );
  }

  /// `© 2020 - Designed by`
  String get info_app {
    return Intl.message(
      '© 2020 - Designed by',
      name: 'info_app',
      desc: '',
      args: [],
    );
  }

  /// `Load fail, tap to retry`
  String get load_more_fail {
    return Intl.message(
      'Load fail, tap to retry',
      name: 'load_more_fail',
      desc: '',
      args: [],
    );
  }

  /// `Wait for loading.`
  String get load_more_wait {
    return Intl.message(
      'Wait for loading.',
      name: 'load_more_wait',
      desc: '',
      args: [],
    );
  }

  /// `Loading, wait for moment ...`
  String get load_more_wait_moment {
    return Intl.message(
      'Loading, wait for moment ...',
      name: 'load_more_wait_moment',
      desc: '',
      args: [],
    );
  }

  /// `No more data`
  String get load_more_no_more {
    return Intl.message(
      'No more data',
      name: 'load_more_no_more',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message(
      'Processing',
      name: 'processing',
      desc: '',
      args: [],
    );
  }

  /// `Accomplished`
  String get accomplished {
    return Intl.message(
      'Accomplished',
      name: 'accomplished',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Installation`
  String get installation {
    return Intl.message(
      'Installation',
      name: 'installation',
      desc: '',
      args: [],
    );
  }

  /// `Delivery and installation`
  String get delivery_and_installation {
    return Intl.message(
      'Delivery and installation',
      name: 'delivery_and_installation',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get order_status_pending {
    return Intl.message(
      'Pending',
      name: 'order_status_pending',
      desc: '',
      args: [],
    );
  }

  /// `Returns`
  String get delivery_return {
    return Intl.message(
      'Returns',
      name: 'delivery_return',
      desc: '',
      args: [],
    );
  }

  /// `Order code`
  String get order_code {
    return Intl.message(
      'Order code',
      name: 'order_code',
      desc: '',
      args: [],
    );
  }

  /// `Enter the order code`
  String get input_order_code {
    return Intl.message(
      'Enter the order code',
      name: 'input_order_code',
      desc: '',
      args: [],
    );
  }

  /// `External code`
  String get external_code_title {
    return Intl.message(
      'External code',
      name: 'external_code_title',
      desc: '',
      args: [],
    );
  }

  /// `Enter the external code`
  String get hint_external_filter {
    return Intl.message(
      'Enter the external code',
      name: 'hint_external_filter',
      desc: '',
      args: [],
    );
  }

  /// `Phone number of the recipient`
  String get received_phone {
    return Intl.message(
      'Phone number of the recipient',
      name: 'received_phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter the recipient's phone number`
  String get input_received_phone {
    return Intl.message(
      'Enter the recipient\'s phone number',
      name: 'input_received_phone',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message(
      'Service',
      name: 'service',
      desc: '',
      args: [],
    );
  }

  /// `Order status`
  String get order_status {
    return Intl.message(
      'Order status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personal_information {
    return Intl.message(
      'Personal information',
      name: 'personal_information',
      desc: '',
      args: [],
    );
  }

  /// `REWARD POINTS`
  String get reward_point {
    return Intl.message(
      'REWARD POINTS',
      name: 'reward_point',
      desc: '',
      args: [],
    );
  }

  /// `RATE`
  String get rate {
    return Intl.message(
      'RATE',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `PHONE NUMBER`
  String get phone_number_uppercase {
    return Intl.message(
      'PHONE NUMBER',
      name: 'phone_number_uppercase',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Joining Service`
  String get joining_service {
    return Intl.message(
      'Joining Service',
      name: 'joining_service',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicle {
    return Intl.message(
      'Vehicle',
      name: 'vehicle',
      desc: '',
      args: [],
    );
  }

  /// `CHANGE`
  String get change_car {
    return Intl.message(
      'CHANGE',
      name: 'change_car',
      desc: '',
      args: [],
    );
  }

  /// `CUSTOMER SERVICE LEVEL`
  String get customer_service_level {
    return Intl.message(
      'CUSTOMER SERVICE LEVEL',
      name: 'customer_service_level',
      desc: '',
      args: [],
    );
  }

  /// `Id number`
  String get id_number {
    return Intl.message(
      'Id number',
      name: 'id_number',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get account_information {
    return Intl.message(
      'Account Information',
      name: 'account_information',
      desc: '',
      args: [],
    );
  }

  /// `No information`
  String get no_information {
    return Intl.message(
      'No information',
      name: 'no_information',
      desc: '',
      args: [],
    );
  }

  /// `Escrow`
  String get escrow {
    return Intl.message(
      'Escrow',
      name: 'escrow',
      desc: '',
      args: [],
    );
  }

  /// `MEDIA PICTURE`
  String get media_picture {
    return Intl.message(
      'MEDIA PICTURE',
      name: 'media_picture',
      desc: '',
      args: [],
    );
  }

  /// `No picture`
  String get no_picture {
    return Intl.message(
      'No picture',
      name: 'no_picture',
      desc: '',
      args: [],
    );
  }

  /// `CHANGE PASSWORD`
  String get change_password {
    return Intl.message(
      'CHANGE PASSWORD',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Safe Mode`
  String get safe_mode {
    return Intl.message(
      'Safe Mode',
      name: 'safe_mode',
      desc: '',
      args: [],
    );
  }

  /// `timed out`
  String get order_status_timeout {
    return Intl.message(
      'timed out',
      name: 'order_status_timeout',
      desc: '',
      args: [],
    );
  }

  /// `New orders`
  String get order_status_new {
    return Intl.message(
      'New orders',
      name: 'order_status_new',
      desc: '',
      args: [],
    );
  }

  /// `Searching`
  String get order_status_finding {
    return Intl.message(
      'Searching',
      name: 'order_status_finding',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get order_status_accepted {
    return Intl.message(
      'Accepted',
      name: 'order_status_accepted',
      desc: '',
      args: [],
    );
  }

  /// `canceled by user`
  String get order_status_canceled_user {
    return Intl.message(
      'canceled by user',
      name: 'order_status_canceled_user',
      desc: '',
      args: [],
    );
  }

  /// `canceled by partner`
  String get order_status_canceled_partner {
    return Intl.message(
      'canceled by partner',
      name: 'order_status_canceled_partner',
      desc: '',
      args: [],
    );
  }

  /// `canceled by etonX`
  String get order_status_canceled_admin {
    return Intl.message(
      'canceled by etonX',
      name: 'order_status_canceled_admin',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get order_status_in_progress {
    return Intl.message(
      'Processing',
      name: 'order_status_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get order_status_finished {
    return Intl.message(
      'Completed',
      name: 'order_status_finished',
      desc: '',
      args: [],
    );
  }

  /// `Completed with return`
  String get order_status_finished_returned {
    return Intl.message(
      'Completed with return',
      name: 'order_status_finished_returned',
      desc: '',
      args: [],
    );
  }

  /// `Returning`
  String get order_status_returning {
    return Intl.message(
      'Returning',
      name: 'order_status_returning',
      desc: '',
      args: [],
    );
  }

  /// `Incident`
  String get order_status_incident {
    return Intl.message(
      'Incident',
      name: 'order_status_incident',
      desc: '',
      args: [],
    );
  }

  /// `Processing incident`
  String get order_status_in_incident {
    return Intl.message(
      'Processing incident',
      name: 'order_status_in_incident',
      desc: '',
      args: [],
    );
  }

  /// `Waiting confirm`
  String get order_status_waiting_confirm {
    return Intl.message(
      'Waiting confirm',
      name: 'order_status_waiting_confirm',
      desc: '',
      args: [],
    );
  }

  /// `installation failed`
  String get order_status_install_fail {
    return Intl.message(
      'installation failed',
      name: 'order_status_install_fail',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Individual`
  String get individual {
    return Intl.message(
      'Individual',
      name: 'individual',
      desc: '',
      args: [],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to sign out of this account?`
  String get logout_confirm {
    return Intl.message(
      'Are you sure you want to sign out of this account?',
      name: 'logout_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Consulting failed`
  String get point_status_advice_failed {
    return Intl.message(
      'Consulting failed',
      name: 'point_status_advice_failed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to picking goods`
  String get point_status_pick_failed {
    return Intl.message(
      'Failed to picking goods',
      name: 'point_status_pick_failed',
      desc: '',
      args: [],
    );
  }

  /// `Installation failed`
  String get point_status_install_failed {
    return Intl.message(
      'Installation failed',
      name: 'point_status_install_failed',
      desc: '',
      args: [],
    );
  }

  /// `Delivery failed`
  String get point_status_deliver_failed {
    return Intl.message(
      'Delivery failed',
      name: 'point_status_deliver_failed',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get point_status_delivered {
    return Intl.message(
      'Delivered',
      name: 'point_status_delivered',
      desc: '',
      args: [],
    );
  }

  /// `Installed`
  String get point_status_installed {
    return Intl.message(
      'Installed',
      name: 'point_status_installed',
      desc: '',
      args: [],
    );
  }

  /// `Installation in progress`
  String get point_status_installing {
    return Intl.message(
      'Installation in progress',
      name: 'point_status_installing',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation points`
  String get point_status_canceled {
    return Intl.message(
      'Cancellation points',
      name: 'point_status_canceled',
      desc: '',
      args: [],
    );
  }

  /// `Skip point`
  String get point_status_skipped {
    return Intl.message(
      'Skip point',
      name: 'point_status_skipped',
      desc: '',
      args: [],
    );
  }

  /// `Incident point`
  String get point_status_incident_new {
    return Intl.message(
      'Incident point',
      name: 'point_status_incident_new',
      desc: '',
      args: [],
    );
  }

  /// `Process incident point`
  String get point_status_incident_accept {
    return Intl.message(
      'Process incident point',
      name: 'point_status_incident_accept',
      desc: '',
      args: [],
    );
  }

  /// `Completed incident point`
  String get point_status_incident_done {
    return Intl.message(
      'Completed incident point',
      name: 'point_status_incident_done',
      desc: '',
      args: [],
    );
  }

  /// `Arrived point`
  String get point_status_arrived {
    return Intl.message(
      'Arrived point',
      name: 'point_status_arrived',
      desc: '',
      args: [],
    );
  }

  /// `Returned point`
  String get point_status_returned {
    return Intl.message(
      'Returned point',
      name: 'point_status_returned',
      desc: '',
      args: [],
    );
  }

  /// `Return failed point`
  String get point_status_return_failed {
    return Intl.message(
      'Return failed point',
      name: 'point_status_return_failed',
      desc: '',
      args: [],
    );
  }

  /// `picked good success point`
  String get point_status_pick_success {
    return Intl.message(
      'picked good success point',
      name: 'point_status_pick_success',
      desc: '',
      args: [],
    );
  }

  /// `Agree to quotation point`
  String get point_status_accept_quotation {
    return Intl.message(
      'Agree to quotation point',
      name: 'point_status_accept_quotation',
      desc: '',
      args: [],
    );
  }

  /// `Schedule appointment point`
  String get point_status_scheduled {
    return Intl.message(
      'Schedule appointment point',
      name: 'point_status_scheduled',
      desc: '',
      args: [],
    );
  }

  /// `Sent quotation point`
  String get point_status_send_quotation {
    return Intl.message(
      'Sent quotation point',
      name: 'point_status_send_quotation',
      desc: '',
      args: [],
    );
  }

  /// `Completed point`
  String get point_status_done {
    return Intl.message(
      'Completed point',
      name: 'point_status_done',
      desc: '',
      args: [],
    );
  }

  /// `Failure point`
  String get point_status_failed {
    return Intl.message(
      'Failure point',
      name: 'point_status_failed',
      desc: '',
      args: [],
    );
  }

  /// `In progress point`
  String get point_status_in_progress {
    return Intl.message(
      'In progress point',
      name: 'point_status_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Finish later point`
  String get point_status_finish_later {
    return Intl.message(
      'Finish later point',
      name: 'point_status_finish_later',
      desc: '',
      args: [],
    );
  }

  /// `Not arrived yet picking point`
  String get point_status_new_pick_point {
    return Intl.message(
      'Not arrived yet picking point',
      name: 'point_status_new_pick_point',
      desc: '',
      args: [],
    );
  }

  /// `Not arrived yet delivery point`
  String get point_status_new_delivery {
    return Intl.message(
      'Not arrived yet delivery point',
      name: 'point_status_new_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Not arrived yet installation point`
  String get point_status_new_install {
    return Intl.message(
      'Not arrived yet installation point',
      name: 'point_status_new_install',
      desc: '',
      args: [],
    );
  }

  /// `Not return point`
  String get point_status_new_return {
    return Intl.message(
      'Not return point',
      name: 'point_status_new_return',
      desc: '',
      args: [],
    );
  }

  /// `Not return warehouse point`
  String get point_status_new_return_warehouse {
    return Intl.message(
      'Not return warehouse point',
      name: 'point_status_new_return_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Not warranty point`
  String get point_status_new_warranty {
    return Intl.message(
      'Not warranty point',
      name: 'point_status_new_warranty',
      desc: '',
      args: [],
    );
  }

  /// `Not repair point`
  String get point_status_new_repair {
    return Intl.message(
      'Not repair point',
      name: 'point_status_new_repair',
      desc: '',
      args: [],
    );
  }

  /// `Not implementation point`
  String get point_status_new_advice {
    return Intl.message(
      'Not implementation point',
      name: 'point_status_new_advice',
      desc: '',
      args: [],
    );
  }

  /// `Pick up later`
  String get point_status_pick_later {
    return Intl.message(
      'Pick up later',
      name: 'point_status_pick_later',
      desc: '',
      args: [],
    );
  }

  /// `Delivery later`
  String get point_status_delivery_later {
    return Intl.message(
      'Delivery later',
      name: 'point_status_delivery_later',
      desc: '',
      args: [],
    );
  }

  /// `Return later`
  String get point_status_return_later {
    return Intl.message(
      'Return later',
      name: 'point_status_return_later',
      desc: '',
      args: [],
    );
  }

  /// `Tạm hoãn`
  String get point_status_pending {
    return Intl.message(
      'Tạm hoãn',
      name: 'point_status_pending',
      desc: '',
      args: [],
    );
  }

  /// `Please select an estimated time.`
  String get alert_time_suggest_duration {
    return Intl.message(
      'Please select an estimated time.',
      name: 'alert_time_suggest_duration',
      desc: '',
      args: [],
    );
  }

  /// `Please select a return warehouse`
  String get alert_choose_warehouse {
    return Intl.message(
      'Please select a return warehouse',
      name: 'alert_choose_warehouse',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for progressing`
  String get incident_status_wait {
    return Intl.message(
      'Waiting for progressing',
      name: 'incident_status_wait',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get incident_status_in_process {
    return Intl.message(
      'Processing',
      name: 'incident_status_in_process',
      desc: '',
      args: [],
    );
  }

  /// `Processed`
  String get incident_status_process_success {
    return Intl.message(
      'Processed',
      name: 'incident_status_process_success',
      desc: '',
      args: [],
    );
  }

  /// `Handling failed`
  String get incident_status_process_fail {
    return Intl.message(
      'Handling failed',
      name: 'incident_status_process_fail',
      desc: '',
      args: [],
    );
  }

  /// `Installation point`
  String get point_install {
    return Intl.message(
      'Installation point',
      name: 'point_install',
      desc: '',
      args: [],
    );
  }

  /// `Picking point`
  String get point_pickup {
    return Intl.message(
      'Picking point',
      name: 'point_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Warranty repair`
  String get warranty_repair {
    return Intl.message(
      'Warranty repair',
      name: 'warranty_repair',
      desc: '',
      args: [],
    );
  }

  /// `Warranty repair point`
  String get point_warranty_repair {
    return Intl.message(
      'Warranty repair point',
      name: 'point_warranty_repair',
      desc: '',
      args: [],
    );
  }

  /// `Collection`
  String get collection {
    return Intl.message(
      'Collection',
      name: 'collection',
      desc: '',
      args: [],
    );
  }

  /// `Store code`
  String get store_code {
    return Intl.message(
      'Store code',
      name: 'store_code',
      desc: '',
      args: [],
    );
  }

  /// `External code`
  String get externalCode {
    return Intl.message(
      'External code',
      name: 'externalCode',
      desc: '',
      args: [],
    );
  }

  /// `Number of SO`
  String get number_of_so {
    return Intl.message(
      'Number of SO',
      name: 'number_of_so',
      desc: '',
      args: [],
    );
  }

  /// `Group order list`
  String get grouped_order_list {
    return Intl.message(
      'Group order list',
      name: 'grouped_order_list',
      desc: '',
      args: [],
    );
  }

  /// `Group`
  String get group {
    return Intl.message(
      'Group',
      name: 'group',
      desc: '',
      args: [],
    );
  }

  /// `Package`
  String get package {
    return Intl.message(
      'Package',
      name: 'package',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order_single {
    return Intl.message(
      'Order',
      name: 'order_single',
      desc: '',
      args: [],
    );
  }

  /// `Call For`
  String get call_for {
    return Intl.message(
      'Call For',
      name: 'call_for',
      desc: '',
      args: [],
    );
  }

  /// `Call customers`
  String get call_customers {
    return Intl.message(
      'Call customers',
      name: 'call_customers',
      desc: '',
      args: [],
    );
  }

  /// `Call the operator`
  String get call_the_operator {
    return Intl.message(
      'Call the operator',
      name: 'call_the_operator',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get old_password {
    return Intl.message(
      'Old Password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Password`
  String get invalid_password {
    return Intl.message(
      'Invalid Password',
      name: 'invalid_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters and must have a number`
  String get minimum_password_invalid {
    return Intl.message(
      'Password must be at least 8 characters and must have a number',
      name: 'minimum_password_invalid',
      desc: '',
      args: [],
    );
  }

  /// `CHANGE PASSWORD`
  String get change_password_low {
    return Intl.message(
      'CHANGE PASSWORD',
      name: 'change_password_low',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number.`
  String get input_phone_number {
    return Intl.message(
      'Enter your phone number.',
      name: 'input_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continues {
    return Intl.message(
      'Continue',
      name: 'continues',
      desc: '',
      args: [],
    );
  }

  /// `Resent OTP`
  String get resent_otp {
    return Intl.message(
      'Resent OTP',
      name: 'resent_otp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_passwords {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_passwords',
      desc: '',
      args: [],
    );
  }

  /// `Passwords are not the same`
  String get passwords_are_not_the_same {
    return Intl.message(
      'Passwords are not the same',
      name: 'passwords_are_not_the_same',
      desc: '',
      args: [],
    );
  }

  /// `Create New Password`
  String get create_new_password {
    return Intl.message(
      'Create New Password',
      name: 'create_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password retrieval`
  String get password_retrieval {
    return Intl.message(
      'Password retrieval',
      name: 'password_retrieval',
      desc: '',
      args: [],
    );
  }

  /// `Code not received`
  String get code_not_received {
    return Intl.message(
      'Code not received',
      name: 'code_not_received',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verify_otp {
    return Intl.message(
      'Verify OTP',
      name: 'verify_otp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the phone number you used to register your account to reset your password.`
  String get re_enter_phone_to_take_password {
    return Intl.message(
      'Please enter the phone number you used to register your account to reset your password.',
      name: 're_enter_phone_to_take_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the confirmation code sent`
  String get please_enter_code_has_sent {
    return Intl.message(
      'Please enter the confirmation code sent',
      name: 'please_enter_code_has_sent',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message(
      'Request',
      name: 'request',
      desc: '',
      args: [],
    );
  }

  /// `Overheads Cost`
  String get overheads_cost {
    return Intl.message(
      'Overheads Cost',
      name: 'overheads_cost',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message(
      'Size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `Volume`
  String get volume {
    return Intl.message(
      'Volume',
      name: 'volume',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get paid {
    return Intl.message(
      'Paid',
      name: 'paid',
      desc: '',
      args: [],
    );
  }

  /// `Not paid`
  String get not_paid {
    return Intl.message(
      'Not paid',
      name: 'not_paid',
      desc: '',
      args: [],
    );
  }

  /// `Partial payment`
  String get partial_payment {
    return Intl.message(
      'Partial payment',
      name: 'partial_payment',
      desc: '',
      args: [],
    );
  }

  /// `Collected money`
  String get collected_money {
    return Intl.message(
      'Collected money',
      name: 'collected_money',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get return_order {
    return Intl.message(
      'Return',
      name: 'return_order',
      desc: '',
      args: [],
    );
  }

  /// `Problem`
  String get problem {
    return Intl.message(
      'Problem',
      name: 'problem',
      desc: '',
      args: [],
    );
  }

  /// `Installation Failed`
  String get installation_failed {
    return Intl.message(
      'Installation Failed',
      name: 'installation_failed',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get otp_code {
    return Intl.message(
      'OTP Code',
      name: 'otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with another form`
  String get sign_in_with_another_form {
    return Intl.message(
      'Sign in with another form',
      name: 'sign_in_with_another_form',
      desc: '',
      args: [],
    );
  }

  /// `Complete with Refund`
  String get complete_with_refund {
    return Intl.message(
      'Complete with Refund',
      name: 'complete_with_refund',
      desc: '',
      args: [],
    );
  }

  /// `No Orders`
  String get no_oder {
    return Intl.message(
      'No Orders',
      name: 'no_oder',
      desc: '',
      args: [],
    );
  }

  /// `You currently have no new orders`
  String get no_new_order {
    return Intl.message(
      'You currently have no new orders',
      name: 'no_new_order',
      desc: '',
      args: [],
    );
  }

  /// `Registration means`
  String get registration_means {
    return Intl.message(
      'Registration means',
      name: 'registration_means',
      desc: '',
      args: [],
    );
  }

  /// `Avatar`
  String get avatar {
    return Intl.message(
      'Avatar',
      name: 'avatar',
      desc: '',
      args: [],
    );
  }

  /// `Share vie Facebook`
  String get share_vie_facebook {
    return Intl.message(
      'Share vie Facebook',
      name: 'share_vie_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Share vie Zalo`
  String get share_vie_zalo {
    return Intl.message(
      'Share vie Zalo',
      name: 'share_vie_zalo',
      desc: '',
      args: [],
    );
  }

  /// `Share Code`
  String get share {
    return Intl.message(
      'Share Code',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Introducing partners to receive happy gifts`
  String get introducing_partners {
    return Intl.message(
      'Introducing partners to receive happy gifts',
      name: 'introducing_partners',
      desc: '',
      args: [],
    );
  }

  /// `Your Referral Code`
  String get your_referral_code {
    return Intl.message(
      'Your Referral Code',
      name: 'your_referral_code',
      desc: '',
      args: [],
    );
  }

  /// `Delivery successful`
  String get delivery_successful {
    return Intl.message(
      'Delivery successful',
      name: 'delivery_successful',
      desc: '',
      args: [],
    );
  }

  /// `Delivery failed`
  String get delivery_failed {
    return Intl.message(
      'Delivery failed',
      name: 'delivery_failed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number and password to login.`
  String get please_enter_phone_and_password {
    return Intl.message(
      'Please enter your phone number and password to login.',
      name: 'please_enter_phone_and_password',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
