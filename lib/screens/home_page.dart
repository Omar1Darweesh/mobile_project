import 'package:flutter/material.dart';
import 'cart_page.dart'; // صفحة الكارت
import 'login_page.dart'; // صفحة اللوجين

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Fox Spray Black Matt',
      'image': 'assets/Fox_spary_black_matt.png',
      'price': 85,
    },
    {
      'name': 'Fox Spray Blue',
      'image': 'assets/Fox_spary_blue.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray Brown',
      'image': 'assets/Fox_spary_browm.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray Red',
      'image': 'assets/Fox_spary_red.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray Silver',
      'image': 'assets/Fox_spary_silver.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray White',
      'image': 'assets/Fox_spary_white.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray Yellow',
      'image': 'assets/Fox_spary_yellow.png',
      'price': 100,
    },
    {
      'name': 'Fox Spray Black Gloss',
      'image': 'assets/Fox_spray_balck_gloss.png',
      'price': 100,
    },
    {
      'name': 'Glc Acrylic Putty 900',
      'image': 'assets/glc_acrylic_putty_900.png',
      'price': 350,
    },
    {
      'name': 'Glc Day Tone Putty 100',
      'image': 'assets/glc_day_tone-putty_100_bucket.png',
      'price': 170,
    },
    {
      'name': 'Glc Day Tone Putty Bag',
      'image': 'assets/glc_day-tone_putty_100_bag.png',
      'price': 150,
    },
    {
      'name': 'Glc Geltex 20000',
      'image': 'assets/glc_geltex_20000.png',
      'price': 1730,
    },
    {
      'name': 'Glc Gloss Varnish 901',
      'image': 'assets/glc_gloss_varnish_901.png',
      'price': 280,
    },
    {
      'name': 'Glc Standard Varnish 690',
      'image': 'assets/glc_standard_varnish_690.png',
      'price': 220,
    },
    {
      'name': 'Glc Super Day Tone 3030',
      'image': 'assets/glc_super_day_tone_3030.png',
      'price': 540,
    },
    {
      'name': 'Kapci Marble Adhesive Galon',
      'image': 'assets/Kapci_Marble_adhesive_galon.png',
      'price': 310,
    },
    {
      'name': 'Kapci Marble Adhesive Kilo',
      'image': 'assets/Kapci_Marble_adhesive_kilo.png',
      'price': 165,
    },
    {
      'name': 'Kapci Water Selar',
      'image': 'assets/Kapci_water_selar.png',
      'price': 375,
    },
    {
      'name': 'Kapci White Golss 1 Kilo',
      'image': 'assets/Kapci_white_golss.png',
      'price': 110,
    },
    {
      'name': 'Kapci White Matt',
      'image': 'assets/Kapci_white_matt.png',
      'price': 85,
    },
    {
      'name': 'Plastic Sipes 700',
      'image': 'assets/plastic_sipes_700.png',
      'price': 1650,
    },
    {
      'name': 'Plastic Sipes 2000',
      'image': 'assets/plastic_sipes_2000.png',
      'price': 1900,
    },
    {
      'name': 'Saniton Galon',
      'image': 'assets/Saniton_galon.png',
      'price': 405,
    },
    {'name': 'Sipes Putty', 'image': 'assets/Sipes_putty.png', 'price': 350},
    {'name': 'Syntal Galon', 'image': 'assets/Syntal_galon.png', 'price': 510},
  ];

  List<Map<String, dynamic>> cart = [];
  List<int> quantities = [];
  List<bool> isAdded = [];

  @override
  void initState() {
    super.initState();
    quantities = List.generate(products.length, (index) => 0);
    isAdded = List.generate(products.length, (index) => false);
  }

  void addToCart(Map<String, dynamic> product, int index) {
    if (quantities[index] > 0) {
      setState(() {
        final existingIndex = cart.indexWhere(
          (item) => item['product']['name'] == product['name'],
        );

        if (existingIndex != -1) {
          // المنتج موجود بالفعل ➤ نزوّد الكمية
          cart[existingIndex]['quantity'] += quantities[index];
        } else {
          // منتج جديد ➤ نضيفه
          cart.add({'product': product, 'quantity': quantities[index]});
        }

        isAdded[index] = true;
        quantities[index] = 0;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Product added to cart!')));

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isAdded[index] = false;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select quantity first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Al-Ruwaie Store',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'cart') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: cart),
                  ),
                );
              } else if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            icon: const Icon(Icons.more_vert, color: Colors.white),
            itemBuilder:
                (context) => [
                  const PopupMenuItem(value: 'cart', child: Text('Cart')),
                  const PopupMenuItem(value: 'logout', child: Text('Logout')),
                ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 4,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    // ✅ استخدم Expanded بدل SizedBox للصورة
                    Expanded(
                      child: Image.asset(
                        products[index]['image'],
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      products[index]['name'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${products[index]['price']} EGP',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantities[index] > 0) quantities[index]--;
                            });
                          },
                          icon: const Icon(Icons.remove, size: 16),
                        ),
                        Text('${quantities[index]}'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantities[index]++;
                            });
                          },
                          icon: const Icon(Icons.add, size: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          addToCart(products[index], index);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 30),
                          backgroundColor:
                              isAdded[index] ? Colors.red : Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isAdded[index] ? 'Added!' : 'Add to Cart',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
