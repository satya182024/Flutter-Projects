import 'package:flutter/material.dart';
import 'package:food_delivery/view/main_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF9A9E),
              Color(0xFFFAD0C4),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLogin ? 'Welcome Back!' : 'Let\'s get started',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3B52)),
                ),
                // const SizedBox(height: 5),
                Text(
                  isLogin
                      ? 'Enter your credentials to continue'
                      : 'Set up your new account',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/auth.jpg',
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Auth Type Selector
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => setState(() => isLogin = true),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isLogin
                                        ? Colors.orange
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        color: isLogin
                                            ? Colors.white
                                            : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
                                onTap: () => setState(() => isLogin = false),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: !isLogin
                                        ? Colors.orange
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: !isLogin
                                            ? Colors.white
                                            : Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              if (!isLogin) ...[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                obscureText: !showPassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              if (!isLogin) ...[
                                const SizedBox(height: 20),
                                TextFormField(
                                  obscureText: !showPassword,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                ),
                              ],
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  if (isLogin) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MainPage()));
                                  }
                                  // Add your authentication logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  isLogin ? 'Login' : 'Sign Up',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   bool isLogin = true;
//   bool showPassword = false;
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFFFF9A9E),
//               Color(0xFFFAD0C4),
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     isLogin ? 'Login' : 'Sign Up',
//                     style: const TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Added Image
//                   Center(
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: Image.asset(
//                         'assets/auth.jpg', // You'll need to add this image to your assets
//                         height: 200,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           // Rest of the code remains the same...
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: InkWell(
//                                   onTap: () => setState(() => isLogin = true),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     decoration: BoxDecoration(
//                                       color: isLogin
//                                           ? Colors.orange
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         'Login',
//                                         style: TextStyle(
//                                           color: isLogin
//                                               ? Colors.white
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: InkWell(
//                                   onTap: () => setState(() => isLogin = false),
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 10),
//                                     decoration: BoxDecoration(
//                                       color: !isLogin
//                                           ? Colors.orange
//                                           : Colors.transparent,
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     child: Center(
//                                       child: Text(
//                                         'Sign Up',
//                                         style: TextStyle(
//                                           color: !isLogin
//                                               ? Colors.white
//                                               : Colors.black54,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 30),
//                           Form(
//                             key: _formKey,
//                             child: Column(
//                               children: [
//                                 if (!isLogin) ...[
//                                   TextFormField(
//                                     decoration: InputDecoration(
//                                       labelText: 'Name',
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       prefixIcon: const Icon(Icons.person),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 20),
//                                 ],
//                                 TextFormField(
//                                   decoration: InputDecoration(
//                                     labelText: 'Email',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     prefixIcon: const Icon(Icons.email),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 TextFormField(
//                                   obscureText: !showPassword,
//                                   decoration: InputDecoration(
//                                     labelText: 'Password',
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                     prefixIcon: const Icon(Icons.lock),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         showPassword
//                                             ? Icons.visibility_off
//                                             : Icons.visibility,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           showPassword = !showPassword;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 if (!isLogin) ...[
//                                   const SizedBox(height: 20),
//                                   TextFormField(
//                                     obscureText: !showPassword,
//                                     decoration: InputDecoration(
//                                       labelText: 'Confirm Password',
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       prefixIcon: const Icon(Icons.lock),
//                                     ),
//                                   ),
//                                 ],
//                                 const SizedBox(height: 30),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     // Add your authentication logic here
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.orange,
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 50,
//                                       vertical: 15,
//                                     ),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                   ),
//                                   child: Text(
//                                     isLogin ? 'Login' : 'Sign Up',
//                                     style: const TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
