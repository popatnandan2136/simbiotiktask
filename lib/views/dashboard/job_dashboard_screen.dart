import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/job_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/job_card.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/error_view.dart';
import '../../widgets/empty_view.dart';

class JobDashboardScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());
  final TextEditingController searchController = TextEditingController();

  JobDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Curvaceous Gradient Header Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 40,
                left: 24,
                right: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'HireHub',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discover Your Next Opportunity',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar Section (Overlapping slightly or immediately below header)
            Transform.translate(
              offset: const Offset(0, -20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: controller.searchJobs,
                    decoration: InputDecoration(
                      hintText: 'Search by job title or company...',
                      hintStyle: const TextStyle(color: AppColors.grey),
                      prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear_rounded, color: AppColors.grey),
                              onPressed: () {
                                searchController.clear();
                                controller.searchJobs('');
                              },
                            )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ),
            ),

            // Dynamic Content Feed
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  searchController.clear();
                  await controller.fetchJobs();
                },
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const ShimmerJobList();
                  }

                  if (controller.hasError.value) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ErrorView(
                          errorMessage: controller.errorMessage.value,
                          onRetry: () => controller.fetchJobs(),
                        ),
                      ),
                    );
                  }

                  if (controller.filteredJobs.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: const EmptyView(),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 24),
                    itemCount: controller.filteredJobs.length,
                    itemBuilder: (context, index) {
                      final job = controller.filteredJobs[index];
                      return JobCard(job: job);
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
