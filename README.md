# pixel-motor-game
2D pixel motor game developed with Unity and Aseprite assets.

## Flappy Face (mobil web)

`index.html` tek dosyalık, mobil web tarayıcısında oynanan bir Flappy Bird klonu.
Kuşun yerinde fotoğraftan kırpılmış yüz var (`assets/face.png`, sprite HTML'in içine
base64 olarak gömülü — dosyayı tek başına açsan bile çalışır).

### Oynamak

- Dosyayı doğrudan aç: `index.html` (çift tık ya da tarayıcıya sürükle), veya
- yerel sunucu: `python3 -m http.server 8000` → telefondan `http://<bilgisayar-ip>:8000`

Telefonda "Ana Ekrana Ekle" dersen tam ekran uygulama gibi açılır.

### Kontroller

- **Dokun / tıkla / Space** → kanat çırp
- Çarpınca panel açılır, tekrar dokunmak yeni oyun başlatır
- En iyi skor `localStorage`'da saklanır

### Özellikler

- Sabit yükseklikli (640 birim) sanal dünya; her ekran boyutunda aynı zorluk
- `devicePixelRatio` desteği; dar/geniş ekranlarda letterbox, yatay modda da oynanır
- Ardışık boruların dikey farkı sınırlı — her boşluk yetişilebilir mesafede
- Skor arttıkça hızlanan borular, madalya kademeleri (Bronz/Gümüş/Altın/Elmas)
- WebAudio ile çırpma/skor/çarpma sesleri, ölüm flaşı ve ekran sarsıntısı
- Sekme arka plana atılınca oyun ölmez, duraklar
- Sayfa kaydırma, çift dokunuşla yakınlaştırma ve metin seçimi kapalı

### Geliştirme notu

Otomatik test için oyun durumu `window.__flappy` üzerinden okunabilir
(`state`, `score`, `bird`, `pipes`, `world`, `flap()`).

Yüz sprite'ı kaynak fotoğraftan kırpıldı, 64x64'e indirilip pixel-art görünümü için
nearest-neighbor ile büyütüldü ve dairesel maskeyle kesildi.
