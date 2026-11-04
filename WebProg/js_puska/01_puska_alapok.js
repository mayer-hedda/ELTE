/* ==========================================================================
   WEBPROG JS ZH PUSKA – 1. RÉSZ: ALAPOK, MINTÁK, FORMAI SZABÁLYOK
   (ELTE IK, ExamAssistant-es ZH; task-1 = adatfeldolgozás,
    task-2 = űrlap + közvetlen eseménykezelők, task-3 = táblázat + delegálás)
   ========================================================================== */


/* --------------------------------------------------------------------------
   0. ZH CHECKLIST (adminisztráció)
   --------------------------------------------------------------------------
   - ExamAssistant: HU nyelv -> Név + Neptun -> Szabályzat -> "Elfogadom és aláírom"
   - "Megnyitás VS Code-ban" -> Starter/README-HU.md = a feladatleírás
   - Csak a Starter mappában dolgozz!
   - TESZT ELŐTT MINDIG Ctrl+S! (a tesztelő csak a mentett fájlt látja)
   - Feladatonként "Tesztelés" gomb, hibánál "Hiba részletei" (ott látszik,
     hogy pontosan MIT vár a teszt: pl. "true" vagy "igen", "," vagy ", ")
   - task-1: index.html-ben <script src="data.js"> a dataEN.js HELYETT,
             és <html lang="hu"> (magyar státuszüzenetekhez)
   - A helyi teszt != végső pont: a szerver REJTETT adatokkal is tesztel
     -> SOHA ne égesd be a konkrét adatokat (nevek, darabszámok)!
   - A végén: "Beadandó ZIP létrehozása" -> "Mi van benne" -> feltöltés.
     Minden módosítás után ÚJ ZIP ("Újra" gomb)!
   - Böngészőben F12 -> Console: itt látod a hibákat, console.log-ot.
*/


/* --------------------------------------------------------------------------
   1. ELEMEK KIVÁLASZTÁSA
   -------------------------------------------------------------------------- */
const el1   = document.querySelector("#taskA");        // id alapján (1 elem / null)
const el2   = document.querySelector(".page");         // ELSŐ ilyen osztályú
const els   = document.querySelectorAll("span.page");  // MIND -> NodeList
const lis   = document.querySelectorAll("#reading-list li");
const inner = el1?.querySelector("li");                // elemen belül keresés

// NodeList-en van forEach, de NINCS map/filter/some -> alakítsd tömbbé:
const arr1 = [...els];               // spread
const arr2 = Array.from(els);        // ugyanaz

// FIGYELEM: ne nevezz globális változót "status"-nak vagy "name"-nek
// (window.status / window.name ütközhet) -> statusEl, nameInput stb.


/* --------------------------------------------------------------------------
   2. TÖMBMŰVELETEK (task-1 lényege) – mintaadat a mintazh szerkezetével
   -------------------------------------------------------------------------- */
const authorsDemo = [
  { name: "Jane Austen", language: "angol", books: [
    { title: "Emma", year: 1815, pages: 474, genres: ["regény", "romantikus"] },
    { title: "Persuasion", year: 1817, pages: 249, genres: ["regény"] },
  ]},
  { name: "Petőfi Sándor", language: "magyar", books: [
    { title: "Versek", year: 1844, pages: 120, genres: ["vers"] },
  ]},
];

// --- some: VAN-E legalább egy? (eldöntés, "létezik") -> true/false
const vanRegi = authorsDemo.some(a => a.books.some(b => b.year < 1900));

// --- every: MINDEN-e? (eldöntés, "mindegyik") -> true/false
const mindnekVanRegenye = authorsDemo.every(a =>
  a.books.some(b => b.genres.includes("regény")));

// --- filter + length: HÁNY olyan van? ("legalább kettő")
const vanKetRegi = authorsDemo.some(a =>
  a.books.filter(b => b.year < 1900).length >= 2);

// --- filter + map: KIK azok? (kiválogatás, nevek listája)
const hosszuRegenyesek = authorsDemo
  .filter(a => a.books.some(b => b.pages > 500 && b.genres.includes("regény")))
  .map(a => a.name);

