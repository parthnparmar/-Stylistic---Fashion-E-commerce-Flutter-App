import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// -----------------------------------------------------------------------------
// 📦 Cart Manager (Global State for Cart)
// -----------------------------------------------------------------------------
class CartManager {
  static List<Map<String, dynamic>> cartItems = [];

  static void addToCart(Map<String, dynamic> item) {
    // Check if item already exists based on title, size, and color
    int index = cartItems.indexWhere((i) =>
    i["title"] == item["title"] &&
        i["size"] == item["size"] &&
        i["color"] == item["color"]);

    if (index != -1) {
      // If it exists, update quantity
      cartItems[index]["qty"] += item["qty"];
    } else {
      // Otherwise, add new item
      cartItems.add(item);
    }
  }

  static void removeFromCart(int index) {
    cartItems.removeAt(index);
  }

  static void clearCart() {
    cartItems.clear();
  }

  static double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + (item["price"] * item["qty"]));
  }
}

// -----------------------------------------------------------------------------
// 🏡 ShopScreen (Main Navigation Hub)
// -----------------------------------------------------------------------------

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _selectedIndex = 0; // Current index for BottomNavigationBar

  // List of main screens for the bottom navigation
  late final List<Widget> _widgetOptions = <Widget>[
    const HomeScreenContent(), // Home/Shop content
    const HomeScreenContent(), // Shop content (Same as home for simplicity)
    const WishlistPage(), // New Wishlist Page
    const CartPage(), // Existing Cart Page
    const ProfilePage(), // New Profile Page
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
      // Special case for CartPage, needs to trigger rebuild
      setState(() {
        _selectedIndex = index;
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C29),
        elevation: 0,
        centerTitle: true,
        title: Text(
          _selectedIndex == 0 || _selectedIndex == 1
              ? "Shop"
              : _selectedIndex == 2
              ? "Wishlist"
              : _selectedIndex == 3
              ? "My Cart"
              : "Profile",
          style: const TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          if (_selectedIndex != 3)
            IconButton(
              onPressed: () {
                _onItemTapped(3); // Navigate to Cart
              },
              icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // 🔽 Bottom Nav Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF152238),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Wishlist"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 🏠 HomeScreenContent (Replaces the original ShopScreen build body)
// -----------------------------------------------------------------------------

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sliderImages = [
      "assets/images/b1.jpeg",
      "assets/images/b2.jpeg",
      "assets/images/b3.jpeg",
    ];

    final List<Map<String, dynamic>> categories = [
      {"name": "Men", "icon": Icons.male},
      {"name": "Women", "icon": Icons.female},
      {"name": "Kids", "icon": Icons.child_care},
      {"name": "Shoes", "icon": Icons.directions_run},
      {"name": "Accessories", "icon": Icons.watch},
      {"name": "Beauty", "icon": Icons.face_retouching_natural},
      {"name": "Bags", "icon": Icons.shopping_bag},
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Image Slider
          CarouselSlider(
            options: CarouselOptions(
              height: 180,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items: sliderImages.map((imgPath) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(imgPath,
                        fit: BoxFit.cover, width: double.infinity),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F0C29),
                    Color(0xFF302B63),
                    Color(0xFF24243E)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white70),
                  hintText: "Search products...",
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 🏷️ Categories
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _CategoryChip(
                  category: categories[index]["name"],
                  icon: categories[index]["icon"],
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // ⭐ Featured
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Featured",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _ProductCard(context, "Casual Wear", "assets/images/jeans.jpg", 1200),
              _ProductCard(context, "Formal Wear", "assets/images/blazer.jpg", 2500),
              _ProductCard(context, "Sportswear", "assets/images/sports.jpg", 1500),
              _ProductCard(context, "Outerwear", "assets/images/jacket.jpeg", 3000),
              _ProductCard(context, "Casual Wear", "assets/images/jeans.jpg", 1200),
              _ProductCard(context, "Formal Wear", "assets/images/blazer.jpg", 2500),
              _ProductCard(context, "Sportswear", "assets/images/sports.jpg", 1500),
              _ProductCard(context, "Outerwear", "assets/images/jacket.jpeg", 3000),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 🏷️ Category Chip Widget
// -----------------------------------------------------------------------------

class _CategoryChip extends StatelessWidget {
  final String category;
  final IconData icon;

  const _CategoryChip({required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoryPage(category: category, icon: icon)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF667db6), Color(0xFF0082c8), Color(0xFF00c6ff)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(category,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 💎 Product Card Widget
// -----------------------------------------------------------------------------

class _ProductCard extends StatelessWidget {
  final BuildContext context;
  final String title;
  final String imgPath;
  final double price;

  const _ProductCard(this.context, this.title, this.imgPath, this.price);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(title: title, img: imgPath, price: price),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF152238), Color(0xFF152238)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(imgPath, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("$title\n₹$price",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.amberAccent, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 🛍️ Product Details Page
// -----------------------------------------------------------------------------

class ProductDetailsPage extends StatefulWidget {
  final String title;
  final String img;
  final double price;

  const ProductDetailsPage(
      {super.key, required this.title, required this.img, required this.price});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int qty = 1;
  String selectedSize = "M";
  String selectedColor = "Black";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C29),
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.amber),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Carousel
            CarouselSlider(
              options: CarouselOptions(
                  height: 250, enableInfiniteScroll: false, enlargeCenterPage: true),
              items: [widget.img].map((img) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(img, fit: BoxFit.cover, width: double.infinity),
                );
              }).toList(),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 8),
                    Text("₹${widget.price}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber)),
                    const SizedBox(height: 12),
                    const Text("Size:", style: TextStyle(color: Colors.white70)),
                    // Size Selector
                    Wrap(
                      spacing: 8.0,
                      children: ["S", "M", "L", "XL"].map((size) {
                        return ChoiceChip(
                          label: Text(size, style: TextStyle(color: selectedSize == size ? Colors.black : Colors.white)),
                          selected: selectedSize == size,
                          selectedColor: Colors.amberAccent,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          onSelected: (val) => setState(() => selectedSize = size),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const Text("Color:", style: TextStyle(color: Colors.white70)),
                    // Color Selector
                    Wrap(
                      spacing: 8.0,
                      children: ["Black", "White", "Blue"].map((color) {
                        return ChoiceChip(
                          label: Text(color, style: TextStyle(color: selectedColor == color ? Colors.black : Colors.white)),
                          selected: selectedColor == color,
                          selectedColor: Colors.amberAccent,
                          backgroundColor: Colors.white.withOpacity(0.1),
                          onSelected: (val) => setState(() => selectedColor = color),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),

                    // Quantity Selector
                    Row(
                      children: [
                        const Text("Quantity:", style: TextStyle(color: Colors.white70)),
                        const SizedBox(width: 12),
                        IconButton(
                            onPressed: () => setState(() => qty = qty > 1 ? qty - 1 : 1),
                            icon: const Icon(Icons.remove_circle_outline,
                                color: Colors.amberAccent)),
                        Text("$qty",
                            style: const TextStyle(color: Colors.white, fontSize: 18)),
                        IconButton(
                            onPressed: () => setState(() => qty++),
                            icon: const Icon(Icons.add_circle_outline,
                                color: Colors.amberAccent)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("Description:", style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 4),
                    const Text(
                        "This premium clothing item features a modern cut and is made from breathable, high-quality fabric, perfect for any occasion.",
                        style: TextStyle(color: Colors.white70)),
                  ]),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.black),
                      label: const Text("Add to Cart", style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        CartManager.addToCart({
                          "title": widget.title,
                          "img": widget.img,
                          "price": widget.price,
                          "qty": qty,
                          "size": selectedSize,
                          "color": selectedColor,
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Added to Cart successfully!"),
                            backgroundColor: Colors.amberAccent));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 🛒 Cart Page
// -----------------------------------------------------------------------------

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _updateCart() {
    setState(() {}); // Force rebuild when cart changes
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartManager.cartItems;
    final total = CartManager.getTotal();

    return cart.isEmpty
        ? const Center(
        child: Text("Your cart is empty",
            style: TextStyle(color: Colors.white, fontSize: 16)))
        : Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final item = cart[index];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(item["img"], width: 60, fit: BoxFit.cover),
                ),
                title: Text(item["title"],
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                    "Size: ${item["size"]}, Color: ${item["color"]}, Qty: ${item["qty"]}",
                    style: const TextStyle(color: Colors.white70)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("₹${item["price"] * item["qty"]}",
                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        CartManager.removeFromCart(index);
                        _updateCart();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C2D),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal:",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text("₹${total.toStringAsFixed(2)}",
                      style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the new CheckoutPage
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CheckoutPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                child: const Text("Proceed to Checkout",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        )
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// 💳 Checkout Page (New Implementation)
// -----------------------------------------------------------------------------
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  String _paymentMethod = 'Credit Card';
  bool _isProcessing = false;

  final TextEditingController _nameController = TextEditingController(text: "John Doe");
  final TextEditingController _addressController = TextEditingController(text: "123 Star Lane, Nebula City");
  final TextEditingController _cardNumberController = TextEditingController(text: "4444 4444 4444 4444");
  final TextEditingController _expiryController = TextEditingController(text: "12/26");
  final TextEditingController _cvvController = TextEditingController(text: "123");

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _processPayment(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);

      // Simulate network delay for payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Clear the cart on successful payment simulation
      CartManager.clearCart();

      // Navigate to Order Confirmation Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const OrderConfirmationPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = CartManager.getTotal();
    const shippingFee = 50.0;
    final grandTotal = total + shippingFee;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C29),
        title: const Text("Checkout", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🚚 Shipping Info
              const Text("1. Shipping Details",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent)),
              const SizedBox(height: 12),
              _buildCheckoutTextField(controller: _nameController, hint: "Full Name", icon: Icons.person_outline),
              const SizedBox(height: 12),
              _buildCheckoutTextField(controller: _addressController, hint: "Shipping Address", icon: Icons.location_on_outlined),
              const Divider(color: Colors.white30, height: 30),

              // 💳 Payment Method
              const Text("2. Payment Method",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent)),
              ListTile(
                title: const Text("Credit Card", style: TextStyle(color: Colors.white)),
                leading: Radio<String>(
                  value: 'Credit Card',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() => _paymentMethod = value!);
                  },
                  activeColor: Colors.amberAccent,
                ),
                contentPadding: EdgeInsets.zero,
              ),
              ListTile(
                title: const Text("Cash on Delivery (COD)", style: TextStyle(color: Colors.white)),
                leading: Radio<String>(
                  value: 'COD',
                  groupValue: _paymentMethod,
                  onChanged: (String? value) {
                    setState(() => _paymentMethod = value!);
                  },
                  activeColor: Colors.amberAccent,
                ),
                contentPadding: EdgeInsets.zero,
              ),

              if (_paymentMethod == 'Credit Card') ...[
                const SizedBox(height: 12),
                _buildCheckoutTextField(controller: _cardNumberController, hint: "Card Number", icon: Icons.credit_card_outlined),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                        child: _buildCheckoutTextField(controller: _expiryController, hint: "Expiry (MM/YY)", icon: Icons.date_range_outlined)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _buildCheckoutTextField(controller: _cvvController, hint: "CVV", icon: Icons.lock_outline, isObscure: true)),
                  ],
                ),
              ],
              const Divider(color: Colors.white30, height: 30),

              // 🧾 Order Summary
              const Text("3. Order Summary",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amberAccent)),
              const SizedBox(height: 12),
              _buildSummaryRow("Subtotal", "₹${total.toStringAsFixed(2)}"),
              _buildSummaryRow("Shipping", "₹${shippingFee.toStringAsFixed(2)}"),
              const Divider(color: Colors.white30),
              _buildSummaryRow("Grand Total", "₹${grandTotal.toStringAsFixed(2)}",
                  isTotal: true),
              const SizedBox(height: 30),

              // 🚨 Place Order Button
              ElevatedButton(
                onPressed: _isProcessing ? null : () => _processPayment(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 5,
                ),
                child: _isProcessing
                    ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                            color: Colors.black, strokeWidth: 2)),
                    SizedBox(width: 12),
                    Text("Processing Payment...",
                        style: TextStyle(color: Colors.black)),
                  ],
                )
                    : Text(
                    _paymentMethod == 'COD' ? "Place Order (COD)" : "Pay ₹${grandTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isObscure = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.amberAccent),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isTotal ? Colors.white : Colors.white70,
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: isTotal ? Colors.amber : Colors.white,
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ✅ Order Confirmation Page (New Implementation)
// -----------------------------------------------------------------------------
class OrderConfirmationPage extends StatelessWidget {
  const OrderConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C29),
        title: const Text("Order Confirmed", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false, // Hide back button
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle_outline, color: Colors.amberAccent, size: 100),
              const SizedBox(height: 24),
              const Text(
                "Thank You!",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 16),
              const Text(
                "Your order has been successfully placed. A confirmation email will be sent shortly.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.5),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the main Shop screen
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopScreen()),
                          (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                child: const Text("Continue Shopping",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 👤 Profile Page (Placeholder)
// -----------------------------------------------------------------------------
class UserSession {
  static String userName = "Amelia Clark";
  static String userEmail = "amelia.clark@example.com";
  static String userJoinedDate = "September 2024";
}

// Mock implementation of a navigation target
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
      backgroundColor: Color(0xFF0F0C29),
      body: Center(child: Text("Order History Page", style: TextStyle(color: Colors.white))));
}

// Mock implementation of the destination after logout
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(
      backgroundColor: Color(0xFF0F0C29),
      body: Center(child: Text("Onboarding Screen (Logged Out)", style: TextStyle(color: Colors.amber))));
}



// --- Functional ProfilePage Implementation ---

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // 🔹 Helper widget to build the profile links
  static Widget _buildProfileTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.white.withOpacity(0.05),
        leading: Icon(icon, color: Colors.amberAccent),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture (Using existing image with Icon fallback)
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.amberAccent.withOpacity(0.8),
            child: const Icon(Icons.person, color: Colors.black, size: 60),
          ),
          const SizedBox(height: 16),

          // User Info
          Text(
            UserSession.userName,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            UserSession.userEmail,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 30),

          // Account Settings List
          _buildProfileTile(
            context: context,
            title: "Order History",
            icon: Icons.history,
            onTap: () {
              // Navigates to the Order History Page
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderHistoryPage()));
            },
          ),
          _buildProfileTile(
            context: context,
            title: "Addresses",
            icon: Icons.location_on_outlined,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Navigating to Saved Addresses..."),
                backgroundColor: Colors.blueAccent,
              ));
            },
          ),
          _buildProfileTile(
            context: context,
            title: "Payment Methods",
            icon: Icons.credit_card_outlined,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Navigating to Payment Methods..."),
                backgroundColor: Colors.blueAccent,
              ));
            },
          ),
          _buildProfileTile(
            context: context,
            title: "Settings",
            icon: Icons.settings_outlined,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Navigating to Settings..."),
                backgroundColor: Colors.blueAccent,
              ));
            },
          ),
          const SizedBox(height: 40),

          // ➡️ Logout Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
            ),
            child: TextButton.icon(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                "Logout",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Perform logout actions
                CartManager.clearCart();
                // Navigate to the Onboarding Screen and clear the route stack
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Member since ${UserSession.userJoinedDate}",
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 💖 Wishlist Page (Placeholder)
// -----------------------------------------------------------------------------
// 💖 Wishlist Page (Placeholder - Unchanged)
class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, color: Colors.redAccent, size: 80),
          SizedBox(height: 16),
          Text("Wishlist Page", style: TextStyle(color: Colors.white, fontSize: 24)),
          SizedBox(height: 8),
          Text("Your saved favorite items appear here.", style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}
