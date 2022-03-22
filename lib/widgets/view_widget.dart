import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/models/enums.dart';
import 'package:test_project/widgets/pages/feed_widget.dart';
import 'package:test_project/widgets/pages/loading_widget.dart';
import 'package:test_project/widgets/pages/login_widget.dart';

class ViewWidget extends StatefulWidget {
  const ViewWidget({Key? key}) : super(key: key);

  @override
  State<ViewWidget> createState() => _ViewWidgetState();
}

class _ViewWidgetState extends State<ViewWidget> {
  late Widget _currentWidget;
  late String _userToken = '';
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late bool _isConnected = true;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none && _isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Connection Lost...',
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.black.withOpacity(0.4),
          duration: const Duration(seconds: 2),
        ),
      );

      _isConnected = false;
    } else {
      if (result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi && !_isConnected) {
        _isConnected = true;
      }
    }

    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    _setCurrentView(Views.login);

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  void _setUserToken(String token) {
    _userToken = token;
  }

  void _setCurrentView(Views view) {
    Widget _selectedWidget;

    switch (view) {
      case Views.feed:
        _selectedWidget = FeedWidget(
          userToken: _userToken,
          onNavigatePages: _setCurrentView,
        );
        break;
      case Views.login:
        _selectedWidget = LoginWidget(
          onNavigatePages: _setCurrentView,
          onTokenAcquired: _setUserToken,
        );
        break;
      case Views.loading:
        _selectedWidget = const LoadingWidget();
        break;
      default:
        _selectedWidget = LoginWidget(
          onNavigatePages: _setCurrentView,
          onTokenAcquired: _setUserToken,
        );
        break;
    }

    setState(() {
      _currentWidget = _selectedWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentWidget,
    );
  }
}
