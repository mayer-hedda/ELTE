# Nevenincs király földosztása

> Webprogramozás – JavaScript beadandó

Nekeresdország egyik békés vidékén különös vita támadt a falu lakói között: a körülölelő termőföldeken több ház és tanya áll, ők pedig szeretnék igazságosan felosztani egymás között a rendelkezésre álló területet.

A falubeliek Nevenincs királyhoz fordultak segítségért, aki úgy rendelkezett, hogy **minden házhoz pontosan annyi földterület tartozzon, ahányan abban laknak.** A földeket falakkal kell elválasztani egymástól, ügyelve arra, hogy minden család egybefüggő birtokot kapjon, és egyik birtok se érintkezzen közvetlenül a másikkal.

A király Furfang tanácsost bízta meg az elosztás megtervezésével. A feladat azonban nem olyan egyszerű, mint elsőre tűnik! Meg kell felelni a hatályban lévő, szigorú építési szabályoknak.

Segíts Furfang tanácsosnak igazságosan felosztani a földeket!

---

## Tartalomjegyzék

1. [A játék célja](#a-játék-célja)
2. [Győzelmi feltételek](#győzelmi-feltételek)
3. [Pályák](#pályák)
4. [A játék működése](#a-játék-működése)
5. [Hibás állapotok jelzése](#hibás-állapotok-jelzése)
6. [Időmérés](#időmérés)
7. [Játékállás mentése és betöltése](#játékállás-mentése-és-betöltése)
8. [A megoldás ellenőrzése](#a-megoldás-ellenőrzése)
9. [A király dicsőségkönyve (ranglista)](#a-király-dicsőségkönyve)
10. [Technikai segítség](#technikai-segítség)
11. [Megjelenés](#megjelenés)
12. [TILTOTT gyakorlatok](#tiltott-gyakorlatok)
13. [Beadás és értékelés](#beadás-és-értékelés)
14. [README.md sablon](#readmemd-sablon)
15. [Ellenőrző lista](#ellenőrző-lista)
16. [Beadott munka tisztasága](#beadott-munka-tisztasága)

---

## A játék célja

Adott egy **N×M méretű**, négyzet alakú mezőkre osztott terület, amelyen különböző házak helyezkednek el. Minden házon egy szám látható, ami az ott élők számát jelzi.

A játékos feladata, hogy a terület mezőinek kijelölésével meghatározza a házakhoz tartozó birtokokat és a közöttük húzódó falakat.

A felosztás akkor helyes, ha minden ház pontosan a lakói számának megfelelő méretű, összefüggő birtokot kap, és a falak elhelyezkedése is megfelel az építési szabályoknak.

## Győzelmi feltételek

A játék akkor tekinthető megoldottnak, ha az alábbi feltételek **egyszerre** teljesülnek:

1. **Megfelelő birtokméret:** minden házhoz pontosan annyi mező tartozik, amekkora szám a házon szerepel. A ház saját mezője is beleszámít a birtok méretébe.
2. **Egybefüggő birtokok:** minden birtok mezői vízszintesen vagy függőlegesen kapcsolódnak egymáshoz. Az átlós érintkezés nem számít összeköttetésnek.
3. **Egy ház birtokonként:** minden birtokon pontosan egy ház található. Két ház nem tartozhat ugyanahhoz az összefüggő területhez.
4. **Elkülönített birtokok:** különböző birtokok nem érintkezhetnek egymással vízszintesen vagy függőlegesen, közöttük falnak kell húzódnia. _De:_ sarkukkal érintkezhetnek!
5. **Összefüggő falrendszer:** minden falnak kapcsolódnia kell a többi falhoz vízszintes vagy függőleges irányban, vagyis a falaknak egyetlen összefüggő hálózatot kell alkotniuk.
6. **Nincsenek „tömör” faltömbök:** a falak nem foglalhatnak el teljes egészében egyetlen 2×2-es területet sem.

---

## Pályák

A játék tartalmazzon **három beépített pályát**, különböző nehézségi fokokkal. Mindegyik pálya rendelkezik legalább egy szabályos megoldással.

**Jelmagyarázat a lenti rácsokhoz:**

|   Jel    | Jelentés                                     |
| :------: | -------------------------------------------- |
| `1`–`13` | Ház (a szám a lakók száma)                   |
|   `.`    | Üres / eldöntetlen mező (kezdőállapot)       |
|   `░`    | Birtokhoz tartozó, falmentes mező (megoldás) |
|   `█`    | Fal (megoldás)                               |

> A rácsokban a sorok és oszlopok 0-tól indexelve, balról jobbra, fentről lefelé értendők.

### Könnyű (5×5)

**Házak:** `(0,0)=1`, `(0,2)=5`, `(2,1)=1`, `(3,3)=5`, `(4,0)=1`

```
Kezdőállapot           Megoldás
 1  .  5  .  .          1  █  5  ░  ░
 .  .  .  .  .          █  █  █  ░  ░
 .  1  .  .  .          █  1  █  █  █
 .  .  .  5  .          █  █  █  5  ░
 1  .  .  .  .          1  █  ░  ░  ░
```

### Közepes (7×7)

**Házak:** `(0,0)=12`, `(0,6)=4`, `(3,0)=1`, `(3,2)=1`, `(5,0)=7`, `(5,5)=3`

```
Kezdőállapot                  Megoldás
12  .  .  .  .  .  4         12  ░  ░  ░  ░  █  4
 .  .  .  .  .  .  .          ░  █  ░  ░  ░  █  ░
 .  .  .  .  .  .  .          █  █  █  ░  ░  █  ░
 1  .  1  .  .  .  .          1  █  1  █  ░  █  ░
 .  .  .  .  .  .  .          █  █  █  █  █  █  █
 7  .  .  .  .  3  .          7  █  ░  ░  █  3  ░
 .  .  .  .  .  .  .          ░  ░  ░  ░  █  █  ░
```

### Nehéz (10×10)

**Házak:** `(0,0)=12`, `(0,7)=7`, `(2,4)=2`, `(4,0)=5`, `(4,4)=1`, `(4,6)=2`, `(4,9)=1`, `(6,4)=1`, `(6,6)=1`, `(6,8)=1`, `(7,0)=13`, `(7,5)=1`, `(8,7)=4`

```
Kezdőállapot                       Megoldás
12  .  .  .  .  .  .  7  .  .     12  ░  ░  ░  ░  ░  █  7  ░  ░
 .  .  .  .  .  .  .  .  .  .      ░  ░  ░  █  █  █  █  █  ░  ░
 .  .  .  .  2  .  .  .  .  .      ░  ░  ░  █  2  ░  █  ░  ░  █
 .  .  .  .  .  .  .  .  .  .      █  █  █  █  █  █  █  █  █  █
 5  .  .  .  1  .  2  .  .  1      5  ░  ░  █  1  █  2  ░  █  1
 .  .  .  .  .  .  .  .  .  .      █  ░  ░  █  █  █  █  █  █  █
 .  .  .  .  1  .  1  .  1  .      █  █  █  █  1  █  1  █  1  █
13  .  .  .  .  1  .  .  .  .     13  ░  ░  █  █  1  █  █  █  █
 .  .  .  .  .  .  .  4  .  .      ░  ░  ░  ░  █  █  █  4  ░  █
 .  .  .  .  .  .  .  .  .  .      ░  ░  ░  ░  ░  ░  █  ░  ░  █
```

> ⚠️ A három pálya kezdőállapota **rögzített**, a házak helye és a hozzájuk tartozó számok játék közben nem változhatnak!

---

## A játék működése

### Kezdőképernyő

- A kezdőképernyőn a játékos megadhatja a **nevét (kötelező)**.
- A játékos kiválaszthatja a három nehézségi szint egyikét, majd a **„Játék indítása”** gombra kattintva elindíthatja a választott pályát.

A kezdőképernyőről legyen lehetőség:

- új játék indítására,
- korábban elmentett játékállás betöltésére,
- a pályánkénti ranglista megtekintésére,
- a játékszabályok elolvasására.

> A képernyők **nem külön HTML oldalon** jelennek meg, hanem ugyanazon dokumentumban előkészített két szekcióként, amiknek a láthatóságát vezéreljük.

### Játékképernyő

A játék képernyőjén jelenjen meg:

- a játékos neve,
- a kiválasztott pálya neve és nehézsége,
- a játék kezdete óta eltelt idő,
- a játéktábla,
- a játék mentésére és a főmenübe történő visszatérésre szolgáló vezérlőelemek.

A játéktábla négyzetes mezőkből álljon, amelyeken jól megkülönböztethetők legyenek a **házak**, a **falak**, a **birtokként megjelölt** és a **még eldöntetlen** mezők.

### Interakció

A játékos a házakat tartalmazó négyzetek kivételével módosíthatja a tábla mezőit.

#### 🖱️ Bal egérgomb – fal építése

- Egy mezőre bal gombbal kattintva a játékos falat helyezhet el.
- Egy már fallal jelölt mezőre ismét rákattintva eltávolíthatja a falat.
- A bal egérgombot lenyomva tartva és az egeret a táblán mozgatva egyszerre több mezőt is fallal jelölhet.
- Húzás közben a mezők a művelet kezdetekor kiválasztott állapotot vegyék fel, így a játékos folyamatosan építhet vagy törölhet falszakaszokat.

#### 🖱️ Jobb egérgomb – birtok megjelölése

- A játékos jobb egérgombbal megjelölheti azokat a mezőket, amelyekről biztosan tudja, hogy nem tartalmaznak falat.
- Ismételt jobb kattintásra a jelölés legyen eltávolítható.

#### Mezőállapotok

1. Fal
2. Falmentes, birtokhoz tartozó mező
3. Ház (rögzített, nem módosítható)

_(Ezeken kívül a mező lehet még eldöntetlen.)_

---

## Hibás állapotok jelzése

A játék során **folyamatosan** jelezzük, ha a földosztás során hibás állapotba kerültünk. Az alábbi esetekben kell hibát jeleznünk:

1. **Túl kicsi birtok:** ha egy házat tartalmazó, falakkal teljesen körülzárt terület kevesebb mezőből áll, mint amennyit a házban szereplő szám előír. _Csak akkor minősítsünk túl kicsinek egy birtokot, ha már biztosan nem bővíthető tovább!_
2. **Túl nagy birtok:** ha egy házhoz tartozó összefüggő, falmentes terület több mezőből áll, mint amennyit a házban szereplő szám előír.
3. **Szabálytalan faltömb:** ha a játékos úgy helyez el falakat, hogy azok egy teljes 2×2-es területet elfoglalnak.

A hibás területeket vizuálisan, például **piros háttérszínnel vagy kerettel** emeld ki. A visszajelzésnek egyértelművé kell tennie, hogy mely mezők vagy területek sértik a szabályokat. A hibás lépések végrehajtását nem kell megakadályozni, a játékosnak azonban lehetőséget kell biztosítani a javításra. Amennyiben egy korábban jelzett hiba megszűnik, a hozzá tartozó figyelmeztetés is automatikusan tűnjön el.

> **Fontos:** a hibák jelzése már a játék közben történjen meg, ne csak a teljes tábla kitöltésekor vagy a játék végén.

---

## Időmérés

- A játék indításakor induljon el egy időmérő, ami folyamatosan kijelzi a játék kezdete óta eltelt időt.
- Az idő kijelzése másodpercenként frissüljön, például **perc:másodperc** formátumban.
- Mentett játék folytatásakor az időmérés a korábban eltelt időtől folytatódjon.
- A játék sikeres befejezésekor az időmérő álljon meg.

---

## Játékállás mentése és betöltése

A játékos bármikor félbehagyhatja az aktuális játékot, és elmentheti annak állását. A mentés legalább az alábbi adatokat tartalmazza:

- a játékos neve,
- a kiválasztott pálya,
- a játéktábla mezőinek aktuális állapota,
- az addig eltelt játékidő.

Az adatokat a böngésző **`localStorage`** tárhelyén kell tárolni. A kezdőképernyőn lehessen megtekinteni az elmentett játékállást, és kiválasztani egyet a folytatáshoz. A betöltés után a játék pontosan a mentéskori állapotból folytatódjon.

---

## A megoldás ellenőrzése

A játék a mezők módosításakor vizsgálja meg, hogy teljesülnek-e a győzelmi feltételek. A játék csak akkor érhet véget, ha:

- minden mező állapota eldöntött,
- az összes házhoz megfelelő méretű, összefüggő birtok tartozik,
- minden birtokon pontosan egy ház található,
- a falak összefüggő rendszert alkotnak,
- a táblán nem található teljesen fallal kitöltött 2×2-es terület.

Sikeres megoldás esetén a játék jól látható módon jelezze a győzelmet, például egy, a játékképernyőn megjelenő üzenettel vagy párbeszédablakkal (**de nem a böngésző beépített `alert()` függvényével**).

A győzelmi képernyő jelenítse meg a **játékos nevét**, az **elért időeredményt** és a **teljesített pályát**. A játékos innen térhessen vissza a főmenübe.

---

## A király dicsőségkönyve

A játék tartalmazzon egy helyi ranglistát, ami nyilvántartja a sikeresen teljesített játékokat. A ranglista tárolja:

- a játékos nevét,
- a teljesített pályát,
- a megoldáshoz szükséges időt.

Mindhárom pályához **külön ranglista** tartozzon. Az eredmények a teljesítési idő alapján **növekvő sorrendben** jelenjenek meg, hogy a leggyorsabb játékos kerüljön az első helyre. A ranglistát szintén **`localStorage`** segítségével tároljátok!

---

## Technikai segítség

### Felület

Első lépésként érdemes elkészíteni az alkalmazás statikus HTML- és CSS-prototípusát.

Gondold át, hogyan jeleníted meg a játéktáblát, milyen CSS-osztályokat használsz a különböző mezőállapotokhoz, és hogyan biztosítod a négyzetes mezők megjelenését különböző képernyőméreteken. A játéktábla kialakításához jó megoldás lehet a **CSS Grid**.

### A pálya ábrázolása

A pályákat érdemes **kétdimenziós tömbökben** tárolni. A pálya adatai tartalmazzák a tábla méretét, a házak pozícióját és a házakban lakók számát. A játékos által módosítható mezőállapotokat célszerű külön adatszerkezetben nyilvántartani. A felhasználói felület mindig az aktuális játékállapot alapján jelenjen meg.

### Interakció

A kattintásokat és az egérhúzást célszerű **eseménydelegálással** kezelni. Ügyelj arra, hogy mindkettő egyaránt helyesen működjön, és egy húzás során ugyanaz a mező ne módosuljon véletlenül többször.

### A megoldás ellenőrzése

A birtokok és a falrendszer összefüggőségének ellenőrzésére alkalmasak a gráfbejárási algoritmusok, például a **mélységi (DFS)** vagy a **szélességi (BFS)** keresés. Az ellenőrzés során a vízszintes és függőleges szomszédokat kell figyelembe venni. A 2×2-es faltömbök ellenőrzése megoldható a tábla megfelelő részrácsainak végigvizsgálásával.

---

## Megjelenés

Fontos az **igényes megjelenés**. Ez nem feltétlenül jelenti egy agyon csicsázott oldal elkészítését, de azt igen, hogy **1024×768 felbontásban és afölött** az elrendezés jól jelenjen meg, a játéktábla négyzetes cellákat tartalmazzon. Ehhez lehet minimalista designt is alkalmazni, lehet különböző háttérképekkel és grafikus elemekkel felturbózott saját CSS-t készíteni, de lehet bármilyen CSS keretrendszer segítségét is igénybe venni.

Nincs elvárás arra vonatkozóan, hogy milyen technológiával (táblázat, div-ek vagy canvas) oldod meg a feladatot, továbbá a megjelenést és működést illetően sincsenek kőbe vésett elvárások. A lényeg, hogy a fenti feladatok felismerhetők legyenek, és **a játék jól játszható legyen.**

**Javaslatok:**

```
✓ NÉGYSZÖGLETES cellák (aspect-ratio: 1)
✓ RESPONSIVE rács (320px–1920px)
✓ CSS Grid layout
✓ WCAG AA kontraszt
✓ 16px+ betűméret
✓ 200ms forgatási animáció
✓ Hover effektek
✓ Game over jelzés
```

---

## TILTOTT gyakorlatok

A következő módszerek elkerülendő megoldásoknak számítanak, amikre a gyakorlatok során igyekszünk figyelmeztetni titeket, így kérünk titeket, hogy a beadandónál is mindenképpen kerüljétek őket!

```
✗ var
✗ inline JavaScript (onclick=...)
✗ jQuery, React, Vue, stb.
✗ getElementById(), getElementsByTagName()
✗ DOMContentLoaded
✗ alert(), prompt(), confirm()
✗ setTimeout() / setInterval() < 100ms
```

> 🚫 **Tiltott gyakorlatok akár egyszeri használata esetén is a beadandó feladat véglegesen elutasítható! Kerüljétek őket!**

---

## Beadás és értékelés

> **ÚJ, FIGYELMESEN OLVASD EL!**

### Feltöltés

- Az elkészült feladatot **egyetlen `.zip` archívumként** kell feltölteni a kurzus Canvas felületére a megadott határidőig.
  - **A határidő után beadás NEM lehetséges semmilyen indokkal!**
  - A csomagnak tartalmaznia kell **MINDEN** olyan állományt, amely a futtatáshoz és értékeléshez szükséges (pl. HTML, CSS, médiaelemek, JavaScript) és a **`README.md`** nevű fájlt az alábbi sablon szerint.
  - Mivel a Canvas tárhelye limitált, ezért kérjük, hogy a bemutató videót oda **NE** töltsd fel, **csak a linket helyezd el** az erre kijelölt helyre!

### Bemutató videó

- Az elkészült alkalmazást egy **képernyővideóban** kell bemutatnod, amelyben bizonyítod, hogy **MINDEN** feladat elkészült és helyesen működik. A felvételéhez [OBS Studio](https://obsproject.com/) használatát javasoljuk, de más szoftver is használható természetesen.
  - A beküldött videó **maximális hossza 5 perc! Kérjük az adott intervallum szigorú betartását!**
  - Segítség az idő kitöltéséhez: játékmenet bemutatása a különböző pályákon és helyzetekben, esetleges hibalehetőségek kezelése stb.
  - Az egyes funkciók bemutatása mellett/után érdemes kitérni arra, hogy milyen tervezési döntéseket kellett hozni, milyen nehézségekbe ütköztél és hogyan oldottad ezeket meg. Mi jelentett kihívást a program elkészítése során?
  - **A videóhoz narráció kötelező!**
  - A videót a kari **OneDrive** tárhelyre kell feltölteni, link birtokában más felhasználók számára megtekinthetőként megosztani, és ezt a linket a `README.md` fájlban elhelyezni.
  - **A videó a gyakorlati jegy beírásáig elérhető kell maradjon!**

### A gyakorlati jegyszerzés JavaScript beadandóhoz kapcsolódó feltételei

- **MINDEN** feladat elkészült és nagyobb hiba nélkül működik.
- A beadás tartalmazza a kitöltött **`README.md`** állományt, és az állományban linkelt videó megfelel a fent részletezett feltételeknek.
- A beadandó feladat egyetlen tiltott gyakorlatot sem tartalmaz, valamint nem ütközik a _Beadott munka tisztasága_ fejezetben leírtakkal!

> ❗ **Amennyiben a feltöltött archívum nem/hibásan/kitöltetlenül tartalmazza a nyilatkozatot, az önellenőrző listát vagy valamely szükséges állományt, a beadott munka nem kerül értékelésre, ami a kurzus elvégzésének sikertelenségét eredményezi! A hallgató saját felelőssége, hogy időben meggyőződjön a beadás hiánytalanságáról!**

---

## README.md sablon

```markdown
# Nevenincs király földosztása

## Videó

[NÉV (Neptun) videó](https://)

## Nyilatkozat

<Hallgató neve>
<Hallgató Neptun kódja>

Ezt a megoldást a fent nevezett hallgató küldte be és készítette a Webprogramozás kurzus "JavaScript beadandó" számonkéréséhez.

Kijelentem, hogy ez a megoldás a saját munkám. Nem másoltam vagy használtam harmadik féltől származó megoldásokat. Nem továbbítottam megoldást hallgatótársaimnak, és nem is tettem közzé. Az ELTE HKR 377/A. § értelmében, ha nem megengedett segédeszközt veszek igénybe, vagy más hallgatónak nem megengedett segítséget nyújtok, a tantárgyat nem teljesíthetem.

ELTE Hallgatói Követelményrendszer, IK kari különös rész, 377/A. §: "Az a hallgató, aki olyan tanulmányi teljesítménymérés (vizsga, zárthelyi, beadandó feladat) során, amelynek keretében számítógépes program vagy programmodul elkészítése a feladat, az oktató által meghatározottakon kívül más segédeszközt vesz igénybe, illetve más hallgatónak meg nem engedett segítséget nyújt, tanulmányi szabálytalanságot követ el, ezért az adott félévben a tantárgyat nem teljesítheti és a tantárgy kreditjét nem szerezheti meg."

## ELLENŐRZŐ LISTA

- Kezdőképernyő
  - [ ] név + nehézségi szint (3 pálya)
  - [ ] játékszabályok megtekintése
  - [ ] pályánkénti ranglista
  - [ ] mentett állások betöltése
- Játékképernyő
  - [ ] név + folyamatosan változó idő
  - [ ] játéktábla rácsként, házakkal és a hozzájuk tartozó számokkal
  - [ ] falak elhelyezése és törlése bal kattintással
  - [ ] falak rajzolása és törlése egérhúzással
  - [ ] hibaüzenetek automatikus jelzése: túl kicsi / túl nagy / 2x2-es fal
  - [ ] falmentes mezők megjelölése és jelölésük törlése jobb kattintással
  - [ ] házakat tartalmazó mezők módosításának tiltása
  - [ ] megoldás ellenőrzése az összes földfelosztási és falépítési szabály alapján
  - [ ] siker esetén jelzés és az időmérő leállítása
  - [ ] eredmény mentése a pályánkénti ranglistába
  - [ ] játékállás mentése
- Beadás / videó
  - [ ] videó hossza 3-5 perc
  - [ ] a linket a videóhoz fent elhelyeztem ebben a fájlban
  - [ ] minden funkciót bemutattam a videóban
  - [ ] OneDrive-on ellenőriztem a megosztás beállításait – link birtokában a videót megtekintheti más felhasználó is
```

---

## Ellenőrző lista

### Kezdőképernyő

- [ ] név + nehézségi szint (3 pálya)
- [ ] játékszabályok megtekintése
- [ ] pályánkénti ranglista
- [ ] mentett állások betöltése

### Játékképernyő

- [ ] név + folyamatosan változó idő
- [ ] játéktábla rácsként, házakkal és a hozzájuk tartozó számokkal
- [ ] falak elhelyezése és törlése bal kattintással
- [ ] falak rajzolása és törlése egérhúzással
- [ ] hibaüzenetek automatikus jelzése: túl kicsi / túl nagy / 2×2-es fal
- [ ] falmentes mezők megjelölése és jelölésük törlése jobb kattintással
- [ ] házakat tartalmazó mezők módosításának tiltása
- [ ] megoldás ellenőrzése az összes földfelosztási és falépítési szabály alapján
- [ ] siker esetén jelzés és az időmérő leállítása
- [ ] eredmény mentése a pályánkénti ranglistába
- [ ] játékállás mentése

### Beadás / videó

- [ ] videó hossza 3–5 perc
- [ ] a linket a videóhoz elhelyeztem a `README.md` fájlban
- [ ] minden funkciót bemutattam a videóban
- [ ] OneDrive-on ellenőriztem a megosztás beállításait – link birtokában a videót megtekintheti más felhasználó is

---

## Beadott munka tisztasága

A beadott munka alapvetően **saját, egyéni, önálló szellemi termék** kell legyen! Ez nem azt jelenti, hogy ne lehetne pl. dokumentációt használni vagy rákeresni az interneten ötletre, de más hallgatókkal való jelentős kódegyezés vagy nagy mennyiségű internetes átvétel esetén a beadandó bármilyen **pótlási/javítási lehetőség nélkül** visszautasítható! (Ilyen esetben az érintett hallgató(k) semmilyen módon nem teljesítheti(k) a kurzust ebben a félévben!)

**Az egyezések elkerülése végett fokozottan kérjük azt is, hogy a megoldásod NE tedd közzé publikus tárhelyen, GitHub-on vagy bármilyen más platformon legalább a beadás határidejéig!** Egyezés esetén nem fogjuk a forrást keresni, hanem minden érintett hallgatót egyformán szankcionálunk, hiszen a megoldás továbbadása vagy közzététele is tanulmányi szabálytalanságnak minősül! _(ELTE Hallgatói Követelményrendszer, IK kari különös rész, 377/A. §)_

Az alkalmazás megvalósításához **NEM használható semmilyen JavaScript keretrendszer vagy függvénykönyvtár** — így például tiltott a jQuery, React stb. bármilyen szintű használata!

Az alkalmazás állományain kívül **KÖTELEZŐEN beküldendő** még a fenti sablon alapján elkészítendő `README.md` fájl mellékelése, az abban található nyilatkozat és önellenőrző lista kitöltésével. A beadáskor a hallgató nyilatkozik, hogy elfogadja a csalás esetén lehetséges következményeket.