// --- reduce: ÖSSZEGZÉS
const osszOldal = authorsDemo.reduce(
  (sum, a) => sum + a.books.reduce((s, b) => s + b.pages, 0), 0);

// --- flatMap: minden könyv egy lapos tömbben (nagyon hasznos!)
const allBooks = authorsDemo.flatMap(a => a.books);
// ha kell a szerző is a könyv mellé:
const booksWithAuthor = authorsDemo.flatMap(a =>
  a.books.map(b => ({ ...b, author: a.name })));

// --- MAXIMUM KIVÁLASZTÁS (holtversenyben az ELSŐ nyer -> szigorú >)
function maxBy(arr, fn) {
  let best = arr[0];
  for (const x of arr) {
    if (fn(x) > fn(best)) best = x;   // ">" = első nyer; ">=" = utolsó nyer
  }
  return best;
}
const pagesOf = a => a.books.reduce((s, b) => s + b.pages, 0);
const legtobbOldal = maxBy(authorsDemo, pagesOf)?.name;
// reduce-szal ugyanez:
const legtobb2 = authorsDemo.reduce((best, a) => pagesOf(a) > pagesOf(best) ? a : best);

// --- MINIMUM: ugyanez "<" jellel. Szám min/max:
const maxPages = Math.max(...allBooks.map(b => b.pages));
const minYear  = Math.min(...allBooks.map(b => b.year));

// --- ÁTLAG (üres tömbre figyelj -> 0/0 = NaN!)
const regiRegenyek = allBooks.filter(b => b.year < 1900 && b.genres.includes("regény"));
const atlag = regiRegenyek.length
  ? regiRegenyek.reduce((s, b) => s + b.pages, 0) / regiRegenyek.length
  : 0;
const atlagStr = atlag.toFixed(2);   // "361.50" (string!)

// --- find / findIndex: az ELSŐ ilyen elem / indexe (nincs: undefined / -1)
const emma = allBooks.find(b => b.title === "Emma");
const idx  = allBooks.findIndex(b => b.title === "Emma");

// --- includes: benne van-e (tömbben vagy stringben)
["regény", "vers"].includes("vers");     // true
"Jane Austen".includes("Austen");        // true

// --- sort: HELYBEN rendez -> előbb másolj! ([...arr] vagy arr.toSorted)
const evSzerint   = [...allBooks].sort((a, b) => a.year - b.year);      // szám növ.
const evCsokkeno  = [...allBooks].sort((a, b) => b.year - a.year);      // szám csökk.
const cimSzerint  = [...allBooks].sort((a, b) => a.title.localeCompare(b.title)); // szöveg
const top3        = [...allBooks].sort((a, b) => b.pages - a.pages).slice(0, 3);

// --- egyedi értékek: Set
const osszesMufaj = [...new Set(allBooks.flatMap(b => b.genres))];

// --- csoportosítás / számlálás objektumba
const mufajDb = {};
for (const b of allBooks) {
  for (const g of b.genres) {
    mufajDb[g] = (mufajDb[g] ?? 0) + 1;
  }
}
// bejárás: Object.keys / Object.values / Object.entries
for (const [mufaj, db] of Object.entries(mufajDb)) { /* ... */ }

// --- "Egy könyv csak egyszer számít, ha több műfaja van" -> a KÖNYVEKEN
//     szűrj (filter + includes), NE a műfajokon iterálj!


/* --------------------------------------------------------------------------
   3. SZÖVEG ÉS SZÁM FORMÁZÁS
   -------------------------------------------------------------------------- */
const s = "  Háború és béke  ";
s.trim();                       // "Háború és béke"
s.toLowerCase();                // kisbetűs (összehasonlításhoz!)
s.trim().toLowerCase() === "háború és béke";   // kis-nagybetű független egyezés
"a,b,c".split(",");             // ["a","b","c"]
["a", "b"].join(", ");          // "a, b"
`${"Jane Austen"}: ${"Emma"}`;  // template literal -> "Jane Austen: Emma"

