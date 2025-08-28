import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dhanraj/provider/provider_settings.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';

import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_strings.dart';
import '../utils/app_widget.dart';
import 'exception_dialogs.dart';

class OtpService {
  SharedPreferences? sp;

  Future<Map<String, dynamic>?> get({
    required BuildContext context,
    required String endPoint,
    required bool isShowLoader,
  }) async {
    sp = await SharedPreferences.getInstance();

    if (isShowLoader) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }

    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint");

    print(url);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      }
      if (response.statusCode == 201) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isShowLoader) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );

        return null;
      } else if (response.statusCode == 401) {
        if (isShowLoader) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );
        Provider.of<ProviderSettings>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isShowLoader) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );
        return null;
      } else if (response.statusCode == 404) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );
        return null;
      } else if (response.statusCode == 403) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (context.mounted) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 503) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);

        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );
        return null;
      } else if (response.statusCode == 500) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );

        return null;
      } else if (response.statusCode == 504) {
        if (isShowLoader) {
          Navigator.pop(context);
        }

        ExceptionDialogs.networkDialog(
          context: context,
          message: "Internal server error.",
          onPressed: () {},
        );

        return null;
      }
    } on SocketException catch (e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }

      return null;
    } on HttpException catch (e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message ?? "",
          onPressed: () {},
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.toString(),
          onPressed: () {},
        );
      }
      return null;
    }
    return null;
  }
}