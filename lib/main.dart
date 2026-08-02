import 'package:flutter/material.dart';

void main() {
  runApp(const RiderApp());
}

class RiderApp extends StatelessWidget {
  const RiderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery Rider App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.amber,
      ),
      home: const RiderDashboard(),
    );
  }
}

class RiderDashboard extends StatefulWidget {
  const RiderDashboard({super.key});

  @override
  State<RiderDashboard> createState() => _RiderDashboardState();
}

class _RiderDashboardState extends State<RiderDashboard> {
  bool isOnline = false;
  String selectedLanguage = 'English';
  bool hasNewOrder = false;
  bool isOnDelivery = false;

  final Map<String, Map<String, String>> translations = {
    'English': {
      'title': 'Rider Dashboard',
      'online': 'You are Online',
      'offline': 'You are Offline',
      'toggleText': 'Toggle to start or end your shift',
      'earnings': "Today's Earnings",
      'simulateOrder': 'Simulate New Order',
      'incomingOrder': 'New Order Received!',
      'restaurant': 'Restaurant: Pizzeria Bella Italia',
      'dropoff': 'Drop-off: Via Roma 15',
      'price': 'Earnings: € 7.50',
      'accept': 'ACCEPT',
      'decline': 'DECLINE',
      'activeDelivery': 'Active Delivery in Progress',
      'headToRestaurant': 'Head to Restaurant for Pickup',
      'completeOrder': 'Complete Order & Collect € 7.50',
    },
    'Italian': {
      'title': 'Dashboard Rider',
      'online': 'Sei Online',
      'offline': 'Sei Offline',
      'toggleText': 'Attiva o disattiva il turno',
      'earnings': 'Guadagni di Oggi',
      'simulateOrder': 'Simula Nuovo Ordine',
      'incomingOrder': 'Nuovo Ordine Ricevuto!',
      'restaurant': 'Ristorante: Pizzeria Bella Italia',
      'dropoff': 'Consegna: Via Roma 15',
      'price': 'Guadagno: € 7.50',
      'accept': 'ACCETTA',
      'decline': 'RIFIUTA',
      'activeDelivery': 'Consegna Attiva in Corso',
      'headToRestaurant': 'Vai al Ristorante per il Ritiro',
      'completeOrder': 'Completa Ordine e Incassa € 7.50',
    },
    'Urdu': {
      'title': 'رائڈر ڈیش بورڈ',
      'online': 'آپ آن لائن ہیں',
      'offline': 'آپ آف لائن ہیں',
      'toggleText': 'شفٹ شروع یا ختم کرنے کے لیے ٹگل کریں',
      'earnings': 'آج کی کمائی',
      'simulateOrder': 'نیا آرڈر منگوائیں',
      'incomingOrder': 'نیا آرڈر موصول ہوا!',
      'restaurant': 'ریسٹورেন্ট: Pizzeria Bella Italia',
      'dropoff': 'ڈراپ آف: Via Roma 15',
      'price': 'کمائی: € 7.50',
      'accept': 'قبول کریں',
      'decline': 'رد کریں',
      'activeDelivery': 'جاری آرڈر',
      'headToRestaurant': 'ریسٹورেন্ট سے آرڈر لینے جائیں',
      'completeOrder': 'آرڈر مکمل کریں اور € 7.50 حاصل کریں',
    },
    'Bengali': {
      'title': 'রাইডার ড্যাশবোর্ড',
      'online': 'আপনি অনলাইন আছেন',
      'offline': 'আপনি অফলাইন আছেন',
      'toggleText': 'শিফট শুরু বা শেষ করতে টগল করুন',
      'earnings': 'আজকের উপার্জন',
      'simulateOrder': 'নতুন অর্ডার সিমুলেট করুন',
      'incomingOrder': 'নতুন অর্ডার এসেছে!',
      'restaurant': 'রেস্তোরাঁ: Pizzeria Bella Italia',
      'dropoff': 'ড্রপ-অফ: Via Roma 15',
      'price': 'উপার্জন: € 7.50',
      'accept': 'গ্রহণ',
      'decline': 'বাতিল',
      'activeDelivery': 'চলমান অর্ডার',
      'headToRestaurant': 'রেস্তোরাঁ থেকে খাবার নিন',
      'completeOrder': 'অর্ডার সম্পন্ন করুন (€ 7.50)',
    },
  };

  @override
  Widget build(context) {
    String t(String key) => translations[selectedLanguage]?[key] ?? translations['English']![key]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('title'), style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF1F1F1F),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              value: selectedLanguage,
              dropdownColor: const Color(0xFF2C2C2C),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              underline: Container(),
              items: ['English', 'Italian', 'Urdu', 'Bengali']
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (newLang) {
                setState(() {
                  selectedLanguage = newLang!;
                });
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isOnDelivery) ...[
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.greenAccent, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('activeDelivery'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFF121212),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade800),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.map, size: 40, color: Colors.amberAccent),
                              SizedBox(height: 8),
                              Text(
                                "Live Map Navigation (GPS Route)",
                                style: TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(t('restaurant'), style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text(t('dropoff'), style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            isOnDelivery = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Completed! € 7.50 added to earnings.')),
                          );
                        },
                        child: Text(
                          t('completeOrder'),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color: isOnline ? Colors.greenAccent : Colors.grey.shade800,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        isOnline ? t('online') : t('offline'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isOnline ? Colors.greenAccent : Colors.redAccent,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Switch(
                        value: isOnline,
                        activeColor: Colors.greenAccent,
                        onChanged: (value) {
                          setState(() {
                            isOnline = value;
                            if (!value) hasNewOrder = false;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t('toggleText'),
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade800, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('earnings'),
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "€ 0.00",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isOnline && !hasNewOrder)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      hasNewOrder = true;
                    });
                  },
                  child: Text(
                    t('simulateOrder'),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              if (hasNewOrder) ...[
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A1B00),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amberAccent, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t('incomingOrder'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.amberAccent,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(t('restaurant'), style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 5),
                        Text(t('dropoff'), style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 5),
                        Text(t('price'), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.greenAccent)),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade800,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hasNewOrder = false;
                                  });
                                },
                                icon: const Icon(Icons.close),
                                label: Text(t('decline')),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade700,
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hasNewOrder = false;
                                    isOnDelivery = true;
                                  });
                                },
                                icon: const Icon(Icons.check),
                                label: Text(t('accept')),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
