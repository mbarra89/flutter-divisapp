// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'economic_indicators_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$economicIndicatorsDatabaseHash() =>
    r'2a333a35a453dd15a590ed22fce5a380bcd26006';

/// See also [economicIndicatorsDatabase].
@ProviderFor(economicIndicatorsDatabase)
final economicIndicatorsDatabaseProvider =
    AutoDisposeProvider<EconomicIndicatorsDatabase>.internal(
  economicIndicatorsDatabase,
  name: r'economicIndicatorsDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$economicIndicatorsDatabaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EconomicIndicatorsDatabaseRef
    = AutoDisposeProviderRef<EconomicIndicatorsDatabase>;
String _$initializeEconomicIndicatorsHash() =>
    r'ce51d5a349315f1cecaf1d66bb8be2d519e5f181';

/// See also [initializeEconomicIndicators].
@ProviderFor(initializeEconomicIndicators)
final initializeEconomicIndicatorsProvider =
    AutoDisposeFutureProvider<void>.internal(
  initializeEconomicIndicators,
  name: r'initializeEconomicIndicatorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initializeEconomicIndicatorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitializeEconomicIndicatorsRef = AutoDisposeFutureProviderRef<void>;
String _$economicIndicatorsHash() =>
    r'7e43acd497111d77ad8bf6aa69658d4967357616';

/// See also [economicIndicators].
@ProviderFor(economicIndicators)
final economicIndicatorsProvider =
    AutoDisposeFutureProvider<List<EconomicIndicatorModel>>.internal(
  economicIndicators,
  name: r'economicIndicatorsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$economicIndicatorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EconomicIndicatorsRef
    = AutoDisposeFutureProviderRef<List<EconomicIndicatorModel>>;
String _$economicIndicatorByCodigoHash() =>
    r'd676ae793a7fc7ea501e94f6fab154a4a56d31d6';

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

/// See also [economicIndicatorByCodigo].
@ProviderFor(economicIndicatorByCodigo)
const economicIndicatorByCodigoProvider = EconomicIndicatorByCodigoFamily();

/// See also [economicIndicatorByCodigo].
class EconomicIndicatorByCodigoFamily
    extends Family<AsyncValue<EconomicIndicatorModel?>> {
  /// See also [economicIndicatorByCodigo].
  const EconomicIndicatorByCodigoFamily();

  /// See also [economicIndicatorByCodigo].
  EconomicIndicatorByCodigoProvider call(
    String codigo,
  ) {
    return EconomicIndicatorByCodigoProvider(
      codigo,
    );
  }

  @override
  EconomicIndicatorByCodigoProvider getProviderOverride(
    covariant EconomicIndicatorByCodigoProvider provider,
  ) {
    return call(
      provider.codigo,
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
  String? get name => r'economicIndicatorByCodigoProvider';
}

/// See also [economicIndicatorByCodigo].
class EconomicIndicatorByCodigoProvider
    extends AutoDisposeFutureProvider<EconomicIndicatorModel?> {
  /// See also [economicIndicatorByCodigo].
  EconomicIndicatorByCodigoProvider(
    String codigo,
  ) : this._internal(
          (ref) => economicIndicatorByCodigo(
            ref as EconomicIndicatorByCodigoRef,
            codigo,
          ),
          from: economicIndicatorByCodigoProvider,
          name: r'economicIndicatorByCodigoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$economicIndicatorByCodigoHash,
          dependencies: EconomicIndicatorByCodigoFamily._dependencies,
          allTransitiveDependencies:
              EconomicIndicatorByCodigoFamily._allTransitiveDependencies,
          codigo: codigo,
        );

  EconomicIndicatorByCodigoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.codigo,
  }) : super.internal();

  final String codigo;

  @override
  Override overrideWith(
    FutureOr<EconomicIndicatorModel?> Function(
            EconomicIndicatorByCodigoRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EconomicIndicatorByCodigoProvider._internal(
        (ref) => create(ref as EconomicIndicatorByCodigoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        codigo: codigo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<EconomicIndicatorModel?> createElement() {
    return _EconomicIndicatorByCodigoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EconomicIndicatorByCodigoProvider && other.codigo == codigo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, codigo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EconomicIndicatorByCodigoRef
    on AutoDisposeFutureProviderRef<EconomicIndicatorModel?> {
  /// The parameter `codigo` of this provider.
  String get codigo;
}

class _EconomicIndicatorByCodigoProviderElement
    extends AutoDisposeFutureProviderElement<EconomicIndicatorModel?>
    with EconomicIndicatorByCodigoRef {
  _EconomicIndicatorByCodigoProviderElement(super.provider);

  @override
  String get codigo => (origin as EconomicIndicatorByCodigoProvider).codigo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
