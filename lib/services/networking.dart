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

import '../utils/app_widget.dart';

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

    if (isLoaderShow && context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }
    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint");


    print(url);
    print(mapData);
    print(sp?.getString(PreferenceKey.token));

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

      print(response.body);

      if (response.statusCode == 200) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      }
      if (response.statusCode == 201) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        print(data);
        if (isLoaderShow && context.mounted) {
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBar(context, data["message"] ?? "", AppColors.red, Colors.white);
          }
        }

        return null;
      } else if (response.statusCode == 401) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          }
        }

        return null;
      } else if (response.statusCode == 422) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          }
        }
        return null;
      } else if (response.statusCode == 404) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
          }
        }
        return null;
      } else if (response.statusCode == 403) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return HttpErrorDialog(
                msg: "Permission have changed, Please contact to HR Manager.",
                onTap: () {
                  return null;
                },
              );
            },
          );
        }
        return null;
      } else if (response.statusCode == 503) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, "Server is under maintenance,Try again later.", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBar(context, "Server is under maintenance,Try again later.", AppColors.red, Colors.white);
          }
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
          if (fromBottomSheet) {
            AppWidget().snackBarTop(context, "Service is unavailable,Try again later.", AppColors.red, Colors.white);
          } else {
            AppWidget().snackBar(context, "Service is unavailable,Try again later.", AppColors.red, Colors.white);
          }
        }

        return null;
      }
    } on SocketException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on HttpException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isLoaderShow && context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: "$e",
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
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

    if (isLoaderShow && context.mounted) {
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

      print(response.body);
      if (response.statusCode == 200) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      }
      if (response.statusCode == 201) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 400) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }

        return null;
      } else if (response.statusCode == 401) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }

        return null;
      } else if (response.statusCode == 422) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 404) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (isLoaderShow && context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 403) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
        }

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return HttpErrorDialog(
                msg: "Permission have changed, Please contact to HR Manager.",
                onTap: () {
                  return null;
                },
              );
            },
          );
        }
        return null;
      } else if (response.statusCode == 503) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
          AppWidget().snackBar(context, "Server is under maintenance,Try again later.", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isLoaderShow && context.mounted) {
          Navigator.pop(context);
          AppWidget().snackBar(context, "Service is unavailable,Try again later.", AppColors.red, Colors.white);
        }

        return null;
      }
    } on SocketException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on HttpException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on FormatException catch (e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (isLoaderShow && context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (isLoaderShow && context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: "$e",
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
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

    if (isShowLoader && context.mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AppWidget().loader(context);
        },
      );
    }

    final url = Uri.parse("${AppApiEndPoint.baseUrl}$endPoint");

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
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);

        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }

        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 404) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);

        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 403) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return HttpErrorDialog(
                msg: "Permission have changed, Please contact to HR Manager.",
                onTap: () {
                  return null;
                },
              );
            },
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          AppWidget().snackBar(context, "Sever is under maintenance,Try again later.", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 503) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          AppWidget().snackBar(context, "Service is unavailable,Try again later.", AppColors.red, Colors.white);
        }
        return null;
      }
    } on SocketException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }

      return null;
    } on HttpException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on FormatException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: "$e",
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
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

    if (isShowLoader && context.mounted) {
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
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);

        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }

        Provider.of<ProviderDashboard>(context, listen: false).logOut(context);

        return null;
      } else if (response.statusCode == 422) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        var data = json.decode(response.body);
        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 404) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }

        var data = json.decode(response.body);

        if (context.mounted) {
          AppWidget().snackBarTop(context, data["message"] ?? "", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 403) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }

        if (context.mounted) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return HttpErrorDialog(
                msg: "Permission have changed, Please contact to HR Manager.",
                onTap: () {
                  return null;
                },
              );
            },
          );
        }
        return null;
      } else if (response.statusCode == 500) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          AppWidget().snackBar(context, "Sever is under maintenance,Try again later.", AppColors.red, Colors.white);
        }
        return null;
      } else if (response.statusCode == 503) {
        if (isShowLoader && context.mounted) {
          Navigator.pop(context);
        }
        if (context.mounted) {
          AppWidget().snackBar(context, "Service is unavailable,Try again later.", AppColors.red, Colors.white);
        }
        return null;
      }
    } on SocketException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }

      return null;
    } on HttpException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on FormatException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on TimeoutException catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: e.message,
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    } on Exception catch (_, e) {
      if (context.mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return HttpErrorDialog(
              msg: "$e",
              onTap: () {
                Navigator.pop(context);
                return null;
              },
            );
          },
        );
      }
      return null;
    }
    return null;
  }
}
