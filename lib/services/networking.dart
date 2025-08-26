import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dhanraj/pages/dailogs/http_error_dialog.dart';
import 'package:dhanraj/provider/provider_dashboard.dart';
import 'package:dhanraj/utils/app_api_end_point.dart';
import 'package:dhanraj/utils/app_colors.dart';
import 'package:dhanraj/utils/preference_key.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_strings.dart';
import '../utils/app_widget.dart';
import 'exception_dialogs.dart';

mixin class Networking {
  SharedPreferences? sp;

  /// POST METHOD
  Future<Map<String, dynamic>?> post({
    required BuildContext context,
    required Map<String, dynamic> mapData,
    required String endPoint,
    required bool isLoaderShow,
    required bool fromBottomSheet,
  }) async {
    sp = await SharedPreferences.getInstance();

    if (isLoaderShow) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }
    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint");

    print(sp?.getString(PreferenceKey.token));
    print(url);

    try {
      print("Nikesh");

      final response = await http.post(
        url,
        body: jsonEncode(mapData),
        headers: {
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 201) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);

        print(data);

        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );

        return null;
      } else if (response.statusCode == 401) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );

        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isLoaderShow) {
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
        if (isLoaderShow) {
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
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );

        return null;
      } else if (response.statusCode == 503) {
        if (isLoaderShow) {
          var data = json.decode(response.body);
          Navigator.pop(context);
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isLoaderShow) {
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
        if (isLoaderShow) {
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
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on HttpException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isLoaderShow) {
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message ?? "",
          onPressed: () {},
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isLoaderShow) {
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

  Future<Map<String, dynamic>?> postParams({
    required BuildContext context,
    required Map<String, dynamic> mapData,
    required String endPoint,
    required bool isLoaderShow,
    required String params,
    required bool fromBottomSheet,
  }) async {
    sp = await SharedPreferences.getInstance();

    if (isLoaderShow) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }
    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint$params");

    try {
      final response = await http.post(
        url,
        body: jsonEncode(mapData),
        headers: {
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 201) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }

        return null;
      } else if (response.statusCode == 401) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);

        if (isLoaderShow) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 404) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (isLoaderShow) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 403) {
        if (isLoaderShow) {
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
        if (isLoaderShow) {
          var data = json.decode(response.body);
          Navigator.pop(context);
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isLoaderShow) {
          var data = json.decode(response.body);
          Navigator.pop(context);
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }

        return null;
      } else if (response.statusCode == 504) {
        if (isLoaderShow) {
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
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on HttpException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isLoaderShow) {
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message ?? "",
          onPressed: () {},
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isLoaderShow) {
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

  /// POST METHOD
  Future<Map<String, dynamic>?> delete({
    required BuildContext context,
    required String endPoint,
    required String id,
    required bool isLoaderShow,
  }) async {
    sp = await SharedPreferences.getInstance();

    if (isLoaderShow) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }
    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint/$id");

    print(url);
    print("Bearer ${sp?.getString(PreferenceKey.token)}");

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      }
      if (response.statusCode == 201) {
        if (isLoaderShow) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isLoaderShow) {
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
        if (isLoaderShow) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        ExceptionDialogs.networkDialog(
          context: context,
          message: data["message"] ?? "",
          onPressed: () {},
        );
        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isLoaderShow) {
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
        if (isLoaderShow) {
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
        if (isLoaderShow) {
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
        if (isLoaderShow) {
          var data = json.decode(response.body);
          Navigator.pop(context);

          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isLoaderShow) {
          var data = json.decode(response.body);
          Navigator.pop(context);
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }

        return null;
      } else if (response.statusCode == 504) {
        if (isLoaderShow) {
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
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on HttpException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isLoaderShow) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message,
          onPressed: () {},
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isLoaderShow) {
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.message ?? "",
          onPressed: () {},
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isLoaderShow) {
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

  /// POST with MultiPart

  /// GET METHOD
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
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
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
        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

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

  Future<Map<String, dynamic>?> getWithParams({
    required BuildContext context,
    required String endPoint,
    required String params,
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

    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint$params");

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
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
        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

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
          var data = json.decode(response.body);
          Navigator.pop(context);
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }

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
    } on Exception catch (e) {
      if (isShowLoader) {
        Navigator.pop(context);
        ExceptionDialogs.networkDialog(
          context: context,
          message: e.toString() ?? "",
          onPressed: () {},
        );
      }
      return null;
    }
    return null;
  }

  Future<Map<String, dynamic>?> put({
    required BuildContext context,
    required String endPoint,
    required Map<String, dynamic> mapData,
    required String params,
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

    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint/$params");

    try {
      final response = await http.put(
        url,
        body: jsonEncode(mapData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${sp?.getString(PreferenceKey.token)}",
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        if (isShowLoader) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
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

        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

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
        var data = json.decode(response.body);
        if (isShowLoader) {
          Navigator.pop(context);
        }

        if (context.mounted) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        var data = json.decode(response.body);
        if (isShowLoader) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
        return null;
      } else if (response.statusCode == 503) {
        var data = json.decode(response.body);
        if (isShowLoader) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          ExceptionDialogs.networkDialog(
            context: context,
            message: data["message"] ?? "",
            onPressed: () {},
          );
        }
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
