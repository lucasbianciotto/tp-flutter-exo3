class Image {
  final String url;

  Image({required this.url});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      url: json['url'],
    );
  }
}