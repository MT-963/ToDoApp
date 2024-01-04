import 'package:flutter/material.dart';
import 'dart:math';

import '../components/CustomAppBar.dart';

class MotivationPage extends StatelessWidget {
  List<String> motivationalQuotes = [
    "Başarılı olmanın anahtarı, kendi içindeki potansiyeli ortaya çıkarmaktır.",
    "Her güne pozitif bir bakış açısıyla başlayın.",
    "Başarı, her düşüşten sonra tekrar ayağa kalkmaktır.",
    "Küçük adımlar, büyük sonuçlara götürebilir.",
    "Hayalinizdeki yaşam için adım atmaya bugün başlayın.",
    "Zorluklar sizi güçlendirir.",
    "Bugün yapabileceğiniz en iyi şeyi yapın ve yarının için endişelenmeyin.",
    "Herkes bir gün çıkış yolunu bulur, bazen senin için en iyi şey beklemektir.",
    "Başarının sırrı, başlamaktır.",
    "Hayatta sadece kaybetmek veya kazanmak yoktur, aynı zamanda öğrenmek vardır.",
    "Zorluklar karşısında cesur olun, çünkü güçlükler sizi daha güçlü kılar.",
    "Unutmayın ki, herkesin bir hikayesi vardır ve sizinki önemlidir.",
    "Hayat, bugün yapabileceğiniz bir dizi küçük kararla şekillenir.",
    "Daima ileriye bakın, geçmişi sadece öğrenmek için kullanın.",
    "Başkalarını motive ederken kendinizi de motive edersiniz.",
    "Başkalarının sizi tanımlamasına izin vermeyin, kendi yolunuzu çizin.",
    "Sınırlarınızı zorlamak, gerçek potansiyelinizi keşfetmenin bir yoludur.",
    "Başarı, elinizdeki imkanlarla yapabileceğiniz en iyisini yapmaktır.",
    "Hayatta ne olursa olsun, her gün için minnettar olun.",
    "İmkansız gibi görünen şeyler, genellikle başlamak için doğru zamanlardır.",
    // ... Diğer motivasyon cümleleri ...
  ];

  final List<String> dailyChallenges = [
    "Write down three things you're grateful for today.",
    "Take a 10-minute walk outside and enjoy nature.",
    "Learn something new today. It could be a new word, a skill, or a fact.",
  ];
  String getRandomQuote(List<String> quotes) {
    Random random = Random();
    int index = random.nextInt(quotes.length);
    return quotes[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Günün Motiavsyonu:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              getRandomQuote(
                  motivationalQuotes), // Display the first quote (you can randomize or cycle through them)
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
