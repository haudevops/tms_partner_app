import 'package:global_configuration/global_configuration.dart';
import 'package:tms_partner_app/utils/constants.dart';

GlobalConfiguration config = GlobalConfiguration();

final String baseUrl = config.getValue(Constants.BASE_URL);
final String wsUrl = config.getValue(Constants.WS_URL);
final String cloudUrl = config.getValue(Constants.CLOUD_URL);
final String cloudKey = config.getValue(Constants.CLOUD_KEY);
final String eftUrl = config.getValue(Constants.EFT_URL);
final String environment = config.getValue(Constants.ENVIRONMENT);