Number("12");        // 12   (input.value MINDIG string!)
parseInt("12px");    // 12
parseFloat("3.5");   // 3.5
(85).toFixed(2);     // "85.00"
Math.round(2.567 * 100) / 100;   // 2.57 (szám marad)
String(true);        // "true"   (textContent-be írva automatikusan ez lesz)
const igenNem = vanRegi ? "igen" : "nem";   // ha a teszt ezt kéri


/* --------------------------------------------------------------------------
   4. KIÍRÁS A DOM-BA
   -------------------------------------------------------------------------- */
const out = document.querySelector("#taskA");
if (out) {
  out.textContent = vanRegi;          // biztonságos, sima szöveg -> "true"
  out.innerHTML = "<b>vastag</b>";    // HTML-ként értelmezi (csak saját szövegre!)
}

// Lista kiírása:
// a) egy szövegként:
//    el.textContent = names.join(", ");
// b) ha az elem <ul>/<ol>, li-kként:
function fillList(ul, items) {
  ul.innerHTML = "";                  // ürítés
  for (const item of items) {
    const li = document.createElement("li");
    li.textContent = item;
    ul.appendChild(li);
  }
}
// c) gyors (de csak megbízható adattal):
//    ul.innerHTML = items.map(x => `<li>${x}</li>`).join("");


/* --------------------------------------------------------------------------
   5. ELEMEK LÉTREHOZÁSA, ÁTHELYEZÉSE, TÖRLÉSE
   -------------------------------------------------------------------------- */
const btn = document.createElement("button");
btn.type = "button";                        // type attribútum
btn.textContent = "Emma";                   // szöveg
btn.title = "Jane Austen: Emma";            // title attribútum
btn.classList.add("book");                  // stílusosztály
btn.dataset.author = "Jane Austen";         // -> data-author="Jane Austen"
// parent.appendChild(btn);                 // a végére
// parent.prepend(btn);                     // az elejére
// parent.insertAdjacentHTML("beforeend", "<li>x</li>");
// elem.remove();                           // törlés
// MÁR AZ OLDALON LÉVŐ elem appendChild-ja ÁTHELYEZI (nem másol)!
// elem.parentElement                       // szülő (pl. könyv -> td)
// elem.closest("td")                       // legközelebbi ős (önmagát is nézi)
// elem.children / elem.querySelector("button") // gyerekek


/* --------------------------------------------------------------------------
   6. ATTRIBÚTUMOK, OSZTÁLYOK, STÍLUS, DATA-
   -------------------------------------------------------------------------- */
const img = document.createElement("img");
img.src = "img/a.jpg";                     // property
img.setAttribute("src", "img/a.jpg");      // ugyanez attribútumként
img.getAttribute("src");                   // pontosan a beírt érték ("img/a.jpg")
img.alt = "Első kiadás";

const box = document.createElement("div");
box.classList.add("ready");
box.classList.remove("ready");
box.classList.toggle("selected");          // ki-be kapcsol
box.classList.toggle("fast", 5 >= 4);      // 2. param: true -> rá, false -> le
box.classList.contains("shelf");           // van-e

box.style.height = 120 + "px";             // MINDIG mértékegységgel!
box.style.width = `${3 * 20}px`;
box.style.backgroundColor = "red";         // CSS: background-color -> camelCase

// data-* attribútumok: data-author -> dataset.author,
//                      data-pages  -> dataset.pages (STRING! -> Number())
//                      data-book-id -> dataset.bookId
box.dataset.author = "X";

// disabled:
// button.disabled = true;   input.disabled = n >= 4;


/* --------------------------------------------------------------------------
   7. ŰRLAPELEMEK
   -------------------------------------------------------------------------- */
