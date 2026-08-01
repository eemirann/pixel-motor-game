# pixel-motor-game
2D pixel motor game developed with Unity and Aseprite assets.

## Flappy Face (mobil web)

`index.html` tek dosyalık, mobil web tarayıcısında oynanan bir Flappy Bird klonu.
Kuşun yerinde fotoğraftan kırpılmış yüzler var: açılışta **"HANGİ LUBUNYAYI
SEÇİYORSUN"** menüsünden 5 karakterden biri seçiliyor (`assets/char1..5.png`,
sprite'lar HTML'in içine base64 olarak gömülü — dosyayı tek başına açsan bile çalışır).

### Oynamak

- Dosyayı doğrudan aç: `index.html` (çift tık ya da tarayıcıya sürükle), veya
- yerel sunucu: `python3 -m http.server 8000` → telefondan `http://<bilgisayar-ip>:8000`

Telefonda "Ana Ekrana Ekle" dersen tam ekran uygulama gibi açılır.

### Kontroller

- Açılışta bir karaktere dokun (Space seçiliyi onaylar)
- **Dokun / tıkla / Space** → kanat çırp
- Çarpınca panel açılır, tekrar dokunmak yeni oyun başlatır
- Başlangıç ve oyun sonu ekranındaki **KARAKTER DEĞİŞTİR** ile menüye dönülür
- Seçilen karakter ve **karakter başına** en iyi skor `localStorage`'da saklanır

### Özellikler

- 5 karakterli seçim menüsü; her karakterin kendi rekoru
- Karaktere özel sesler: `sfx` çırpma, `dsfx` ölüm sesi. Menüde ♪ rozetiyle
  işaretli. Karakteri seçince de sesi çalıyor (varsa ölüm sesi, yoksa çırpma
  sesi); sesi olmayan karakterlerde klasik bip devrede. Sesler açılışta
  decode ediliyor, ilk seçimde bile gecikme yok. Ölüm sesi yeni oyuna sarkmıyor.
  Tüm kayıtların baş/son/ara sessizlikleri `silenceremove` ile temizlendi.
- Sabit yükseklikli (640 birim) sanal dünya; her ekran boyutunda aynı zorluk
- `devicePixelRatio` desteği; dar/geniş ekranlarda letterbox, yatay modda da oynanır
- Ardışık boruların dikey farkı sınırlı — her boşluk yetişilebilir mesafede
- Skor arttıkça hızlanan borular, madalya kademeleri (Bronz/Gümüş/Altın/Elmas)
- WebAudio ile çırpma/skor/çarpma sesleri, ölüm flaşı ve ekran sarsıntısı
- Sekme arka plana atılınca oyun ölmez, duraklar
- Sayfa kaydırma, çift dokunuşla yakınlaştırma ve metin seçimi kapalı

### Geliştirme notu

Otomatik test için oyun durumu `window.__flappy` üzerinden okunabilir
(`state`, `score`, `best`, `sel`, `chars`, `bird`, `pipes`, `world`, `flap()`,
`pick(i)`, `goSelect()`). Durumlar: `0 READY, 1 PLAY, 2 DYING, 3 OVER, 4 SELECT`.

Yüz sprite'ları kaynak fotoğraflardan kırpıldı, 64x64'e indirilip pixel-art görünümü
için nearest-neighbor ile büyütüldü ve dairesel maskeyle kesildi.

Yeni karakter eklemek için: sprite'ı `assets/` altına koy, base64'ünü `CHARS`
dizisine `{ name, src }` olarak ekle — menü ızgarası kendini otomatik yeniden dizer.
