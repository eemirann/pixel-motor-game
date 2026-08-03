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

- Açılışta dönen şeker animasyonu (WebP, saydam) ve giriş sesi; dokununca
  kayboluyor. Ses ilk dokunuşta çalıyor — mobil tarayıcılar öncesinde izin vermiyor.
- Boru boşluklarında rastgele çarpanlar: **×2 / ×3 / ×5** ve nadiren **bomba**.
  Boruların ~%24'ünde çıkar ve boşluğun ortasına değil bir kenarına yakın durur;
  karşı kenardan geçerek dokunmadan atlatılabilir (toplama yarıçapı görselden dar,
  sıyırmak toplamaz). Çarpan 8 saniye boyunca her boruyu o kadar puan yapar
  (skor altında süre çubuğu), bomba puanı yarıya böler ve çarpanı söndürür.
  Zorluk skora değil geçilen boru sayısına bağlı, çarpanlar oyunu hızlandırmıyor.

- 8 karakterli seçim menüsü (6+ karakterde ızgara 3 sütuna geçer)
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

### Ortak rekor tablosu (Supabase)

Her karakterin rekoru bütün oyunculara aynı görünür ve kalıcıdır. Bağlamak için:

1. `supabase.sql` dosyasını Supabase panelindeki **SQL Editor**'e yapıştırıp çalıştır
   (tablo + sadece rekoru yükselten `submit_score` fonksiyonunu kurar).
2. `index.html` içindeki iki satırı doldur:

   ```js
   const SUPA_URL = "https://xxxxxxxx.supabase.co";
   const SUPA_KEY = "<anon public key>";
   ```

Bunlar boş bırakılırsa oyun eskisi gibi yalnız cihazdaki rekorlarla çalışır; internet
gitse bile menü ve oyun sonu ekranı yerel değerlere düşer, oyun bozulmaz.

Yazma yalnızca `submit_score` üzerinden yapılır: gelen skor mevcut rekordan düşükse
tabloya dokunulmaz, doğrudan insert/update/delete kapalıdır. `anon` anahtarı zaten
herkese açık olacak şekilde tasarlanmıştır, sayfaya gömülmesi normaldir.

### Geliştirme notu

Otomatik test için oyun durumu `window.__flappy` üzerinden okunabilir
(`state`, `score`, `best`, `sel`, `chars`, `bird`, `pipes`, `world`, `flap()`,
`pick(i)`, `goSelect()`). Durumlar: `0 READY, 1 PLAY, 2 DYING, 3 OVER, 4 SELECT`.

Yüz sprite'ları kaynak fotoğraflardan kırpıldı, 64x64'e indirilip pixel-art görünümü
için nearest-neighbor ile büyütüldü ve dairesel maskeyle kesildi.

Yeni karakter eklemek için: sprite'ı `assets/` altına koy, base64'ünü `CHARS`
dizisine `{ name, src }` olarak ekle — menü ızgarası kendini otomatik yeniden dizer.
