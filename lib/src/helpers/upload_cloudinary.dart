part of 'helpers.dart';

Future<String> uploadPhoto(image, folder) async {
  final cloudinary = Cloudinary(
    '114223356559935',
    '2WIHaFLQ90Gu-r48iP2aF2mfB5o',
    'maeth',
  );

  final response = await cloudinary.uploadFile(
    filePath: image.path,
    resourceType: CloudinaryResourceType.image,
    folder: folder,
  );

  if (response.statusCode == 200) {
    return response.url.toString();
  } else {
    return '';
  }
}
