import 'dart:async';
import 'dart:io';

import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/survey/providers/photo_provider.dart';
import 'package:applematch/features/survey/screens/add_photos_screen.dart';
import 'package:applematch/features/survey/widgets/image_item_widget.dart';
import 'package:applematch/features/survey/widgets/skimmer_card.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotoAlbumScreen extends ConsumerStatefulWidget {
  const PhotoAlbumScreen({super.key});

  @override
  ConsumerState<PhotoAlbumScreen> createState() => _PhotoAlbumScreenState();
}

class _PhotoAlbumScreenState extends ConsumerState<PhotoAlbumScreen> {
  /// Customize your own filter options.
  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  final int _sizePerPage = 50;

  bool isAlbum = false;

  AssetPathEntity? _path;
   List<AssetPathEntity>? _albumPath;
  List<AssetEntity>? _entities;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;

  @override
  void initState() {
    _requestAssets();
    super.initState();
  }

  Future<void> _requestAssets() async {
    setState(() {
      _isLoading = true;
    });

    // Obtain assets using the path entity.
    final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
        onlyAll: true,
        filterOption: _filterOptionGroup,
        type: RequestType.image,);
    if (!mounted) {
      return;
    }
    // Return if not paths found.
    if (paths.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      showToast('No paths found.');
      return;
    }
    setState(() {
      _path = paths.first;
      _albumPath = paths;
    });
    _totalEntitiesCount = await _path!.assetCountAsync;
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: 0,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities = entities;
      _isLoading = false;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
    });
  }

  Future<void> _loadMoreAsset() async {
    final List<AssetEntity> entities = await _path!.getAssetListPaged(
      page: _page + 1,
      size: _sizePerPage,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _entities!.addAll(entities);
      _page++;
      _hasMoreToLoad = _entities!.length < _totalEntitiesCount;
      _isLoadingMore = false;
    });
  }

  Widget _buildBody(BuildContext context) {
    if (_isLoading) {
      return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.93,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            return SkimmerCard();
          });
    }
    if (_path == null) {
      return const Center(child: Text('Request paths first.'));
    }
    if (_entities?.isNotEmpty != true) {
      return const Center(child: Text('No Image found on this device.'));
    }
  
    return GridView.custom(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == _entities!.length - 8 &&
              !_isLoadingMore &&
              _hasMoreToLoad) {
            _loadMoreAsset();
          }
          final AssetEntity entity = _entities![index];

          return ImageItemWidget(
            key: ValueKey<int>(index),
            entity: entity,
            option: const ThumbnailOption(size: ThumbnailSize.square(200)),
            onTap: () async {
              File? filePath = await entity.file;
              ref.watch(takePhotoProvider.notifier).state = [
                ...ref.watch(takePhotoProvider),
                filePath!
              ]; // edit the state of the provider

              Navigator.pushReplacementNamed(context, AddPhotoScreen.route);
            },
          );
        },
        childCount: _entities!.length,
        findChildIndexCallback: (Key key) {
          // Re-use elements.
          if (key is ValueKey<int>) {
            return key.value;
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: const AppBackButton(
                  isCircular: true,
                ),
              ),
            ),
            Container(
              width: 200.w,
              height: 42.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.pink500,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isAlbum = false;
                        });
                      },
                      child: Container(
                        width: 94.w,
                        height: 42.h,
                        decoration: BoxDecoration(
                            color: !isAlbum ? AppColors.pink500 : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r),
                            )),
                        child: Center(
                          child: Text(
                            "Photos",
                            style: TextStyle(
                                color:
                                    isAlbum ? AppColors.pink500 : Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Expanded(child: _buildBody(context)),
          ],
        ),
      ),
    );
  }
}
