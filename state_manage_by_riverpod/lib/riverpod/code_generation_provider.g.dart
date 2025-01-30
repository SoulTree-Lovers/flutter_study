// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gStateHash() => r'9cead170c947e368cb0568a7d4e21f6a00c8ef29';

/// See also [gState].
@ProviderFor(gState)
final gStateProvider = AutoDisposeProvider<String>.internal(
  gState,
  name: r'gStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GStateRef = AutoDisposeProviderRef<String>;
String _$gStateFutureHash() => r'60bcec0c5c965b0d1fbcc1909268c09f6695357c';

/// See also [gStateFuture].
@ProviderFor(gStateFuture)
final gStateFutureProvider = AutoDisposeFutureProvider<int>.internal(
  gStateFuture,
  name: r'gStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gStateFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GStateFutureRef = AutoDisposeFutureProviderRef<int>;
String _$gStateFuture2Hash() => r'484054e1f9bdaf004b42e2ca5d5573adf30e1486';

/// See also [gStateFuture2].
@ProviderFor(gStateFuture2)
final gStateFuture2Provider = FutureProvider<int>.internal(
  gStateFuture2,
  name: r'gStateFuture2Provider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gStateFuture2Hash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GStateFuture2Ref = FutureProviderRef<int>;
String _$gStateMultiplyHash() => r'ec5a8efb6ba3e90e29f7a0722867976890c2a634';

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

/// See also [gStateMultiply].
@ProviderFor(gStateMultiply)
const gStateMultiplyProvider = GStateMultiplyFamily();

/// See also [gStateMultiply].
class GStateMultiplyFamily extends Family<int> {
  /// See also [gStateMultiply].
  const GStateMultiplyFamily();

  /// See also [gStateMultiply].
  GStateMultiplyProvider call({
    required int number1,
    required int number2,
  }) {
    return GStateMultiplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  GStateMultiplyProvider getProviderOverride(
    covariant GStateMultiplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
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
  String? get name => r'gStateMultiplyProvider';
}

/// See also [gStateMultiply].
class GStateMultiplyProvider extends AutoDisposeProvider<int> {
  /// See also [gStateMultiply].
  GStateMultiplyProvider({
    required int number1,
    required int number2,
  }) : this._internal(
          (ref) => gStateMultiply(
            ref as GStateMultiplyRef,
            number1: number1,
            number2: number2,
          ),
          from: gStateMultiplyProvider,
          name: r'gStateMultiplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$gStateMultiplyHash,
          dependencies: GStateMultiplyFamily._dependencies,
          allTransitiveDependencies:
              GStateMultiplyFamily._allTransitiveDependencies,
          number1: number1,
          number2: number2,
        );

  GStateMultiplyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number1,
    required this.number2,
  }) : super.internal();

  final int number1;
  final int number2;

  @override
  Override overrideWith(
    int Function(GStateMultiplyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GStateMultiplyProvider._internal(
        (ref) => create(ref as GStateMultiplyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number1: number1,
        number2: number2,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _GStateMultiplyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GStateMultiplyProvider &&
        other.number1 == number1 &&
        other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GStateMultiplyRef on AutoDisposeProviderRef<int> {
  /// The parameter `number1` of this provider.
  int get number1;

  /// The parameter `number2` of this provider.
  int get number2;
}

class _GStateMultiplyProviderElement extends AutoDisposeProviderElement<int>
    with GStateMultiplyRef {
  _GStateMultiplyProviderElement(super.provider);

  @override
  int get number1 => (origin as GStateMultiplyProvider).number1;
  @override
  int get number2 => (origin as GStateMultiplyProvider).number2;
}

String _$delayedMultiplyHash() => r'74932b7e8b10bba0bd5b394d3942592dc9c9e414';

/// See also [delayedMultiply].
@ProviderFor(delayedMultiply)
const delayedMultiplyProvider = DelayedMultiplyFamily();

/// See also [delayedMultiply].
class DelayedMultiplyFamily extends Family<AsyncValue<int>> {
  /// See also [delayedMultiply].
  const DelayedMultiplyFamily();

  /// See also [delayedMultiply].
  DelayedMultiplyProvider call({
    required int number1,
    required int number2,
  }) {
    return DelayedMultiplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  DelayedMultiplyProvider getProviderOverride(
    covariant DelayedMultiplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
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
  String? get name => r'delayedMultiplyProvider';
}

/// See also [delayedMultiply].
class DelayedMultiplyProvider extends AutoDisposeFutureProvider<int> {
  /// See also [delayedMultiply].
  DelayedMultiplyProvider({
    required int number1,
    required int number2,
  }) : this._internal(
          (ref) => delayedMultiply(
            ref as DelayedMultiplyRef,
            number1: number1,
            number2: number2,
          ),
          from: delayedMultiplyProvider,
          name: r'delayedMultiplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$delayedMultiplyHash,
          dependencies: DelayedMultiplyFamily._dependencies,
          allTransitiveDependencies:
              DelayedMultiplyFamily._allTransitiveDependencies,
          number1: number1,
          number2: number2,
        );

  DelayedMultiplyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number1,
    required this.number2,
  }) : super.internal();

  final int number1;
  final int number2;

  @override
  Override overrideWith(
    FutureOr<int> Function(DelayedMultiplyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DelayedMultiplyProvider._internal(
        (ref) => create(ref as DelayedMultiplyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number1: number1,
        number2: number2,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _DelayedMultiplyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DelayedMultiplyProvider &&
        other.number1 == number1 &&
        other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DelayedMultiplyRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `number1` of this provider.
  int get number1;

  /// The parameter `number2` of this provider.
  int get number2;
}

class _DelayedMultiplyProviderElement
    extends AutoDisposeFutureProviderElement<int> with DelayedMultiplyRef {
  _DelayedMultiplyProviderElement(super.provider);

  @override
  int get number1 => (origin as DelayedMultiplyProvider).number1;
  @override
  int get number2 => (origin as DelayedMultiplyProvider).number2;
}

String _$gStateNotifierHash() => r'f5d3562260bad49518ffe5b82e60b7cc1b8655f2';

/// See also [GStateNotifier].
@ProviderFor(GStateNotifier)
final gStateNotifierProvider =
    AutoDisposeNotifierProvider<GStateNotifier, int>.internal(
  GStateNotifier.new,
  name: r'gStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GStateNotifier = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
