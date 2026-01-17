import 'package:flutter/material.dart';
import 'package:king_coffee/auth/signin.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      image: 'assets/images/onboarding1.png',
      title: 'Brew Your Perfect Cup',
      description: 'Discover rich, aromatic coffees made just the way you love from bold espressos to creamy lattes or matcha lattes.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding2.png',
      title: 'Chill with Sweet Treats',
      description: 'Dive into a world of refreshing, creamy ice creams in a variety of mouth watering flavor delights.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding3.png',
      title: 'Refresh with Every Sip',
      description: 'This phrase promises that each drink delivers a refreshing experience, not just the first taste, it suggests consistency, quality, and satisfaction from start to finish.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInPage()),
    );
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToSignIn();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: _onboardingData.length,
          itemBuilder: (context, index) {
            return _buildOnboardingScreen(_onboardingData[index], index);
          },
        ),
      ),
    );
  }

  Widget _buildOnboardingScreen(OnboardingData data, int index) {
    final isLastPage = index == _onboardingData.length - 1;

    return Column(
      children: [
        // Image section (50% of screen)
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        // Content section with brown gradient (50% of screen)
        Expanded(
          flex: 5,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF6B4423), Color(0xFF4A2E1A)],
              ),
            ),
            child: Column(
              children: [
                // Title and Description
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Pagination dots
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingData.length,
                      (dotIndex) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == dotIndex ? 12 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == dotIndex
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Skip and Next/Done buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip button
                      TextButton(
                        onPressed: _navigateToSignIn,
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD4A574),
                          ),
                        ),
                      ),
                      
                      // Next/Done button
                      TextButton(
                        onPressed: _nextPage,
                        child: Text(
                          isLastPage ? 'Done' : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFD4A574),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}