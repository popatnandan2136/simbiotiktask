import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/job_model.dart';
import '../controllers/job_controller.dart';
import '../core/constants/app_colors.dart';
import '../core/routes/app_routes.dart';

class JobCard extends StatelessWidget {
  final JobModel job;
  final JobController controller = Get.find<JobController>();

  JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Get.toNamed(AppRoutes.detail, arguments: job);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hero widget for Job Title
                      Hero(
                        tag: 'title-${job.slug}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Hero widget for Company Name
                      Hero(
                        tag: 'company-${job.slug}',
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            job.companyName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Hero widget for Location
                      Hero(
                        tag: 'location-${job.slug}',
                        child: Material(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 16,
                                color: AppColors.grey,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  job.location,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => controller.toggleBookmark(job),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: Icon(
                        job.isBookmarked ? Icons.favorite : Icons.favorite_border,
                        key: ValueKey<bool>(job.isBookmarked),
                        color: job.isBookmarked ? Colors.red : AppColors.grey,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
