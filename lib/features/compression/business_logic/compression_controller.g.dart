// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compression_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$compressionControllerHash() =>
    r'2cee894c785adecac620d774797b3e380453ecae';

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

abstract class _$CompressionController
    extends BuildlessAutoDisposeNotifier<CompressionState> {
  late final String path;

  CompressionState build(
    String path,
  );
}

/// See also [CompressionController].
@ProviderFor(CompressionController)
const compressionControllerProvider = CompressionControllerFamily();

/// See also [CompressionController].
class CompressionControllerFamily extends Family<CompressionState> {
  /// See also [CompressionController].
  const CompressionControllerFamily();

  /// See also [CompressionController].
  CompressionControllerProvider call(
    String path,
  ) {
    return CompressionControllerProvider(
      path,
    );
  }

  @override
  CompressionControllerProvider getProviderOverride(
    covariant CompressionControllerProvider provider,
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
  String? get name => r'compressionControllerProvider';
}

/// See also [CompressionController].
class CompressionControllerProvider extends AutoDisposeNotifierProviderImpl<
    CompressionController, CompressionState> {
  /// See also [CompressionController].
  CompressionControllerProvider(
    String path,
  ) : this._internal(
          () => CompressionController()..path = path,
          from: compressionControllerProvider,
          name: r'compressionControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$compressionControllerHash,
          dependencies: CompressionControllerFamily._dependencies,
          allTransitiveDependencies:
              CompressionControllerFamily._allTransitiveDependencies,
          path: path,
        );

  CompressionControllerProvider._internal(
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
  CompressionState runNotifierBuild(
    covariant CompressionController notifier,
  ) {
    return notifier.build(
      path,
    );
  }

  @override
  Override overrideWith(CompressionController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CompressionControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<CompressionController, CompressionState>
      createElement() {
    return _CompressionControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CompressionControllerProvider && other.path == path;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, path.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CompressionControllerRef
    on AutoDisposeNotifierProviderRef<CompressionState> {
  /// The parameter `path` of this provider.
  String get path;
}

class _CompressionControllerProviderElement
    extends AutoDisposeNotifierProviderElement<CompressionController,
        CompressionState> with CompressionControllerRef {
  _CompressionControllerProviderElement(super.provider);

  @override
  String get path => (origin as CompressionControllerProvider).path;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