/*
  <input id="work-input" type="text">        -> .value (string)
  <input id="minutes" type="range" min max>  -> .value (string!) / .valueAsNumber
  <input type="number">                      -> .valueAsNumber
  <input type="checkbox">                    -> .checked (true/false)
  <input type="radio" name="r">              -> document.querySelector('input[name="r"]:checked').value
  <select id="edition">
    <option value="img/a.jpg" data-pages="300">Első kiadás</option>
  </select>
     select.value                          -> a kiválasztott option value-ja
     select.selectedIndex                  -> index
     select.options[select.selectedIndex]  -> a kiválasztott option elem
     select.selectedOptions[0]             -> ugyanaz
     opt.text / opt.textContent            -> az opció szövege
     opt.dataset.pages                     -> data-pages
*/


/* --------------------------------------------------------------------------
   8. KÖZVETLEN ESEMÉNYKEZELŐK (task-2)
   -------------------------------------------------------------------------- */
/*
  gomb.addEventListener("click", fn);
  select.addEventListener("change", fn);    // legördülő, checkbox
  range.addEventListener("input", fn);      // csúszka MOZGATÁS közben (élő)
  text.addEventListener("input", fn);       // minden billentyűleütés
  form.addEventListener("submit", e => { e.preventDefault(); ... }); // ne töltsön újra!
  document.addEventListener("keydown", e => { e.key === "ArrowUp" ... });

  Az eseménykezelőben:
    e.target        -> amire ténylegesen kattintottak
    e.currentTarget -> amire a kezelőt regisztráltad
    this            -> (csak function-nél!) = currentTarget
*/

// Tipikus minta: "beviteli mező + gomb -> új li a listába"
function setupAddList(input, button, list, max = 4, counter = null) {
  function update() {
    const n = list.querySelectorAll("li").length;
    if (counter) counter.textContent = n;
    button.disabled = n >= max;
  }
  button.addEventListener("click", () => {
    const items = [...list.querySelectorAll("li")];
    if (items.length >= max) return;                 // kezelő is védekezzen
    const text = input.value.trim();
    if (text === "") return;                         // üres -> elutasít, mező marad
    const dup = items.some(li => li.textContent.trim().toLowerCase() === text.toLowerCase());
    if (dup) return;                                 // duplikátum -> elutasít, mező marad
    const li = document.createElement("li");
    li.textContent = text;
    list.appendChild(li);
    input.value = "";                                // siker -> mező ürítése
    update();
  });
  update();
}

// Tipikus minta: csúszka -> kijelző + méret
function setupSlider(range, display, target, factor = 1, prop = "height") {
  range.addEventListener("input", () => {
    const v = Number(range.value);
    display.textContent = v;
    target.style[prop] = v * factor + "px";
  });
}

// Tipikus minta: több vezérlő letiltása / engedélyezése egyszerre
function setDisabled(elems, value) {
  elems.forEach(e => (e.disabled = value));
}


/* --------------------------------------------------------------------------
   9. TÁBLÁZAT GENERÁLÁSA (task-3)
   -------------------------------------------------------------------------- */
function generateTable(table, rows, cols) {
  table.innerHTML = "";                      // a HTML-minta kommentet is törli (nem baj)
  for (let r = 0; r < rows; r++) {
    const tr = document.createElement("tr");
    for (let c = 0; c < cols; c++) {
      const td = document.createElement("td");
      td.dataset.row = r;                    // jól jön később (koordináta a cellán)
      td.dataset.col = c;
      tr.appendChild(td);
    }
    table.appendChild(tr);
  }
}
// cella elérése:  table.rows[r].cells[c]
// cella koordinátái kattintáskor:
//   td.parentElement.rowIndex  (sor),  td.cellIndex  (oszlop)
//   vagy Number(td.dataset.row), Number(td.dataset.col)

// 2D tömbből generálás (pl. pálya mátrix):
function tableFromMatrix(table, matrix) {
  table.innerHTML = matrix
    .map(row => `<tr>${row.map(v => `<td class="${v}"></td>`).join("")}</tr>`)
    .join("");
}

// Szomszédok (4 irány), pályán belül maradva:
function neighbors(r, c, rows, cols) {
  return [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]]
    .filter(([y, x]) => y >= 0 && y < rows && x >= 0 && x < cols);
}


