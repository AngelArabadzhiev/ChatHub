import 'package:Chat_App/repo/image_repository.dart';
import 'package:Chat_App/utils/brand_colors.dart';
import 'package:flutter/material.dart';

import '../models/image_model.dart';

class NetworkImagePicker extends StatelessWidget {
  final Function(String) onImageSelected;
  final ImageRepository _imageRepo = ImageRepository();

  NetworkImagePicker({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: BrandColors.chatInputColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
      ),
      child: FutureBuilder<List<UnsplashImage>>(
          future: _imageRepo.getNetworkImages(),
          builder: (BuildContext context,
              AsyncSnapshot<List<UnsplashImage>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        onImageSelected(snapshot.data![index].urlSmallSize);
                      },
                      child: Image.network(snapshot.data![index].urlSmallSize));
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.4),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text("Error: ${snapshot.error}"),
              );
            }
      
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }
}
