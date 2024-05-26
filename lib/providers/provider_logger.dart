import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    super.didUpdateProvider(provider, previousValue, newValue, container);
    debugPrint(
        'PROVIDER UPDATE: name: ${provider.name ?? provider.runtimeType.toString()}, [previousValue: $previousValue, newValue: $newValue]');
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    super.didDisposeProvider(provider, container);
    debugPrint(
        'PROVIDER DISPOSE: name: ${provider.name ?? provider.runtimeType.toString()}');
  }

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    super.didAddProvider(provider, value, container);
    debugPrint(
        'PROVIDER ADDED: name: ${provider.name ?? provider.runtimeType.toString()}, [value: $value]');
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    super.providerDidFail(provider, error, stackTrace, container);
    debugPrint(
        'PROVIDER FAILED: name: ${provider.name ?? provider.runtimeType.toString()}, [error: $error, stackTrace: $stackTrace]');
  }
}