// -----------------------------------------------------------------------------
// 🗂️ Category Page (Unchanged)
// -----------------------------------------------------------------------------
class CategoryPage extends StatelessWidget {
  final String category;
  final IconData icon;

  const CategoryPage({super.key, required this.category, required this.icon});

  static final Map<String, List<Map<String, dynamic>>> products = {
    "Men": [
      {"title": "Men's Shirt", "image": "assets/images/m1.jpg", "price": 1000.0},
      {"title": "Men's Blazer", "image": "assets/images/m2.jpg", "price": 2500.0},
      {"title": "Men's Shirt", "image": "assets/images/m3.jpg", "price": 1000.0},
      {"title": "Men's Blazer", "image": "assets/images/m4.jpg", "price": 2500.0},
      {"title": "Men's Shirt", "image": "assets/images/m5.jpg", "price": 1000.0},
      {"title": "Men's Blazer", "image": "assets/images/m6.jpg", "price": 2500.0},
      {"title": "Men's Shirt", "image": "assets/images/m7.jpg", "price": 1000.0},
      {"title": "Men's Dress", "image": "assets/images/m8.jpg", "price": 2500.0},
    ],
    "Women": [
      {"title": "Women's Dress", "image": "assets/images/w1.jpeg", "price": 1800.0},
      {"title": "Women's Dress", "image": "assets/images/w2.jpeg", "price": 1200.0},
      {"title": "Women's Dress", "image": "assets/images/w3.jpeg", "price": 1800.0},
      {"title": "Women's Dress", "image": "assets/images/w4.jpeg", "price": 1800.0},
      {"title": "Women's Dress", "image": "assets/images/w5.jpeg", "price": 1800.0},
      {"title": "Women's Dress", "image": "assets/images/w6.jpeg", "price": 1200.0},
      {"title": "Women's Dress", "image": "assets/images/w7.jpeg", "price": 1800.0},
      {"title": "Women's Dress", "image": "assets/images/w8.jpeg", "price": 1800.0},
    ],
    "Kids": [
      {"title": "Kids's Dress", "image": "assets/images/k1.jpeg", "price": 1000.0},
      {"title": "Kids's Dress", "image": "assets/images/k2.jpeg", "price": 2500.0},
      {"title": "Kids's Dress", "image": "assets/images/k3.jpeg", "price": 1000.0},
      {"title": "Kids's Dress", "image": "assets/images/k4.jpeg", "price": 2500.0},
      {"title": "Kids's Dress", "image": "assets/images/k5.jpeg", "price": 1000.0},
      {"title": "Kids's Dress", "image": "assets/images/k6.jpeg", "price": 2500.0},
      {"title": "Kids's Dress", "image": "assets/images/k7.jpeg", "price": 1000.0},
      {"title": "Kids's Dress", "image": "assets/images/k8.jpeg", "price": 2500.0},
    ],
    "Shoes": [
      {"title": "Shoes ", "image": "assets/images/s1.jpeg", "price": 1000.0},
      {"title": "Shoes", "image": "assets/images/s2.jpeg", "price": 2500.0},
      {"title": "Shoes", "image": "assets/images/s3.jpeg", "price": 1000.0},
      {"title": "Shoes", "image": "assets/images/s4.jpeg", "price": 2500.0},
      {"title": "Shoes", "image": "assets/images/s5.jpeg", "price": 1000.0},
      {"title": "Shoes", "image": "assets/images/s6.jpeg", "price": 2500.0},
      {"title": "Shoes", "image": "assets/images/s7.jpeg", "price": 1000.0},
      {"title": "Shoes", "image": "assets/images/s8.jpeg", "price": 2500.0},
    ],
    "Accessories": [
      {"title": "Accessories", "image": "assets/images/a1.jpeg", "price": 1000.0},
      {"title": "Accessories", "image": "assets/images/a2.jpeg", "price": 2500.0},
      {"title": "Accessories", "image": "assets/images/a3.jpeg", "price": 1000.0},
      {"title": "Accessories", "image": "assets/images/a4.jpeg", "price": 2500.0},
      {"title": "Accessories", "image": "assets/images/a5.jpeg", "price": 1000.0},
      {"title": "Accessories", "image": "assets/images/a6.jpeg", "price": 2500.0},
      {"title": "Accessories", "image": "assets/images/a7.jpeg", "price": 1000.0},
      {"title": "Accessories", "image": "assets/images/a8.jpeg", "price": 2500.0},
    ],
    "Beauty": [
      {"title": "Beauty", "image": "assets/images/1.jpeg", "price": 1000.0},
      {"title": "Beauty", "image": "assets/images/2.jpeg", "price": 2500.0},
      {"title": "Beauty", "image": "assets/images/3.jpeg", "price": 1000.0},
      {"title": "Beauty", "image": "assets/images/4.jpeg", "price": 2500.0},
      {"title": "Beauty", "image": "assets/images/5.jpeg", "price": 1000.0},
      {"title": "Beauty", "image": "assets/images/6.jpeg", "price": 2500.0},
      {"title": "Beauty", "image": "assets/images/7.jpeg", "price": 1000.0},
      {"title": "Beauty", "image": "assets/images/8.jpeg", "price": 2500.0},
    ],
    "Bags": [
      {"title": "Bags", "image": "assets/images/Bags1.jpg", "price": 1000.0},
      {"title": "Bags", "image": "assets/images/Bags2.jpg", "price": 2500.0},
      {"title": "Bags", "image": "assets/images/Bags3.jpg", "price": 1000.0},
      {"title": "Bags", "image": "assets/images/Bags4.jpg", "price": 2500.0},
      {"title": "Bags", "image": "assets/images/Bags5.jpg", "price": 1000.0},
      {"title": "Bags", "image": "assets/images/Bags6.jpg", "price": 2500.0},
      {"title": "Bags", "image": "assets/images/Bags7.jpg", "price": 1000.0},
      {"title": "Bags", "image": "assets/images/Bags8.jpg", "price": 2500.0},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final items = products[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0C29),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0C29),
        title: Text(category, style: const TextStyle(color: Colors.white)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75, // Adjusted for better product card look
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _ProductCard(
              context, items[index]["title"], items[index]["image"], items[index]["price"]);
        },
      ),
    );
  }
}
