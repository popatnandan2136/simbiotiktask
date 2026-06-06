import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/job_model.dart';
import '../services/api_service.dart';

class JobController extends GetxController {
  final ApiService _apiService = ApiService();

  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<JobModel> jobs = <JobModel>[].obs;
  final RxList<JobModel> filteredJobs = <JobModel>[].obs;
  final RxList<String> bookmarkedSlugs = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    await loadBookmarks();
    await fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');
      
      final fetchedJobs = await _apiService.fetchJobs();
      
      // Map bookmark state
      for (var job in fetchedJobs) {
        job.isBookmarked = bookmarkedSlugs.contains(job.slug);
      }
      
      jobs.assignAll(fetchedJobs);
      filteredJobs.assignAll(fetchedJobs);
    } catch (e) {
      hasError(true);
      errorMessage(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading(false);
    }
  }

  void searchJobs(String query) {
    if (query.isEmpty) {
      filteredJobs.assignAll(jobs);
    } else {
      final lowercaseQuery = query.toLowerCase();
      filteredJobs.assignAll(
        jobs.where((job) {
          final titleMatch = job.title.toLowerCase().contains(lowercaseQuery);
          final companyMatch = job.companyName.toLowerCase().contains(lowercaseQuery);
          return titleMatch || companyMatch;
        }).toList(),
      );
    }
  }

  Future<void> loadBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedBookmarks = prefs.getStringList('bookmarked_slugs') ?? [];
      bookmarkedSlugs.assignAll(savedBookmarks);
    } catch (e) {
      errorMessage('Failed to load bookmarks.');
    }
  }

  Future<void> saveBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('bookmarked_slugs', bookmarkedSlugs);
    } catch (e) {
      errorMessage('Failed to save bookmarks.');
    }
  }

  void toggleBookmark(JobModel job) {
    if (job.isBookmarked) {
      job.isBookmarked = false;
      bookmarkedSlugs.remove(job.slug);
    } else {
      job.isBookmarked = true;
      bookmarkedSlugs.add(job.slug);
    }
    
    // Refresh lists to trigger UI update
    jobs.refresh();
    filteredJobs.refresh();
    saveBookmarks();
  }
}
