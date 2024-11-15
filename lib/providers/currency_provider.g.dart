// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currencyListHash() => r'afb423b5369d8981f115f44a75ceff3b103cfbad';

/// See also [CurrencyList].
@ProviderFor(CurrencyList)
final currencyListProvider = AutoDisposeAsyncNotifierProvider<CurrencyList,
    List<CurrencyViewModel>>.internal(
  CurrencyList.new,
  name: r'currencyListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currencyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrencyList = AutoDisposeAsyncNotifier<List<CurrencyViewModel>>;
String _$historicalCurrencyHash() =>
    r'04a32626ceb22529b4a22b169d37d392aab1fe41';

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

abstract class _$HistoricalCurrency
    extends BuildlessAutoDisposeAsyncNotifier<HistoricalCurrencyState> {
  late final String currencyCode;

  FutureOr<HistoricalCurrencyState> build(
    String currencyCode,
  );
}

/// See also [HistoricalCurrency].
@ProviderFor(HistoricalCurrency)
const historicalCurrencyProvider = HistoricalCurrencyFamily();

/// See also [HistoricalCurrency].
class HistoricalCurrencyFamily
    extends Family<AsyncValue<HistoricalCurrencyState>> {
  /// See also [HistoricalCurrency].
  const HistoricalCurrencyFamily();

  /// See also [HistoricalCurrency].
  HistoricalCurrencyProvider call(
    String currencyCode,
  ) {
    return HistoricalCurrencyProvider(
      currencyCode,
    );
  }

  @override
  HistoricalCurrencyProvider getProviderOverride(
    covariant HistoricalCurrencyProvider provider,
  ) {
    return call(
      provider.currencyCode,
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
  String? get name => r'historicalCurrencyProvider';
}

/// See also [HistoricalCurrency].
class HistoricalCurrencyProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HistoricalCurrency, HistoricalCurrencyState> {
  /// See also [HistoricalCurrency].
  HistoricalCurrencyProvider(
    String currencyCode,
  ) : this._internal(
          () => HistoricalCurrency()..currencyCode = currencyCode,
          from: historicalCurrencyProvider,
          name: r'historicalCurrencyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$historicalCurrencyHash,
          dependencies: HistoricalCurrencyFamily._dependencies,
          allTransitiveDependencies:
              HistoricalCurrencyFamily._allTransitiveDependencies,
          currencyCode: currencyCode,
        );

  HistoricalCurrencyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.currencyCode,
  }) : super.internal();

  final String currencyCode;

  @override
  FutureOr<HistoricalCurrencyState> runNotifierBuild(
    covariant HistoricalCurrency notifier,
  ) {
    return notifier.build(
      currencyCode,
    );
  }

  @override
  Override overrideWith(HistoricalCurrency Function() create) {
    return ProviderOverride(
      origin: this,
      override: HistoricalCurrencyProvider._internal(
        () => create()..currencyCode = currencyCode,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        currencyCode: currencyCode,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<HistoricalCurrency,
      HistoricalCurrencyState> createElement() {
    return _HistoricalCurrencyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoricalCurrencyProvider &&
        other.currencyCode == currencyCode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, currencyCode.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HistoricalCurrencyRef
    on AutoDisposeAsyncNotifierProviderRef<HistoricalCurrencyState> {
  /// The parameter `currencyCode` of this provider.
  String get currencyCode;
}

class _HistoricalCurrencyProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HistoricalCurrency,
        HistoricalCurrencyState> with HistoricalCurrencyRef {
  _HistoricalCurrencyProviderElement(super.provider);

  @override
  String get currencyCode =>
      (origin as HistoricalCurrencyProvider).currencyCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
