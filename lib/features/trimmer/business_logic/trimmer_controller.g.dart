// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trimmer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trimmerControllerHash() => r'53cbd14119149699c8987fa5ff385627509263d3';

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

abstract class _$TrimmerController
    extends BuildlessAutoDisposeNotifier<TrimmerState> {
  late final String path;

  TrimmerState build(
    String path,
  );
}

/// See also [TrimmerController].
@ProviderFor(TrimmerController)
const trimmerControllerProvider = TrimmerControllerFamily();

/// See also [TrimmerController].
class TrimmerControllerFamily extends Family<TrimmerState> {
  /// See also [TrimmerController].
  const TrimmerControllerFamily();

  /// See also [TrimmerController].
  TrimmerControllerProvider call(
    String path,
  ) {
    return TrimmerControllerProvider(
      path,
    );
  }

  @override
  TrimmerControllerProvider getProviderOverride(
    covariant TrimmerControllerProvider provider,
  ) {
    return call(
      provider.path,
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
  String? get name => r'trimmerControllerProvider';
}

/// See also [TrimmerController].
class TrimmerControllerProvider
    extends AutoDisposeNotifierProviderImpl<TrimmerController, TrimmerState> {
  /// See also [TrimmerController].
  TrimmerControllerProvider(
    String path,
  ) : this._internal(
          () => TrimmerController()..path = path,
          from: trimmerControllerProvider,
          name: r'trimmerControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trimmerControllerHash,
          dependencies: TrimmerControllerFamily._dependencies,
          allTransitiveDependencies:
              TrimmerControllerFamily._allTransitiveDependencies,
          path: path,
        );

  TrimmerControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.path,
  }) : super.internal();

  final String path;

  @override
  TrimmerState runNotifierBuild(
    covariant TrimmerController notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(TrimmerController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TrimmerControllerProvider._internal(
        () => create()..path = path,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        path: path,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TrimmerController, TrimmerState>
      createElement() {
    return _TrimmerControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrimmerControllerProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TrimmerControllerRef on AutoDisposeNotifierProviderRef<TrimmerState> {
  /// The parameter `path` of this provider.
  String get path;
}

class _TrimmerControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TrimmerController, TrimmerState>
    with TrimmerControllerRef {
  _TrimmerControllerProviderElement(super.provider);

  @override
  String get path => (origin as TrimmerControllerProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
