import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_manager/photo_manager.dart';

final takePhotoProvider = StateProvider<List<File>>((_) => []);

final imageListProvider = StateProvider<List<AssetPathEntity>>((_) => []);

// AssetPathEntity? path;
//   List<AssetEntity> list = <AssetEntity>[];

//   bool refreshing = false;

//   int page = 0;

//   int get assetCount => _assetCount!;
//   int? _assetCount;

//   int get showItemCount {
//     if (_assetCount != null && list.length == _assetCount) {
//       return assetCount;
//     }
//     return list.length + 1;
//   }

//   const int loadCount = 50;
//   Future<void> onRefresh() async {
//     if (refreshing) {
//       return;
//     }
//     refreshing = true;
//     path = await path!.obtainForNewProperties(maxDateTimeToNow: false);
//     _assetCount = await path!.assetCountAsync;
//     final List<AssetEntity> list = await elapsedFuture(
//       path.getAssetListPaged(page: 0, size: loadCount),
//       prefix: 'Refresh assets list from path ${path.id}',
//     );
//     page = 0;
//     this.list.clear();
//     this.list.addAll(list);
//     isInit = true;

//     refreshing = false;
//   }

//   Future<void> onLoadMore() async {
//     if (refreshing) {
//       return;
//     }
//     if (showItemCount > assetCount) {
//       Log.d('already max');
//       return;
//     }
//     final List<AssetEntity> list = await elapsedFuture(
//       path.getAssetListPaged(page: page + 1, size: loadCount),
//       prefix: 'Load more assets list from path ${path?.id}',
//     );
  
//     page = page + 1;
//     this.list.addAll(list);
//   }