// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_conversion_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currencyConversionHash() =>
    r'ad85b71a3af74f5778e45e395ef28263571491df';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [currencyConversion].
@ProviderFor(currencyConversion)
const currencyConversionProvider = CurrencyConversionFamily();

/// See also [currencyConversion].
class CurrencyConversionFamily extends Family<AsyncValue<double>> {
  /// See also [currencyConversion].
  const CurrencyConversionFamily();

  /// See also [currencyConversion].
  CurrencyConversionProvider call(
    String currencyCode,
    double amount,
  ) {
    return CurrencyConversionProvider(
      currencyCode,
      amount,
    );
  }

  @override
  CurrencyConversionProvider getProviderOverride(
    covariant CurrencyConversionProvider provider,
  ) {
    return call(
      provider.currencyCode,
      provider.amount,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currencyConversionProvider';
}

/// See also [currencyConversion].
class CurrencyConversionProvider extends AutoDisposeFutureProvider<double> {
  /// See also [currencyConversion].
  CurrencyConversionProvider(
    String currencyCode,
    double amount,
  ) : this._internal(
          (ref) => currencyConversion(
            ref as CurrencyConversionRef,
            currencyCode,
            amount,
          ),
          from: currencyConversionProvider,
          name: r'currencyConversionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$currencyConversionHash,
          dependencies: CurrencyConversionFamily._dependencies,
          allTransitiveDependencies:
              CurrencyConversionFamily._allTransitiveDependencies,
          currencyCode: currencyCode,
          amount: amount,
        );

  CurrencyConversionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currencyCode,
    required this.amount,
  }) : super.internal();

  final String currencyCode;
  final double amount;

  @override
  Override overrideWith(
    FutureOr<double> Function(CurrencyConversionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrencyConversionProvider._internal(
        (ref) => create(ref as CurrencyConversionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currencyCode: currencyCode,
        amount: amount,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<double> createElement() {
    return _CurrencyConversionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrencyConversionProvider &&
        other.currencyCode == currencyCode &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currencyCode.hashCode);
    hash = _SystemHash.combine(hash, amount.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrencyConversionRef on AutoDisposeFutureProviderRef<double> {
  /// The parameter `currencyCode` of this provider.
  String get currencyCode;

  /// The parameter `amount` of this provider.
  double get amount;
}

class _CurrencyConversionProviderElement
    extends AutoDisposeFutureProviderElement<double>
    with CurrencyConversionRef {
  _CurrencyConversionProviderElement(super.provider);

  @override
  String get currencyCode =>
      (origin as CurrencyConversionProvider).currencyCode;
  @override
  double get amount => (origin as CurrencyConversionProvider).amount;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
