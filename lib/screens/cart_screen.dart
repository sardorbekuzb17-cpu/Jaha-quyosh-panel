import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/cart_service.dart';
import '../services/api_service.dart';
import '../widgets/gradient_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
    _cartService.loadCart();
    _cartService.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cartService.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    if (mounted) setState(() {});
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} mln';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ming';
    }
    return price.toStringAsFixed(0);
  }

  Future<void> _sendOrder() async {
    if (_cartService.items.isEmpty) return;

    // Buyurtma dialog oynasi
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) => _OrderDialog(),
    );

    if (result == null) return;

    // Loading ko'rsatish
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Serverga buyurtma yuborish
      final orderData = {
        'customerName': result['name'],
        'customerPhone': result['phone'],
        'items': _cartService.items
            .map((item) => {
                  'name': item.name,
                  'type': item.type,
                  'price': item.price,
                  'quantity': item.quantity,
                })
            .toList(),
        'totalPrice': _cartService.totalPrice,
        'status': 'pending',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await ApiService.createOrder(orderData);

      // Loading yopish
      Navigator.pop(context);

      // Muvaffaqiyat xabari
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Buyurtma muvaffaqiyatli yuborildi!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );

      // Savatni tozalash
      _cartService.clearCart();
    } catch (e) {
      // Loading yopish
      Navigator.pop(context);

      // Xato xabari
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Xato: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0), Colors.white],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shopping_cart,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Savat (${_cartService.itemCount})',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF3B82F6),
                        Color(0xFFFBBF24)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_cartService.items.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: 100, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('Savat bo\'sh',
                          style:
                              TextStyle(fontSize: 20, color: Colors.grey[600])),
                      const SizedBox(height: 8),
                      Text('Mahsulotlarni qo\'shing',
                          style: TextStyle(color: Colors.grey[500])),
                    ],
                  ),
                ),
              )
            else ...[
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        _buildCartItem(_cartService.items[index]),
                    childCount: _cartService.items.length,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: _buildTotalSection()),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Rasm
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: Icon(Icons.solar_power,
                      color: Colors.blue[700], size: 40),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Ma'lumotlar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item.type,
                      style: TextStyle(color: Colors.blue[700], fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_formatPrice(item.price)} so\'m',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Miqdor va o'chirish
            Column(
              children: [
                IconButton(
                  onPressed: () => _cartService.removeItem(item.id, item.type),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  iconSize: 22,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => _cartService.updateQuantity(
                            item.id, item.type, item.quantity - 1),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.remove, size: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('${item.quantity}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      InkWell(
                        onTap: () => _cartService.updateQuantity(
                            item.id, item.type, item.quantity + 1),
                        child: const Padding(
                          padding: EdgeInsets.all(6),
                          child: Icon(Icons.add, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Jami:',
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              Text(
                '${_formatPrice(_cartService.totalPrice)} so\'m',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  text: 'Tozalash',
                  icon: Icons.delete_sweep,
                  gradientColors: const [Colors.red, Colors.redAccent],
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Savatni tozalash'),
                        content: const Text(
                            'Barcha mahsulotlarni o\'chirmoqchimisiz?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Yo\'q')),
                          TextButton(
                            onPressed: () {
                              _cartService.clearCart();
                              Navigator.pop(ctx);
                            },
                            child: const Text('Ha',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: GradientFilledButton(
                  text: 'Buyurtma berish',
                  icon: Icons.send,
                  gradientColors: const [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                  onPressed: _sendOrder,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Buyurtma dialog oynasi
class _OrderDialog extends StatefulWidget {
  @override
  State<_OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<_OrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Buyurtma ma\'lumotlari'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: 'Ismingiz *',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ismingizni kiriting';
                  }
                  if (value.length > 20) {
                    return 'Ism 20 ta belgidan oshmasin';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                maxLength: 9,
                decoration: const InputDecoration(
                  labelText: 'Telefon raqam *',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  hintText: '999999999',
                  counterText: '',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Telefon raqamni kiriting';
                  }
                  if (value.length != 9) {
                    return '9 ta raqam kiriting';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Bekor qilish'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'name': _nameController.text,
                'phone': _phoneController.text,
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Buyurtma berish'),
        ),
      ],
    );
  }
}
