// import 'package:applematch/features/survey/providers/photo_provider.dart';
// import 'package:applematch/features/survey/widgets/gallery_item_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:photo_manager/photo_manager.dart';

// class GalleryListPage extends ConsumerStatefulWidget {
//   const GalleryListPage({super.key});

//   @override
//   ConsumerState<GalleryListPage> createState() => _GalleryListPageState();
// }

// class _GalleryListPageState extends ConsumerState<GalleryListPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gallery list'),
//       ),
//       body: Scrollbar(
//         child: ListView.builder(
//           itemBuilder: _buildItem,
//           itemCount: ref.watch(imageListProvider).length,
//         ),
//       ),
//     );
//   }

//   Widget _buildItem(BuildContext context, int index) {
//     final AssetPathEntity item = ref.watch(imageListProvider)[index];
//     return GalleryItemWidget(
//       path: item,
//       setState: setState,
//     );
//   }
// }