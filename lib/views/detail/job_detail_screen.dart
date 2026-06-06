import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/job_model.dart';
import '../../core/constants/app_colors.dart';

class JobDetailScreen extends StatelessWidget {
  final JobModel job;

  const JobDetailScreen({super.key, required this.job});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(job.url);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        Get.snackbar(
          'Error',
          'Could not launch application link.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Invalid job link: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Job Details'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Hero Card detailing Job
                Hero(
                  tag: 'card-${job.slug}',
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Title
                        Hero(
                          tag: 'title-${job.slug}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              job.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Hero Company
                        Hero(
                          tag: 'company-${job.slug}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              job.companyName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Hero Location
                        Hero(
                          tag: 'location-${job.slug}',
                          child: Material(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 18,
                                  color: AppColors.grey,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    job.location,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Description header
                const Text(
                  'Job Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 12),

                // HTML content description
                Html(
                  data: job.description,
                  style: {
                    "body": Style(
                      fontSize: FontSize(15.0),
                      color: AppColors.secondary.withOpacity(0.85),
                      margin: Margins.zero,
                      padding: HtmlPaddings.zero,
                      lineHeight: const LineHeight(1.5),
                    ),
                    "h2": Style(
                      fontSize: FontSize(18.0),
                      fontWeight: FontWeight.bold,
                      margin: Margins.only(top: 16, bottom: 8),
                    ),
                    "p": Style(
                      margin: Margins.only(bottom: 12),
                    ),
                    "ul": Style(
                      margin: Margins.only(bottom: 12),
                    ),
                    "li": Style(
                      margin: Margins.only(bottom: 6),
                    ),
                  },
                ),
              ],
            ),
          ),

          // Bottom Action Bar with Apply Now button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.card,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _launchUrl,
                  icon: const Icon(Icons.launch_rounded, color: AppColors.textLight),
                  label: const Text(
                    'Apply Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
