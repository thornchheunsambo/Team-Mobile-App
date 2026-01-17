import 'package:flutter/material.dart';
import 'package:king_coffee/flash.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedCategory = 'All';
  final List<Map<String, dynamic>> _favoriteItems = [];

  final List<Map<String, String>> _products = [
    {
      'name': 'Espresso',
      'description': 'Strong, concentrated coffee',
      'price': '\$5',
      'image': 'assets/images/espresso1.png',
    },
    {
      'name': 'Matcha Latte',
      'description': 'Creamy green tea latte',
      'price': '\$5',
      'image': 'assets/images/matcha.png',
    },
    {
      'name': 'Iced Latte',
      'description': 'Cold coffee with milk',
      'price': '\$5',
      'image': 'assets/images/iced_latte.png',
    },
    {
      'name': 'Fruit Tea',
      'description': 'Refreshing fruit infusion',
      'price': '\$5',
      'image': 'assets/images/fruit_tea.png',
    },
  ];

  late PageController _pageController;
  int _currentPage = 0;

  final List<String> _bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.png',
    'assets/images/banner3.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  void _autoSlide() {
    if (!mounted) return;
    _currentPage = (_currentPage + 1) % _bannerImages.length;
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    Future.delayed(const Duration(seconds: 3), _autoSlide);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int index) {
    setState(() {
      if (_favoriteItems.contains(_products[index])) {
        _favoriteItems.remove(_products[index]);
      } else {
        _favoriteItems.add(_products[index]);
      }
    });
  }

  bool _isFavorite(int index) {
    return _favoriteItems.contains(_products[index]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final safeHeight = MediaQuery.of(context).padding.top + 
                       MediaQuery.of(context).padding.bottom;
    final availableHeight = screenHeight - safeHeight;
    
    final headerPadding = screenWidth * 0.04;
    final logoSize = 40.0;
    final bannerHeight = availableHeight * 0.25;
    final categoryHeight = 40.0;
    
    int crossAxisCount = 2;
    if (screenWidth > 600) {
      crossAxisCount = 3;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4;
    }
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: headerPadding,
                vertical: 10,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFFA26C40), Color(0xFF2D2607)],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  InkWell(
                    onTap: () {
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      );
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 55,
                        height: 55,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.local_cafe_rounded,
                            color: Colors.white,
                            size: 40,
                          );
                        },
                      ),
                    ),
                  ),
                  // Title
                  const Flexible(
                    child: Text(
                      'KING COFFEE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  // Notification Icon
                  Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No new notifications'),
                            backgroundColor: Color(0xFF6B3D1E),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    
                    // Coffee Presentation Banner with Auto-Slide
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        height: bannerHeight,
                        child: Stack(
                          children: [
                            // Coffee beans decoration
                            Positioned(
                              top: bannerHeight * 0.15,
                              left: screenWidth * 0.25,
                              child: Icon(Icons.circle, size: 6, 
                                color: Colors.brown.withOpacity(0.5)),
                            ),
                            Positioned(
                              top: bannerHeight * 0.30,
                              left: screenWidth * 0.35,
                              child: Icon(Icons.circle, size: 8, 
                                color: Colors.brown.withOpacity(0.6)),
                            ),
                            Positioned(
                              top: bannerHeight * 0.45,
                              left: screenWidth * 0.28,
                              child: Icon(Icons.circle, size: 5, 
                                color: Colors.brown.withOpacity(0.7)),
                            ),
                            Positioned(
                              top: bannerHeight * 0.22,
                              left: screenWidth * 0.42,
                              child: Icon(Icons.circle, size: 7, 
                                color: Colors.brown.withOpacity(0.55)),
                            ),
                            
                            Container(
                              margin: const EdgeInsets.all(8),
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  // PageView for auto-sliding banners
                                  PageView.builder(
                                    controller: _pageController,
                                    itemCount: _bannerImages.length,
                                    onPageChanged: (index) {
                                      setState(() => _currentPage = index);
                                    },
                                    itemBuilder: (context, index) {
                                      return Image.asset(
                                        _bannerImages[index],
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: const Color(0xFFD4A574),
                                            child: const Center(
                                              child: Icon(
                                                Icons.coffee,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),

                                  // Dots indicator
                                  Positioned(
                                    bottom: 8,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        _bannerImages.length,
                                        (index) => AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(horizontal: 3),
                                          width: _currentPage == index ? 10 : 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: _currentPage == index
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
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
                    
                    const SizedBox(height: 16),
                    
                    // Category Filter
                    SizedBox(
                      height: categoryHeight,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          _buildCategoryChip('All', Icons.apps),
                          _buildCategoryChip('Espresso', Icons.local_cafe),
                          _buildCategoryChip('Milk Coffee', Icons.coffee),
                          _buildCategoryChip('Cold', Icons.ac_unit),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Products Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.72,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          return _buildProductCard(index);
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF2D2607), Color(0xFFA26C40)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(Icons.home, 'Home', 0),
                _buildNavItem(Icons.favorite, 'Favourite', 1),
                _buildNavItem(Icons.shopping_cart, 'Cart', 2),
                _buildNavItem(Icons.person, 'Profile', 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon) {
    final bool isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : const Color(0xFF6B3D1E),
            ),
            const SizedBox(width: 6),
            Text(label),
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = label;
          });
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF6B3D1E),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF6B3D1E),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget _buildProductCard(int index) {
    final product = _products[index];
    final isFav = _isFavorite(index);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image from Assets
          Expanded(
            flex: 7,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  product['image']!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to network image if asset not found
                    return Image.network(
                      index == 0
                          ? 'https://images.unsplash.com/photo-1510591509098-f4fdc6d0ff04?w=400'
                          : index == 1
                              ? 'https://images.unsplash.com/photo-1536013564849-81d957b057be?w=400'
                              : index == 2
                                  ? 'https://images.unsplash.com/photo-1517487881594-2787fef5ebf7?w=400'
                                  : 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=400',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.coffee,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // Product Info
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Price
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product['name']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        product['price']!,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B3D1E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    product['description']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[600],
                    ),
                  ),

                  const Spacer(),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 25,
                          child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${product['name']} added to cart!'),
                                  backgroundColor: const Color(0xFF6B3D1E),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA26C40),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.brown : Colors.grey,
                          size: 22,
                        ),
                        onPressed: () => _toggleFavorite(index),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        
        if (index == 3) {
          // Profile - Logout
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Logout'),
              content: const Text('Are you sure you want to logout?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const FlashPage()),
                      (route) => false,
                    );
                  },
                  child: const Text('Logout'),
                ),
              ],
            ),
          );
        } else if (index == 1) {
          // Show favorites
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have ${_favoriteItems.length} favorites'),
              backgroundColor: const Color(0xFF6B3D1E),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}