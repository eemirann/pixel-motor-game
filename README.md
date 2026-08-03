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

- **Bonus turu** (BAĞIMLI'ya özel): yıldız taşıyan boru **altın sarısı** görünür,
  boru başına ~%2 çıkar; yıldızı toplayınca giriş sesi çalar ve 20 saniyelik şeker
  yağmuru başlar. Borular kaybolur, gökyüzü
  şeker moduna geçer, ölüm yoktur (zemine değince sekersin). Her çırpış +1 puan
  (çarpandan bağımsız, düz 1), şeker +1, altın şeker +5. Yalnız bonusta çıkan
  çarpan küreleri şeker başına puanı çarpar (bunlar da birikir): ×2 (%56), ×3 (%28),
  ×10 (%11), ×25 (%4), ×50 (%1) — büyükler parlayarak belli olur. Süre bitince borular kuşun önünde yeniden dizilir, skor korunur ve
  hız ilk hâline döner.
- **BUKLE'ye özel — fırtına bonusu**: aynı altın boru/yıldız sistemiyle açılır.
  Gökyüzü maviye döner, tepedeki bulut aşağı **yıldırım** savurur (hepsi kuşun
  sütununa doğru gelir, yoksa toplanamazdı). Yıldırım +1, altın yıldırım +5,
  çırpış +1. Çarpanlar burada **birikir**: aldıkça toplanır (×2 + ×10 = ×12,
  tavan ×25), tur boyunca durur ve kuşun üstünde rozet olarak dizilir; toplam HUD'da yazar.
- **BAĞIMLI'ya özel** (karakterdeki `candy: true` bayrağı):
  - Seçilince dönen şeker animasyonu (saydam WebP) + giriş sesi; 2.6 sn sonra
    kendiliğinden kapanır, dokununca hemen geçilir. Diğer karakterler doğrudan
    oyuna girer, ana ekran seçim menüsüdür.
  - Boru boşluklarında rastgele çarpanlar: **×2 / ×3 / ×5**, arada bir mevcut
    çarpanı ikiye **katlayan** pembe çift halkalı küre (×2 → ×4 → ×8, tavan ×25)
    ve nadiren **bomba**.
    Boruların ~%18'inde çıkar ve boşluğun ortasına değil bir kenarına yakın
    durur; karşı kenardan geçerek dokunmadan atlatılabilir (toplama yarıçapı
    görselden dar, sıyırmak toplamaz). Çarpan her boruyu o kadar
    puan yapar. Çarpanlar **birikir**: süreyle sönmez, üstüne toplanır (×2 + ×3 =
    ×5, tavan ×25) ve yalnız yeni oyun başlayınca ya da bombaya çarpınca sıfırlanır.
    Bonusa girip çıkarken de korunur. Bomba yalnız skor 2'ye tam bölünürken
    çıkar; boru üretildikten sonra skor tekleşmişse patlamaz ("PATLAMADI"),
    yani puan her zaman tam bölünür. Zorluk skora değil geçilen boru sayısına bağlı.

- Denge: bonus turu ~20 saniyede ortalama **30-45 puan** getirir (normal oyunda
  aynı sürede ~14). Çırpış puanı tur başına 15 ile sınırlı, hızlı basarak puan
  kasılamaz; fırtınada biriken çarpanın tavanı ×25.
- 8 karakterli seçim menüsü (6+ karakterde ızgara 3 sütuna geçer)
- Giriş/bonus sesi başka seslerle kesilmez, sonuna kadar çalar; çırpma ve ölüm
  sesleri yalnız kendi türünü keser.
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
