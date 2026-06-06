class JobModel {
  final String slug;
  final String title;
  final String companyName;
  final String location;
  final String description;
  final String url;
  bool isBookmarked;

  JobModel({
    required this.slug,
    required this.title,
    required this.companyName,
    required this.location,
    required this.description,
    required this.url,
    this.isBookmarked = false,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      slug: json['slug'] ?? '',
      title: json['title'] ?? 'Unknown Position',
      companyName: json['company_name'] ?? 'Unknown Company',
      location: json['location'] ?? 'Unknown Location',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      isBookmarked: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'title': title,
      'company_name': companyName,
      'location': location,
      'description': description,
      'url': url,
    };
  }
}
