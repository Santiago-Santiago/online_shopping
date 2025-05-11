import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWeb extends StatelessWidget {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barra superior
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50,
              color: Colors.lightBlue,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text(
                'Mi tienda',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Contenido principal
          Expanded(
            child: Row(
              children: [
                // Sidebar
                Container(
                  width: 250,
                  color: Colors.lightBlue[300],
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Buscador
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.search, size: 28),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Buscar...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Menú
                      TextButton(
                          onPressed: () {
                            context.go('/products');
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.label_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              const Text(
                                '  Productos',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                      TextButton(
                          onPressed: () {
                            context.go('/categories');
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.label_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              const Text(
                                '  Categorías',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.label_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              const Text(
                                '  Precios',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.label_outlined,
                                color: Colors.white,
                                size: 22,
                              ),
                              const Text(
                                '  Stocks',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                // Área de contenido
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 40,
                    children: [
                      InkWell(
                        onTap: () {
                          context.go('/products');
                        },
                        child: Chip(
                          side: BorderSide.none,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                color: Colors.lightBlue[300],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/products.png',
                                    width: 96,
                                    height: 96,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Productos',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/price');
                        },
                        child: Chip(
                          side: BorderSide.none,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                color: Colors.lightBlue[300],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/price.png',
                                    width: 96,
                                    height: 96,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Precios',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/stock');
                        },
                        child: Chip(
                          side: BorderSide.none,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                color: Colors.lightBlue[300],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/stock.png',
                                    width: 96,
                                    height: 96,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Stocks',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.go('/categories');
                        },
                        child: Chip(
                          side: BorderSide.none,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 15,
                                color: Colors.lightBlue[300],
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    'assets/images/categories.png',
                                    width: 96,
                                    height: 96,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Categorías',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WebTile extends StatelessWidget {
  final IconData icon;
  final String label;

  const WebTile({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 60),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
