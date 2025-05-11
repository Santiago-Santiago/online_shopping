import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_shopping/models/category_model.dart';
import 'package:online_shopping/service/category_service.dart';

class CategoriesWebPage extends StatefulWidget {
  const CategoriesWebPage({super.key});

  @override
  State<CategoriesWebPage> createState() => _CategoriesWebPageState();
}

class _CategoriesWebPageState extends State<CategoriesWebPage> {
  List<Category> categories = [];
  List<Category> displayedCategories = [];
  bool isAscending = true;
  String sortColumn = '';
  int? selectedRow;

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  void loadCategories() async {
    final data = await CategoryService().getAll();
    setState(() {
      categories = data;
      displayedCategories = List.from(categories);
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

      displayedCategories.sort((a, b) {
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

  dynamic _getColumnValue(Category category, String column) {
    switch (column) {
      case 'Código':
        return category.code;
      case 'Tipo':
        return category.type;
      case 'Descripción':
        return category.description;
      case 'Imagen':
        return category.image_url;
      case 'Estado':
        return category.status;
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
                      '  |  Categorias',
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
                                WidgetStateProperty.all(Colors.blue[200]),
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
                            'Tipo',
                            'Descripción',
                            'Imagen',
                            'Estado',
                          ],
                          categories: displayedCategories,
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
  final List<Category> categories;
  final int? selectedRow;
  final Function(int) onRowSelected;
  final Function(String) onSort;
  final String sortColumn;
  final bool isAscending;

  const CustomDataTable({
    Key? key,
    required this.columns,
    required this.categories,
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
        for (int index = 0; index < categories.length; index++)
          buildDataRow(index, categories[index]),
      ],
    );
  }

  TableRow buildDataRow(int index, Category category) {
    final bool isInactive = category.status.toLowerCase() != 'a';
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
        buildDataCell(category.code, index),
        buildDataCell(category.type, index),
        buildDataCell(category.description, index),
        buildDataCell(category.image_url, index),
        buildDataCell(category.status, index),
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
