import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shopping/models/product_model.dart';
import 'package:online_shopping/service/product_service.dart';

class ProductsWebPage extends StatefulWidget {
  const ProductsWebPage({super.key});

  @override
  State<ProductsWebPage> createState() => _ProductsWebPageState();
}

class _ProductsWebPageState extends State<ProductsWebPage> {
  List<Product> products = [];
  List<Product> displayedProducts = [];
  bool isAscending = true;
  String sortColumn = '';
  int? selectedRow;

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  void loadProducts() async {
    final data = await ProductService().getAllProducts();
    setState(() {
      products = data;
      displayedProducts = List.from(products);
    });
  }

  void sortTable(String column) {
    setState(() {
      if (column == sortColumn) {
        isAscending = !isAscending;
      } else {
        sortColumn = column;
        isAscending = true;
      }

      displayedProducts.sort((a, b) {
        final aValue = _getColumnValue(a, column);
        final bValue = _getColumnValue(b, column);

        if (isAscending) {
          return Comparable.compare(aValue, bValue);
        } else {
          return Comparable.compare(bValue, aValue);
        }
      });
    });
  }

  dynamic _getColumnValue(Product product, String column) {
    switch (column) {
      case 'Código':
        return product.product_code;
      case 'Descripción':
        return product.description;
      case 'Unidad':
        return product.sales_unit;
      case 'Categoría':
        return product.category_code;
      case 'Subcategoría':
        return product.subcategory_code;
      case 'Contenido':
        return product.unit_content;
      case 'Info adicional':
        return product.additional_info;
      case 'Estado':
        return product.status;
      case 'Moneda':
        return product.currency;
      case 'Valor venta':
        return product.sale_value;
      case 'IGV':
        return product.tax_rate;
      case 'Precio venta':
        return product.sale_price;
      default:
        return '';
    }
  }

  void toggleSelection(int index) {
    setState(() {
      if (selectedRow == index) {
        selectedRow = null;
      } else {
        selectedRow = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final tableWidth = screenWidth * 1.5;

    return Scaffold(
      body: Column(
        children: [
          // Barra superior
          Container(
            height: 70,
            color: Colors.lightBlue,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.replace('/');
                      },
                      child: const Text(
                        'Mi tienda',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Text(
                      '  |  Productos',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                // Buscador
                Container(
                  width: 250,
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
              ],
            ),
          ),
          Expanded(
            child: RawScrollbar(
              controller: _horizontalScrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 15,
              radius: const Radius.circular(8),
              thumbColor: Colors.blue.withOpacity(0.6),
              minThumbLength: 100,
              child: SingleChildScrollView(
                controller: _horizontalScrollController,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  width: tableWidth,
                  child: RawScrollbar(
                    controller: _verticalScrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 15,
                    radius: const Radius.circular(8),
                    thumbColor: Colors.blue.withOpacity(0.6),
                    child: SingleChildScrollView(
                      controller: _verticalScrollController,
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dataTableTheme: DataTableThemeData(
                            headingTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            dataTextStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            headingRowColor:
                                MaterialStateProperty.all(Colors.blue[200]),
                            dataRowMinHeight: 60,
                            dataRowMaxHeight: 60,
                            columnSpacing: 20,
                            horizontalMargin: 20,
                          ),
                        ),
                        // IMPORTANTE: Aquí usamos un widget personalizado en lugar de DataTable
                        child: CustomDataTable(
                          columns: [
                            'Código',
                            'Descripción',
                            'Unidad',
                            'Categoría',
                            'Subcategoría',
                            'Contenido',
                            'Info adicional',
                            'Estado',
                            'Moneda',
                            'Valor venta',
                            'IGV',
                            'Precio venta',
                          ],
                          products: displayedProducts,
                          selectedRow: selectedRow,
                          onRowSelected: toggleSelection,
                          onSort: sortTable,
                          sortColumn: sortColumn,
                          isAscending: isAscending,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget personalizado para la tabla de datos
class CustomDataTable extends StatelessWidget {
  final List<String> columns;
  final List<Product> products;
  final int? selectedRow;
  final Function(int) onRowSelected;
  final Function(String) onSort;
  final String sortColumn;
  final bool isAscending;

  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.products,
    required this.selectedRow,
    required this.onRowSelected,
    required this.onSort,
    required this.sortColumn,
    required this.isAscending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder(
        horizontalInside: BorderSide(
          width: 1,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      columnWidths: {
        0: const FixedColumnWidth(50), // Columna de checkbox
        for (int i = 0; i < columns.length; i++) i + 1: const FlexColumnWidth(),
      },
      children: [
        // Encabezado de la tabla
        TableRow(
          decoration: BoxDecoration(
            color: Colors.blue[200],
          ),
          children: [
            // Celda para el checkbox en el encabezado
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: const Icon(Icons.check_box_outline_blank,
                  color: Colors.transparent),
            ),
            // Encabezados de columnas
            for (int i = 0; i < columns.length; i++)
              GestureDetector(
                onTap: () => onSort(columns[i]),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        columns[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      if (sortColumn == columns[i])
                        Icon(
                          isAscending
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          size: 16,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        // Filas de datos
        for (int index = 0; index < products.length; index++)
          buildDataRow(index, products[index]),
      ],
    );
  }

  TableRow buildDataRow(int index, Product product) {
    final bool isInactive = product.status.toLowerCase() != 'a';
    final Color backgroundColor = isInactive
        ? Colors.red[200]!
        : (index % 2 == 0 ? Colors.blue[50]! : Colors.blue[100]!);
    final bool isSelected = selectedRow == index;

    return TableRow(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      children: [
        // Celda para el checkbox
        GestureDetector(
          onTap: () => onRowSelected(index),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            alignment: Alignment.center,
            child: Checkbox(
              value: isSelected,
              onChanged: (_) => onRowSelected(index),
            ),
          ),
        ),
        // Celdas de datos
        buildDataCell(product.product_code, index),
        buildDataCell(product.description, index),
        buildDataCell(product.sales_unit, index),
        buildDataCell(product.category_code, index),
        buildDataCell(product.subcategory_code, index),
        buildDataCell(product.unit_content, index),
        buildDataCell(product.additional_info, index),
        buildDataCell(product.status, index),
        buildDataCell(product.currency, index),
        buildDataCell(product.sale_value.toStringAsFixed(2), index),
        buildDataCell(product.tax_rate.toStringAsFixed(2), index),
        buildDataCell(product.sale_price.toStringAsFixed(2), index),
      ],
    );
  }

  Widget buildDataCell(String text, int rowIndex) {
    return GestureDetector(
      onTap: () => onRowSelected(rowIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
