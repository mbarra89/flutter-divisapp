// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$historicalSeriesHash() => r'0f3236c532291dceebd39130db367533e3b5e208';

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

abstract class _$HistoricalSeries
    extends BuildlessAutoDisposeAsyncNotifier<HistoricalSeriesState> {
  late final String currencyCode;

  FutureOr<HistoricalSeriesState> build(
    String currencyCode,
  );
}

/// See also [HistoricalSeries].
@ProviderFor(HistoricalSeries)
const historicalSeriesProvider = HistoricalSeriesFamily();

/// See also [HistoricalSeries].
class HistoricalSeriesFamily extends Family<AsyncValue<HistoricalSeriesState>> {
  /// See also [HistoricalSeries].
  const HistoricalSeriesFamily();

  /// See also [HistoricalSeries].
  HistoricalSeriesProvider call(
    String currencyCode,
  ) {
    return HistoricalSeriesProvider(
      currencyCode,
    );
  }

  @override
  HistoricalSeriesProvider getProviderOverride(
    covariant HistoricalSeriesProvider provider,
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
  String? get name => r'historicalSeriesProvider';
}

/// See also [HistoricalSeries].
class HistoricalSeriesProvider extends AutoDisposeAsyncNotifierProviderImpl<
    HistoricalSeries, HistoricalSeriesState> {
  /// See also [HistoricalSeries].
  HistoricalSeriesProvider(
    String currencyCode,
  ) : this._internal(
          () => HistoricalSeries()..currencyCode = currencyCode,
          from: historicalSeriesProvider,
          name: r'historicalSeriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$historicalSeriesHash,
          dependencies: HistoricalSeriesFamily._dependencies,
          allTransitiveDependencies:
              HistoricalSeriesFamily._allTransitiveDependencies,
          currencyCode: currencyCode,
        );

  HistoricalSeriesProvider._internal(
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
  FutureOr<HistoricalSeriesState> runNotifierBuild(
    covariant HistoricalSeries notifier,
  ) {
    return notifier.build(
      currencyCode,
    );
  }

  @override
  Override overrideWith(HistoricalSeries Function() create) {
    return ProviderOverride(
      origin: this,
      override: HistoricalSeriesProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<HistoricalSeries,
      HistoricalSeriesState> createElement() {
    return _HistoricalSeriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HistoricalSeriesProvider &&
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
mixin HistoricalSeriesRef
    on AutoDisposeAsyncNotifierProviderRef<HistoricalSeriesState> {
  /// The parameter `currencyCode` of this provider.
  String get currencyCode;
}

class _HistoricalSeriesProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<HistoricalSeries,
        HistoricalSeriesState> with HistoricalSeriesRef {
  _HistoricalSeriesProviderElement(super.provider);

  @override
  String get currencyCode => (origin as HistoricalSeriesProvider).currencyCode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
