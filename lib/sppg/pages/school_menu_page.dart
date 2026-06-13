import 'package:flutter/material.dart';
import '../../models/school_model.dart';

class SchoolMenuPage extends StatefulWidget {
  const SchoolMenuPage({super.key});

  @override
  State<SchoolMenuPage> createState() => _SchoolMenuPageState();
}

class _SchoolMenuPageState extends State<SchoolMenuPage> {
  // Data dummy dari Model
  List<SchoolModel> _schools = [
    SchoolModel(
      id: 'SPPG001',
      name: 'SD Negeri 01 Cikini',
      address: 'Jl. Cikini Raya No. 45, Jakarta Pusat',
      students: 240,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG002',
      name: 'SD Negeri 02 Menteng',
      address: 'Jl. HOS Cokroaminoto No. 12, Jakarta Pusat',
      students: 185,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG003',
      name: 'SD Negeri 03 Gambir',
      address: 'Jl. Medan Merdeka Barat No. 8, Jakarta Pusat',
      students: 210,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG004',
      name: 'SD Negeri 04 Senen',
      address: 'Jl. Kramat Raya No. 56, Jakarta Pusat',
      students: 198,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG005',
      name: 'SD Negeri 05 Tanah Abang',
      address: 'Jl. KH Mas Mansyur No. 23, Jakarta Pusat',
      students: 312,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG006',
      name: 'SD Negeri 06 Johar Baru',
      address: 'Jl. Galur Sari No. 7, Jakarta Pusat',
      students: 167,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG007',
      name: 'SD Negeri 07 Kemayoran',
      address: 'Jl. Kemayoran Gempol No. 34, Jakarta Pusat',
      students: 289,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG008',
      name: 'SD Negeri 08 Sawah Besar',
      address: 'Jl. Mangga Besar No. 18, Jakarta Pusat',
      students: 156,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG009',
      name: 'SD Negeri 09 Cempaka Putih',
      address: 'Jl. Cempaka Putih Raya No. 27, Jakarta Pusat',
      students: 223,
      area: 'Jakarta Pusat',
    ),
    SchoolModel(
      id: 'SPPG010',
      name: 'SD Negeri 10 Pasar Rebo',
      address: 'Jl. Raya Bogor No. 89, Jakarta Timur',
      students: 197,
      area: 'Jakarta Timur',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  List<SchoolModel> get _filteredSchools {
    if (_searchQuery.isEmpty) return _schools;
    return _schools.where((school) {
      return school.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          school.address.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          school.area.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Sekolah Penerima MBG'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addSchool,
            tooltip: 'Tambah Sekolah',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari sekolah...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Statistics Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              color: const Color(0xFFE8F5E9),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(Icons.school, 'Total Sekolah', _schools.length),
                    _buildStatItem(Icons.people, 'Total Siswa', _schools.fold(0, (sum, school) => sum + school.students)),
                    _buildStatItem(Icons.location_city, 'Area', '${_schools.map((s) => s.area).toSet().length} Area'),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // List Data
          Expanded(
            child: _filteredSchools.isEmpty
                ? const Center(child: Text('Tidak ada data sekolah'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredSchools.length,
                    itemBuilder: (context, index) {
                      final school = _filteredSchools[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          school.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'ID: ${school.id}',
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit, color: Color(0xFF2E7D32)),
                                        onPressed: () => _editSchool(school),
                                        tooltip: 'Edit',
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _deleteSchool(school),
                                        tooltip: 'Hapus',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      school.address,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.people, size: 16, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Jumlah Siswa: ${school.students}',
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(width: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E7D32).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Area: ${school.area}',
                                      style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D32)),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchool,
        backgroundColor: const Color(0xFF2E7D32),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label, dynamic value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF2E7D32)),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }

  void _addSchool() {
    // TODO: Implement add school
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur tambah sekolah sedang dalam pengembangan')),
    );
  }

  void _editSchool(SchoolModel school) {
    // TODO: Implement edit school
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${school.name} sedang dalam pengembangan')),
    );
  }

  void _deleteSchool(SchoolModel school) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus ${school.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _schools.removeWhere((s) => s.id == school.id);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${school.name} berhasil dihapus')),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}