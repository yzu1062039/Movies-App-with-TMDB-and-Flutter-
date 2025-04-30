import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_tmdb/core/exceptions/network/network_exception.dart';
import 'package:movie_tmdb/domain/entities/export_entities.dart';
import 'package:movie_tmdb/domain/usecases/export_usecases.dart';
import 'package:movie_tmdb/presentation/bloc/actor/export_actor_cubits.dart';

import '../../../_utils/mocks/mocks.mocks.dart';

void main() {
  late final ActorUsecases mockActorUsecases;

  late final ActorDetailEntity tActorDetailEntity;

  setUpAll(() {
    mockActorUsecases = MockActorUsecases();

    tActorDetailEntity = const ActorDetailEntity(
      id: 1,
      name: 'name',
      biography: 'biography',
      birthday: 'birthday',
      deathday: 'deathday',
      placeOfBirth: 'placeOfBirth',
      profilePath: 'profilePath',
    );
  });

  blocTest<GetActorDetailCubit, GetActorDetailState>(
    'should emit [GetActorDetailLoading, GetActorDetailLoaded] when success',
    build: () {
      provideDummy<Either<NetworkException, ActorDetailEntity>>(
        Right(tActorDetailEntity),
      );

      when(
        mockActorUsecases.getActorDetail(actorId: '1'),
      ).thenAnswer((_) async => Right(tActorDetailEntity));

      return GetActorDetailCubit(mockActorUsecases);
    },
    act: (bloc) => bloc.getActorDetail(actorId: '1'),
    expect:
        () => [
          const GetActorDetailLoading(),
          GetActorDetailLoaded(actor: tActorDetailEntity),
        ],
    verify:
        (_) => verify(mockActorUsecases.getActorDetail(actorId: '1')).called(1),
  );

  blocTest<GetActorDetailCubit, GetActorDetailState>(
    'should emit [GetActorDetailLoading, GetActorDetailError] when internet connection error occurs with SocketException',
    build: () {
      final dioException = DioException(
        requestOptions: RequestOptions(),
        error: const SocketException(''),
        type: DioExceptionType.connectionError,
      );
      provideDummy<Either<NetworkException, ActorDetailEntity>>(
        Left(NetworkException.fromDioError(dioException)),
      );

      when(mockActorUsecases.getActorDetail(actorId: '1')).thenAnswer(
        (_) async => Left(NetworkException.fromDioError(dioException)),
      );

      return GetActorDetailCubit(mockActorUsecases);
    },
    act: (bloc) => bloc.getActorDetail(actorId: '1'),
    expect:
        () => [
          const GetActorDetailLoading(),
          const GetActorDetailError(
            message: 'Please check your internet connection',
          ),
        ],
    verify:
        (_) => verify(mockActorUsecases.getActorDetail(actorId: '1')).called(1),
  );
}
