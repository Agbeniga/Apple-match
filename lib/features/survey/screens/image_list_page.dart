
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:applematch/features/survey/widgets/image_item_widget.dart';
// import 'package:applematch/features/survey/widgets/list_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';

// class GalleryContentListPage extends StatefulWidget {
//   const GalleryContentListPage({
//     super.key,
//     required this.path,
//   });

//   final AssetPathEntity path;

//   @override
//   State<GalleryContentListPage> createState() => _GalleryContentListPageState();
// }

// class _GalleryContentListPageState extends State<GalleryContentListPage> {
 
//   AssetPathEntity get path => widget.path;


//   @override
//   void initState() {
//     super.initState();
//     path.getAssetListRange(start: 0, end: 1).then((List<AssetEntity> value) {
//       if (value.isEmpty) {
//         return;
//       }
//       if (mounted) {
//         return;
//       }
//       PhotoCachingManager().requestCacheAssets(
//         assets: value,
//         option: thumbOption,
//       );
//     });
//   }

//   @override
//   void dispose() {
//     PhotoCachingManager().cancelCacheRequest();
//     super.dispose();
//   }

//   ThumbnailOption get thumbOption => ThumbnailOption(
//         size: const ThumbnailSize.square(200),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//         appBar: AppBar(title: Text(path.name)),
//         body: buildRefreshIndicator(context),
      
//     );
//   }

//   Widget buildRefreshIndicator(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () => _onRefresh(context),
//       child: Scrollbar(
//         child: CustomScrollView(
//           slivers: <Widget>[
//             Consumer<AssetPathProvider>(
//               builder: (BuildContext c, AssetPathProvider p, _) => SliverGrid(
//                 delegate: SliverChildBuilderDelegate(
//                   (_, int index) => Builder(
//                     builder: (BuildContext c) => _buildItem(context, index),
//                   ),
//                   childCount: p.showItemCount,
//                   findChildIndexCallback: (Key? key) {
//                     if (key is ValueKey<String>) {
//                       return findChildIndexBuilder(
//                         id: key.value,
//                         assets: p.list,
//                       );
//                     }
//                     return null;
//                   },
//                 ),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   mainAxisSpacing: 2,
//                   crossAxisCount: 4,
//                   crossAxisSpacing: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildItem(BuildContext context, int index) {
//     final List<AssetEntity> list = watchPathProvider(context).list;
//     if (list.length == index) {
//       onLoadMore(context);
//       return loadWidget;
//     }
//     if (index > list.length) {
//       return const SizedBox.shrink();
//     }
//     AssetEntity entity = list[index];
//     return ImageItemWidget(
//       key: ValueKey<int>(entity.hashCode),
//       entity: entity,
//       option: thumbOption,
//       onTap: (){}
        
//     );
//   }

//   int findChildIndexBuilder({
//     required String id,
//     required List<AssetEntity> assets,
//   }) {
//     return assets.indexWhere((AssetEntity e) => e.id == id);
//   }



//   Future<void> onLoadMore(BuildContext context) async {
//     if (!mounted) {
//       return;
//     }
//     await readPathProvider(context).onLoadMore();
//   }

//   Future<void> _onRefresh(BuildContext context) async {
//     if (!mounted) {
//       return;
//     }
//     await readPathProvider(context).onRefresh();
//   }

 

// }