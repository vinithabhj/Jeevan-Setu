// lib/main.dart - A visually enhanced version

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui'; // Needed for image filters

// --- CONFIGURATION ---
const String apiUrl = "http://localhost:8000";
// ---------------------

// --- UI ENHANCEMENT: Defining a professional color palette ---
class AppColors {
  static const Color primary = Color(0xFFD32F2F); // A deep, trustworthy red
  static const Color primaryLight = Color(0xFFFFCDD2);
  static const Color accent = Color(0xFF0D47A1); // A strong, calming blue
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);
  static const Color background = Color(0xFFF5F5F5);
  static const Color success = Color(0xFF2E7D32); // A reassuring green
}

void main() {
  runApp(const JeevanSetuApp());
}

class JeevanSetuApp extends StatelessWidget {
  const JeevanSetuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeevan-Setu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

// --- UI ENHANCEMENT: A more visually appealing entry screen ---
class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ignore: deprecated_member_use
            colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.bloodtype, color: Colors.white, size: 80),
                  const SizedBox(height: 10),
                  const Text(
                    'Jeevan-Setu',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const Text(
                    'The Bridge of Life',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primaryLight,
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildRoleButton(
                    context,
                    icon: Icons.family_restroom,
                    label: "I'm a Patient's Family",
                    color: AppColors.accent,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientDashboard()));
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildRoleButton(
                    context,
                    icon: Icons.volunteer_activism,
                    label: "I'm a Donor",
                    color: AppColors.success,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const DonorDashboard()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: Colors.white,
        minimumSize: const Size(280, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
    );
  }
}

// --- UI ENHANCEMENT: A redesigned patient dashboard ---
class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  late Future<Map<String, dynamic>> patientData;

  @override
  void initState() {
    super.initState();
    patientData = fetchPatientData();
  }

  Future<Map<String, dynamic>> fetchPatientData() async {
    final response = await http.get(Uri.parse('$apiUrl/patients/1'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load patient data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient Dashboard")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: patientData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}\n\nIs the backend server running?"));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text("Welcome, Mr. Sharma", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                const SizedBox(height: 20),
                _buildTransfusionCard(data),
                const SizedBox(height: 20),
                _buildPodCard(data),
              ],
            );
          }
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }

  Widget _buildTransfusionCard(Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColors.accent, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Next Transfusion for ${data['patientName']}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white70)),
            const SizedBox(height: 10),
            Text(data['nextTransfusionDate'], style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text("at ${data['hospitalName']}", style: const TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text("Status: ${data['statusMessage']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.shield, color: AppColors.primary, size: 30),
          ),
          title: Text("Your Warrior Pod", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
          subtitle: Text("${data['podName']}\nStrength: ${data['podStatus']}", style: TextStyle(color: AppColors.textLight)),
          isThreeLine: true,
        ),
      ),
    );
  }
}

// --- UI ENHANCEMENT: A redesigned donor dashboard ---
class DonorDashboard extends StatefulWidget {
  const DonorDashboard({super.key});

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  late Future<Map<String, dynamic>> donorData;

  @override
  void initState() {
    super.initState();
    donorData = fetchDonorData();
  }

  Future<Map<String, dynamic>> fetchDonorData() async {
    final response = await http.get(Uri.parse('$apiUrl/donors/101'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load donor data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donor Dashboard")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: donorData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}\n\nIs the backend server running?"));
          } else if (snapshot.hasData) {
            var data = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text("Hello, ${data['donorName']}!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                Text(data['greeting'], style: TextStyle(fontSize: 16, color: AppColors.textLight)),
                const SizedBox(height: 20),
                _buildEligibilityCard(),
                const SizedBox(height: 20),
                _buildImpactCard(data),
                const SizedBox(height: 20),
                _buildPodNewsCard(data),
              ],
            );
          }
          return const Center(child: Text("No data available."));
        },
      ),
    );
  }

  Widget _buildEligibilityCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [AppColors.primary, Colors.red.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const Text("You are eligible to donate!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              icon: const Icon(Icons.bloodtype),
              label: const Text("Find a Camp / Book Slot"),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImpactCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImpactItem(Icons.favorite, "${data['livesSaved']} Lives Saved", Colors.pink),
            _buildImpactItem(Icons.military_tech, "${data['donationCount']} Donations", Colors.amber.shade700),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
      ],
    );
  }

  Widget _buildPodNewsCard(Map<String, dynamic> data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your Warrior Pod News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.textDark)),
            const Divider(height: 20),
            Text(data['podNews'], style: TextStyle(fontSize: 16, color: AppColors.textLight, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
