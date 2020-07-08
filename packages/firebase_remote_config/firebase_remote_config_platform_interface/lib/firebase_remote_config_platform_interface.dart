// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library firebase_remote_config_platform_interface;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart' show visibleForTesting;
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

part 'src/method_channel_firebase_remote_config.dart';
part 'src/types.dart';
part 'src/enums.dart';
part 'src/utils.dart';

/// The interface that implementations of `firebase_remote_config` must extend.
///
/// Platform implementations should extend this class rather than implement it
/// as `firebase_remote_config` does not consider newly added methods to be breaking
/// changes. Extending this class (using `extends`) ensures that the subclass
/// will get the default implementation, while platform implementations that
/// `implements` this interface will be broken by newly added
/// [FirebaseRemoteConfigPlatform] methods.
abstract class FirebaseRemoteConfigPlatform extends PlatformInterface {
  static final Object _token = Object();

  /// Constructs a FirebaseRemoteConfigPlatform
  FirebaseRemoteConfigPlatform() : super(token: _token);

  /// The default instance of [FirebaseRemoteConfigPlatform] to use.
  ///
  /// Platform-specific plugins should override this with their own class
  /// that extends [FirebaseRemoteConfigPlatform] when they register themselves.
  ///
  /// Defaults to [MethodChannelFirebaseRemoteConfig].
  static FirebaseRemoteConfigPlatform get instance => _instance;

  static FirebaseRemoteConfigPlatform _instance =
      MethodChannelFirebaseRemoteConfig();

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FirebaseRemoteConfigPlatform] when they register themselves.
  // TODO(amirh): Extract common platform interface logic.
  // https://github.com/flutter/flutter/issues/43368
  static set instance(FirebaseRemoteConfigPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Gets the instance of RemoteConfig for the default Firebase app.
  Future<Map<String, dynamic>> getRemoteConfigInstance() {
    throw UnimplementedError('getRemoteConfigInstance() is not implemented');
  }

  /// Set the configuration settings for the [RemoteConfig] instance.
  ///
  /// This can be used for enabling developer mode.
  Future<void> setConfigSettings(RemoteConfigSettings remoteConfigSettings) {
    throw UnimplementedError('setConfigSettings() is not implemented');
  }

  /// Fetches parameter values for your app.
  ///
  /// Parameter values may be from Default Config (local cache) or Remote
  /// Config if enough time has elapsed since parameter values were last
  /// fetched from the server. The default expiration time is 12 hours.
  /// Expiration must be defined in seconds.
  Future<Map<String, dynamic>> fetch(
      {Duration expiration = const Duration(hours: 12)}) {
    throw UnimplementedError('fetch() is not implemented');
  }

  /// Activates the fetched config, makes fetched key-values take effect.
  Future<bool> activateFetched() {
    throw UnimplementedError('activateFetched() is not implemented');
  }

  /// Sets the default config.
  ///
  /// Default config parameters should be set then when changes are needed the
  /// parameters should be updated in the Firebase console.
  Future<void> setDefaults(Map<String, dynamic> defaults) {
    throw UnimplementedError('setDefaults() is not implemented');
  }

  /// Gets the value corresponding to the [key] as a String.
  ///
  /// If there is no parameter with corresponding [key] then the default
  /// String value is returned.
  String getString(String key) {
    throw UnimplementedError('getString() is not implemented');
  }

  /// Gets the value corresponding to the [key] as an int.
  ///
  /// If there is no parameter with corresponding [key] then the default
  /// int value is returned.
  int getInt(String key) {
    throw UnimplementedError('getInt() is not implemented');
  }

  /// Gets the value corresponding to the [key] as a double.
  ///
  /// If there is no parameter with corresponding [key] then the default double
  /// value is returned.
  double getDouble(String key) {
    throw UnimplementedError('getDouble() is not implemented');
  }

  /// Gets the value corresponding to the [key] as a bool.
  ///
  /// If there is no parameter with corresponding [key] then the default bool
  /// value is returned.
  bool getBool(String key) {
    throw UnimplementedError('getBool() is not implemented');
  }

  /// Gets the [RemoteConfigValue] corresponding to the [key].
  ///
  /// If there is no parameter with corresponding key then a [RemoteConfigValue]
  /// with a null value and static source is returned.
  RemoteConfigValue getValue(String key) {
    throw UnimplementedError('getValue() is not implemented');
  }

  /// Gets all [RemoteConfigValue].
  ///
  /// This includes all remote and default values
  Map<String, RemoteConfigValue> getAll() {
    throw UnimplementedError('getAll() is not implemented');
  }
}

/// The default String value, returned if no value exists for, and no default
/// value has been set for, a parameter
const String defaultValueForString = '';

/// The default int value, returned if no value exists for, and no default value
/// has been set for, a parameter
const int defaultValueForInt = 0;

/// The default double value, returned if no value exists for, and no default
/// value has been set for, a parameter
const double defaultValueForDouble = 0.0;

/// The default bool value, returned if no value exists for, and no default
/// value has been set for, a parameter
const bool defaultValueForBool = false;
