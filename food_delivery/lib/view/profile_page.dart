import 'package:flutter/material.dart';
import 'package:food_delivery/consts/consts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF9A9E),
              Color(0xFFFAD0C4),
              Colors.white,
            ],
            stops: [0.0, 0.3, 0.7],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Top Section with Back Button and Title
              const Positioned(
                top: 20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white.withOpacity(0.9),
                      //     borderRadius: BorderRadius.circular(15),
                      //   ),
                      //   child: const Icon(
                      //     Icons.arrow_back_ios_new,
                      //     color: kblack,
                      //     size: 20,
                      //   ),
                      // ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Profile Picture and Name Section
              Positioned(
                top: size.height * 0.12,
                left: 30,
                right: 30,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _scaleAnimation.value,
                        child: Row(
                          children: [
                            Hero(
                              tag: 'profile_picture',
                              child: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                      height: 80,
                                      width: 80,
                                      color: Colors.white.withOpacity(0.9),
                                      child: Image.network(
                                        'https://img.icons8.com/color/48/user-male-circle--v1.png',
                                        scale: .5,
                                      )),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'John Smith',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'john.smith@email.com',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Profile Details Section
              Positioned(
                top: size.height * 0.3,
                left: 30,
                right: 30,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(Icons.phone, '+1 234 567 8900'),
                            const SizedBox(height: 15),
                            _buildDetailRow(Icons.location_on, 'Dubai, UAE'),
                            const SizedBox(height: 15),
                            _buildDetailRow(
                                Icons.calendar_today, 'Joined March 2024'),
                            const SizedBox(height: 15),
                            _buildDetailRow(Icons.star, '4.8 Rating'),
                            const SizedBox(height: 15),
                            _buildDetailRow(Icons.shopping_bag, '24 Orders'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Theme Toggle Section
              Positioned(
                bottom: size.height * 0.15,
                left: 30,
                right: 30,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isDarkMode ? Icons.dark_mode : Icons.light_mode,
                            color: kblack,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            isDarkMode ? 'Dark Mode' : 'Light Mode',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kblack,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          // Implement theme change logic here
                        },
                        activeColor: korange,
                      ),
                    ],
                  ),
                ),
              ),

              // Logout Button
              Positioned(
                bottom: size.height * 0.05,
                left: 30,
                right: 30,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: () {
                        // Implement logout logic
                      },
                      borderRadius: BorderRadius.circular(15),
                      // child: Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 20, vertical: 15),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: const [
                      //       // Text(
                      //       //   'Logout',
                      //       //   style: TextStyle(
                      //       //     fontSize: 16,
                      //       //     fontWeight: FontWeight.w600,
                      //       //     color: Colors.red,
                      //       //   ),
                      //       // ),
                      //       // Icon(
                      //       //   Icons.logout,
                      //       //   color: Colors.red,
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: kblack,
          size: 20,
        ),
        const SizedBox(width: 15),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: kblack,
          ),
        ),
      ],
    );
  }
}
