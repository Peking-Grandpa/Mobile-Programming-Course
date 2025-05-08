import 'package:flutter/material.dart';

// 商品模型
class Item {
  final String name;
  final double price;
  final String imagePath;
  final String category; // All, Shirts, Hoodies, Caps
  Item(this.name, this.price, this.imagePath, this.category);
}

// 购物车项：绑定商品 + 选中尺码
class CartItem {
  final Item item;
  final String size;
  CartItem(this.item, this.size);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 当前 Tab 索引
  int _currentIndex = 0;
  // 当前分类
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Shirts', 'Hoodies', 'Caps'];

  // 全部商品（文件名必须和 assets/ 下保持一致）
  final List<Item> _allItems = [
    Item('Canada T-Shirt 1', 19.99, 'assets/TshirtCanada1.jpg', 'Shirts'),
    Item('Canada T-Shirt 2', 17.99, 'assets/TshirtCanada2.jpg', 'Shirts'),
    Item('Canada T-Shirt 3', 15.99, 'assets/TshirtCanada3.jpg', 'Shirts'),
    Item('Cozy Hoodie 1',    29.99, 'assets/HoodieCanada1.jpg','Hoodies'),
    Item('Cozy Hoodie 2',    32.50, 'assets/HoodieCanada2.jpg','Hoodies'),
    Item('Cozy Hoodie 3',    35.50, 'assets/HoodieCanada3.jpg','Hoodies'),
    Item('Cool Cap 1',       12.00, 'assets/CapCanada1.jpg',   'Caps'),
    Item('Cool Cap 2',       10.99, 'assets/CapCanada2.jpg',   'Caps'),
    Item('Cool Cap 3',       14.99, 'assets/CapCanada3.jpg',   'Caps'),
  ];

  // 购物车列表
  final List<CartItem> _cart = [];

  // 根据分类过滤
  List<Item> get _filteredItems {
    if (_selectedCategory == 'All') return _allItems;
    return _allItems
        .where((it) => it.category == _selectedCategory)
        .toList();
  }

  // 计算总价
  double get _totalPrice =>
      _cart.fold(0.0, (sum, ci) => sum + ci.item.price);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canada Wardrobe',
      debugShowCheckedModeBanner: false, // 去掉右上角 DEBUG
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        appBar: AppBar(
          // 左上角 logo
          leading: Padding(
            padding: EdgeInsets.all(8),
            child: Image.asset(
              'assets/logo1.png',
              width: 30,
              height: 30,
              fit: BoxFit.contain,
            ),
          ),
          // 根据 Tab 动态展示标题
          title: Text(
            _currentIndex == 0
                ? 'Canada Day Sale On Now'
                : 'Canada Wardrobe',
            style: TextStyle(
              fontSize: _currentIndex == 0 ? 16 : 20,
              fontWeight: _currentIndex == 0
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          ),
        ),

        // 主体：Products / Cart
        body: _currentIndex == 0
            ? _buildProductsPage()
            : _buildCartPage(),

        // 底部导航
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.store), label: 'Products'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart (${_cart.length})'),
          ],
        ),
      ),
    );
  }

  // 商品页 Layout
  Widget _buildProductsPage() {
    return Column(
      children: [
        // 分类 Chip
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8),
            children: _categories.map((cat) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(cat),
                  selected: _selectedCategory == cat,
                  onSelected: (_) {
                    setState(() => _selectedCategory = cat);
                  },
                ),
              );
            }).toList(),
          ),
        ),
        Divider(height: 1),

        // 商品网格
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
              MediaQuery.of(context).size.width > 600 ? 3 : 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: _filteredItems.length,
            itemBuilder: (ctx, i) {
              final it = _filteredItems[i];
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  // 跳转到详情，返回 CartItem（含 size）
                  final cartItem = await Navigator.push<CartItem>(
                    ctx,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(item: it),
                    ),
                  );
                  if (cartItem != null) {
                    setState(() => _cart.add(cartItem));
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    children: [
                      // 图片
                      Expanded(
                        child: Image.asset(
                          it.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey[400]),
                        ),
                      ),
                      SizedBox(height: 4),
                      // 分类灰字
                      Center(
                        child: Text(
                          it.category,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(height: 4),
                      // 名称
                      Center(
                        child: Text(
                          it.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      // 价格
                      Center(
                        child: Text(
                          '\$${it.price.toStringAsFixed(2)}',
                        ),
                      ),
                      SizedBox(height: 4),
                      // 直接 Add (默认 M 码)
                      Center(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() =>
                                _cart.add(CartItem(it, 'M')));
                          },
                          child: Text('Add'),
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //购物车页 Cart Layout
  Widget _buildCartPage() {
    return Column(
      children: [
        // Subtotal + Checkout
        if (_cart.isNotEmpty)
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  'Subtotal:',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 8),
                Text(
                  '\$${_totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // 可链接到“Checkout”流程
                  },
                  child: Text('Checkout'),
                )
              ],
            ),
          ),

        Divider(height: 1),

        // 列表
        Expanded(
          child: _cart.isEmpty
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
            itemCount: _cart.length,
            itemBuilder: (ctx, i) {
              final ci = _cart[i];
              return ListTile(
                leading: Image.asset(
                  ci.item.imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(Icons.image_not_supported,
                          color: Colors.grey[400]),
                ),
                title: Text(ci.item.name),
                subtitle: Text(
                    'Size: ${ci.size}   •   \$${ci.item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() => _cart.removeAt(i));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// 详情页：Detailed page 选码 Size + Add
class DetailPage extends StatefulWidget {
  final Item item;
  DetailPage({required this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String _size = 'M';
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset(
              widget.item.imagePath,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Icon(Icons.image_not_supported,
                      size: 80, color: Colors.grey[400]),
            ),
            SizedBox(height: 16),
            Text(widget.item.name,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            Text('\$${widget.item.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 16),

            // 尺码选择
            Wrap(
              spacing: 8,
              children: _sizes.map((s) {
                return ChoiceChip(
                  label: Text(s),
                  selected: _size == s,
                  onSelected: (_) {
                    setState(() => _size = s);
                  },
                );
              }).toList(),
            ),

            Spacer(),

            // 加入购物车
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Add to Cart'),
                onPressed: () {
                  // 返回含尺码信息的 CartItem
                  Navigator.pop(
                      context, CartItem(widget.item, _size));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
