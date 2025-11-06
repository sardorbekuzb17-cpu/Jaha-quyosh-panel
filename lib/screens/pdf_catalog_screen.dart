import 'package:flutter/material.dart';
import 'pdf_viewer_screen.dart';

class PdfCatalogScreen extends StatelessWidget {
  const PdfCatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Quyosh panellari
    final panelPdfs = [
      {
        'title': 'HiMoX10 Sighntist 630-650W',
        'path':
            'assets/HiMoX10_Sighntist_LR_7_72_HVH_630_650_M_30_30_and_15_Explorer_BGV.pdf',
        'description': '630-650W quvvatli yuqori samaradorlikdagi panel',
        'icon': Icons.solar_power,
        'color': Colors.orange,
      },
      {
        'title': 'ISOLA Topcon 580-590W',
        'path': 'assets/ISOLA Topcon-580W-590W-2279X1134X30.pdf',
        'description': '580-590W Topcon texnologiyali panel',
        'icon': Icons.wb_sunny,
        'color': Colors.amber,
      },
      {
        'title': 'LR7 Guardian 640-670W',
        'path':
            'assets/LR7_72HVHF_640_670M_（30_30&15框）_Guardian_BGV02_20250313_EN.pdf',
        'description': '640-670W Guardian seriyasi',
        'icon': Icons.energy_savings_leaf,
        'color': Colors.green,
      },
      {
        'title': 'ERA RC66HD',
        'path': 'assets/era-rc66hd.pdf',
        'description': 'ERA RC66HD panel ma\'lumotlari',
        'icon': Icons.solar_power,
        'color': Colors.teal,
      },
    ];

    // Inverterlar
    final inverterPdfs = [
      {
        'title': 'Sungrow 10kW',
        'path': 'assets/sungrow 10kw.PDF',
        'description': '10kW quvvatli inverter',
        'icon': Icons.electrical_services,
        'color': Colors.blue,
      },
      {
        'title': 'Sungrow 15kW',
        'path': 'assets/sungrow 15kw.pdf',
        'description': '15kW quvvatli inverter',
        'icon': Icons.electrical_services,
        'color': Colors.indigo,
      },
      {
        'title': 'Sungrow 50kW',
        'path': 'assets/sungrow 50kw.pdf',
        'description': '50kW quvvatli inverter',
        'icon': Icons.electrical_services,
        'color': Colors.purple,
      },
      {
        'title': 'Sungrow 110kW',
        'path': 'assets/sungrow 110kw.pdf',
        'description': '110kW quvvatli inverter',
        'icon': Icons.electrical_services,
        'color': Colors.deepPurple,
      },
      {
        'title': 'SG25-33CX-P2',
        'path': 'assets/DS_20250520_SG25_30_33CX-P2_Datasheet_EN(UZ).pdf',
        'description': 'SG25-33CX-P2 texnik ma\'lumotlari',
        'icon': Icons.electrical_services,
        'color': Colors.cyan,
      },
      {
        'title': 'SG36-50CX-P2',
        'path': 'assets/DS_20250520_SG36_40_50CX-P2 Datasheet_EN(UZ).pdf',
        'description': 'SG36-50CX-P2 texnik ma\'lumotlari',
        'icon': Icons.electrical_services,
        'color': Colors.lightBlue,
      },
      {
        'title': 'SG110CX-P2',
        'path': 'assets/DS_20250520_SG110CX-P2_Datasheet_EN(UZ).pdf',
        'description': 'SG110CX-P2 texnik ma\'lumotlari',
        'icon': Icons.electrical_services,
        'color': Colors.blueGrey,
      },
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange[50]!,
              Colors.yellow[50]!,
              Colors.white,
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Chiroyli AppBar
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: Colors.orange[700],
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Katalog',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange[400]!,
                        Colors.yellow[600]!,
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Quyosh nuri effekti
                      Positioned(
                        top: -50,
                        right: -50,
                        child: Icon(
                          Icons.wb_sunny,
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.picture_as_pdf,
                              size: 40,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Texnik Ma\'lumotlar',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Quyosh Panellari bo'limi
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange[400]!, Colors.yellow[600]!],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.solar_power,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Quyosh Panellari',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pdf = panelPdfs[index];
                    return _buildPdfCard(context, pdf);
                  },
                  childCount: panelPdfs.length,
                ),
              ),
            ),
            // Inverterlar bo'limi
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue[600]!, Colors.indigo[600]!],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.electrical_services,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Inverterlar',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pdf = inverterPdfs[index];
                    return _buildPdfCard(context, pdf);
                  },
                  childCount: inverterPdfs.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfCard(BuildContext context, Map<String, dynamic> pdf) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            (pdf['color'] as Color).withValues(alpha: 0.05),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (pdf['color'] as Color).withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfViewerScreen(
                  pdfPath: pdf['path'],
                  title: pdf['title'],
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon with gradient
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        (pdf['color'] as Color).withValues(alpha: 0.8),
                        pdf['color'] as Color,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: (pdf['color'] as Color).withValues(alpha: 0.3),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    pdf['icon'],
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pdf['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        pdf['description'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Arrow with circle
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (pdf['color'] as Color).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: pdf['color'],
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
