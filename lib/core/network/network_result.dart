import 'package:dartz/dartz.dart';

import 'models/network_failure.dart';

typedef NetworkResult<T> = Future<Either<NetworkFailure, T>>;