/* --------------------------------------------------------------------------
   10. ESEMÉNYDELEGÁLÁS (task-3)
   -------------------------------------------------------------------------- */
// A kezdőcsomagban MEGVAN, de ha nem: így néz ki
function delegate(parent, child, when, what) {
  function eventHandlerFunction(event) {
    const eventTarget = event.target;
    const eventHandler = this;
    const closestChild = eventTarget.closest(child);
    if (eventHandler.contains(closestChild)) {
      what(event, closestChild);
    }
  }
  parent.addEventListener(when, eventHandlerFunction);
}

/*
  Használat:
    delegate(table, "button.book", "click", (e, book) => { ... });
    delegate(table, "td", "click", (e, td) => { ... });

  FONTOS: ha egy td-ben lévő gombra kattintasz, a "td" kezelő IS lefut
  (a gomb closest("td")-je a cella). Ha a cellakezelő ne fusson
  gombkattintásra:
    if (e.target.closest("button.book")) return;

  Kijelölés (egyszerre max 1):
    const prev = table.querySelector(".book.selected");
    if (prev && prev !== book) prev.classList.remove("selected");
    book.classList.toggle("selected");

  Üres cella-e:   !td.classList.contains("shelf") && !td.querySelector(".book")
  Mind kész-e:    [...table.querySelectorAll(".book")]
                    .every(b => b.parentElement.classList.contains("shelf"))
*/


/* --------------------------------------------------------------------------
   11. EGYÉB, AMI ELŐFORDULHAT
   -------------------------------------------------------------------------- */
// Időzítők
// const id = setTimeout(() => {...}, 1000);  clearTimeout(id);
// const iv = setInterval(() => {...}, 1000); clearInterval(iv);

// Billentyűzet (pl. mozgás a táblán)
// document.addEventListener("keydown", e => {
//   const dir = { ArrowUp: [-1, 0], ArrowDown: [1, 0], ArrowLeft: [0, -1], ArrowRight: [0, 1] }[e.key];
//   if (!dir) return;
//   e.preventDefault();                 // ne görgessen az oldal
// });

// Véletlen egész [min, max]
const rnd = (min, max) => Math.floor(Math.random() * (max - min + 1)) + min;

// Másolat objektumról / tömbről
const copyObj = { ...authorsDemo[0] };
const deepCopy = structuredClone(authorsDemo);

// Canvas minimum
// const ctx = canvas.getContext("2d");
// ctx.clearRect(0, 0, canvas.width, canvas.height);
// ctx.fillStyle = "red"; ctx.fillRect(x, y, w, h);
// ctx.beginPath(); ctx.arc(x, y, r, 0, 2 * Math.PI); ctx.fill();
// requestAnimationFrame(loop);

// fetch minimum
// const resp = await fetch("adat.json"); const data = await resp.json();


/* --------------------------------------------------------------------------
   12. TIPIKUS HIBÁK
   --------------------------------------------------------------------------
   - input.value string: "3" + 2 = "32"  -> Number(input.value)!
   - style érték mértékegység nélkül nem hat: el.style.width = 60  (ROSSZ)
   - sort() helyben rendez és szövegként, ha nincs comparator: [10,9,1].sort() -> [1,10,9]
   - querySelectorAll eredményén nincs .map -> [...nodeList]
   - toFixed stringet ad; összehasonlításhoz a KEREKÍTETLEN számot használd
   - "legalább" = >=, "több mint" = >, "előtt" (1900 előtt) = < 1900
   - holtverseny: első nyer -> ">", utolsó nyer -> ">="
   - üres tömb átlaga NaN -> ellenőrizd a length-et
   - a feladat pontos szövegeit (üzenetek, írásjelek, szóközök) MÁSOLD,
     ne gépeld újra!
   - delegálásnál a td-kezelő gombra kattintáskor is fut (ld. 10.)
   - szkript a <head>-ben DOM előtt fut -> defer vagy body végére (a starterben ok)
*/
