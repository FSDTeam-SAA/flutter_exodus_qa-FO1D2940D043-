// lib/core/network/extensions/either_extensions.dart

import 'package:dartz/dartz.dart';
import '../models/network_failure.dart';

extension EitherExtensions<T> on Either<NetworkFailure, T> {
  /// Check if the result is a success
  bool get isSuccess => isRight();
  
  /// Check if the result is a failure
  bool get isFailure => isLeft();
  
  /// Get the data if success, null if failure
  T? get dataOrNull => fold((_) => null, (data) => data);
  
  /// Get the failure if failure, null if success
  NetworkFailure? get failureOrNull => fold((failure) => failure, (_) => null);
  
  /// Get the error message
  String get errorMessage => fold(
    (failure) => failure.message,
    (_) => '',
  );
  
  /// Handle the result with callbacks
  void handle({
    required void Function(T data) onSuccess,
    required void Function(NetworkFailure failure) onFailure,
  }) {
    fold(onFailure, onSuccess);
  }
  
  /// Handle the result with callbacks (alternative syntax)
  void when({
    required void Function(T data) success,
    required void Function(NetworkFailure failure) failure,
  }) {
    fold(failure, success);
  }
  
  /// Transform the success value
  Either<NetworkFailure, R> mapSuccess<R>(R Function(T) transform) {
    return map(transform);
  }
  
  /// Transform the failure value
  Either<F, T> mapFailure<F>(F Function(NetworkFailure) transform) {
    return leftMap(transform);
  }
  
  /// Chain another Either operation
  Either<NetworkFailure, R> flatMap<R>(
    Either<NetworkFailure, R> Function(T) transform,
  ) {
    return fold(
      (failure) => Left(failure),
      (data) => transform(data),
    );
  }
  
  /// Convert to Future for async operations
  Future<Either<NetworkFailure, R>> flatMapAsync<R>(
    Future<Either<NetworkFailure, R>> Function(T) transform,
  ) async {
    return fold(
      (failure) => Left(failure),
      (data) => transform(data),
    );
  }
}

extension FutureEitherExtensions<T> on Future<Either<NetworkFailure, T>> {
  /// Handle async Either results
  Future<void> handleAsync({
    required void Function(T data) onSuccess,
    required void Function(NetworkFailure failure) onFailure,
  }) async {
    final result = await this;
    result.handle(onSuccess: onSuccess, onFailure: onFailure);
  }
  
  /// Transform async Either results
  Future<Either<NetworkFailure, R>> mapAsync<R>(
    R Function(T) transform,
  ) async {
    final result = await this;
    return result.map(transform);
  }
  
  /// Chain async Either operations
  Future<Either<NetworkFailure, R>> flatMapAsync<R>(
    Future<Either<NetworkFailure, R>> Function(T) transform,
  ) async {
    final result = await this;
    return result.fold(
      (failure) => Left(failure),
      (data) => transform(data),
    );
  }
}
