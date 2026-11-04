/* ==========================================================================
   WEBPROG JS ZH PUSKA – 2. RÉSZ: A MINTAZH ("A világirodalom nagyjai")
   MEGOLDÁSA. A valóságban 3 külön index.js (task-1, task-2, task-3 mappa)!
   A starter index.js elején lévő elemkiválasztásokat használd, ha már
   megvannak (itt saját nevekkel választom ki őket).
   ========================================================================== */


/* ##########################################################################
   TASK-1  Könyvtári körkép (12 pont)          -> task-1/index.js
   index.html: <script src="data.js"></script>  (dataEN.js HELYETT!)
   ########################################################################## */
function task1() {
  const NOVEL = "regény";           // angol adatnál (dataEN.js) "novel" lenne!

  // Segéd: egy szerző összes oldalszáma
  const totalPages = a => a.books.reduce((s, b) => s + b.pages, 0);
  // Segéd: minden könyv laposan
  const allBooks = authors.flatMap(a => a.books);

  // a) Van-e szerző legalább két, 1900 ELŐTT (< 1900) megjelent könyvvel?
  const a = authors.some(au => au.books.filter(b => b.year < 1900).length >= 2);
  document.querySelector("#taskA").textContent = a;          // "true"/"false"

  // b) Minden szerzőnek van-e legalább egy "regény" műfajú könyve?
  const b = authors.every(au => au.books.some(bk => bk.genres.includes(NOVEL)));
  document.querySelector("#taskB").textContent = b;

  // c) Szerzők, akiknek van 500 oldalnál HOSSZABB (> 500) regénye
  const c = authors
    .filter(au => au.books.some(bk => bk.pages > 500 && bk.genres.includes(NOVEL)))
    .map(au => au.name);
  document.querySelector("#taskC").textContent = c.join(", ");
  // Ha #taskC egy <ul>: c.forEach(n => { const li = document.createElement("li");
  //                     li.textContent = n; taskC.appendChild(li); });
  // -> Nézd meg a tesztben / README-ben, milyen formát vár!

  // d) Összes könyv összes oldalszáma
  const d = allBooks.reduce((s, bk) => s + bk.pages, 0);
  document.querySelector("#taskD").textContent = d;

  // e) Legtöbb összoldalú szerző, holtversenyben az ELSŐ -> szigorú ">"
  let best = authors[0];
  for (const au of authors) {
    if (totalPages(au) > totalPages(best)) best = au;
  }
  document.querySelector("#taskE").textContent = best ? best.name : "";

  // f) 1900 előtti regények átlagos oldalszáma, 2 tizedes.
  //    Könyvenként szűrünk -> több műfaj esetén is csak egyszer számít.
  const old = allBooks.filter(bk => bk.year < 1900 && bk.genres.includes(NOVEL));
  const avg = old.length ? old.reduce((s, bk) => s + bk.pages, 0) / old.length : 0;
  document.querySelector("#taskF").textContent = avg.toFixed(2);
}
// task1();


/* ##########################################################################
   TASK-2  Olvasóest-tervező (14 pont)         -> task-2/index.js
   KÖZVETLEN eseménykezelők (addEventListener az adott elemen)
   ########################################################################## */
function task2() {
  const workInput    = document.querySelector("#work-input");
  const addWork      = document.querySelector("#add-work");
  const readingList  = document.querySelector("#reading-list");
  const workCount    = document.querySelector("#work-count");
  const edition      = document.querySelector("#edition");
  const cover        = document.querySelector("img#cover");
  const minutes      = document.querySelector("#minutes");
  const minutesValue = document.querySelector("#minutes-value");
  const timeBar      = document.querySelector("#time-bar");
  const pace         = document.querySelector("#pace");
  const paceValue    = document.querySelector("#pace-value");
  const pageSpans    = document.querySelectorAll("span.page");
  const checkBtn     = document.querySelector("#check");
  const statusEl     = document.querySelector("#status");   // NE "status" nevű változó!
  const planner      = document.querySelector("#planner");

  const MAX = 4;
  const getItems = () => [...readingList.querySelectorAll("li")];

  // c) számláló + gomb tiltása
  function updateCount() {
    const n = getItems().length;
    workCount.textContent = n;
    addWork.disabled = n >= MAX;
  }

  // a) b) c) felvétel
  addWork.addEventListener("click", () => {
    const items = getItems();
    if (items.length >= MAX) return;                    // c) kezelő is védekezik

    const title = workInput.value.trim();               // b) trim
    if (title === "") return;                           // b) üres -> elutasít

    const exists = items.some(
      li => li.textContent.trim().toLowerCase() === title.toLowerCase()
    );
    if (exists) return;                                 // b) duplikátum -> elutasít

    const li = document.createElement("li");            // a) új li
    li.textContent = title;
    readingList.appendChild(li);

    workInput.value = "";                               // b) siker -> ürítés
    updateCount();
  });
  updateCount();

  // d) kiadásválasztó -> borítókép
  edition.addEventListener("change", () => {
    const opt = edition.options[edition.selectedIndex];
    cover.setAttribute("src", opt.value);   // value = kép útvonala
    cover.setAttribute("alt", opt.text);    // opció szövege
  });

  // e) idő csúszka
  minutes.addEventListener("input", () => {
    minutesValue.textContent = minutes.value;
    timeBar.style.height = minutes.value + "px";
  });

  // f) sebesség csúszka
  pace.addEventListener("input", () => {
    const v = Number(pace.value);
    paceValue.textContent = pace.value;
    pageSpans.forEach(span => {
      span.style.width = v * 20 + "px";
      span.classList.toggle("fast", v >= 4);   // legalább 4 -> rá, különben le
    });
  });

  // g) h) ellenőrzés
  checkBtn.addEventListener("click", () => {
    const n = getItems().length;

    if (n === 0) {
      statusEl.textContent = "Előbb adj meg legalább egy címet!";
      planner.classList.remove("ready");
      return;                                           // semmit nem tiltunk le
    }

    const opt = edition.options[edition.selectedIndex];
    const pages = Number(opt.dataset.pages);            // data-pages
    const speed = Number(pace.value);
    const needed = pages / speed + n * 5;               // kerekítetlen!
    const available = Number(minutes.value);
    const ok = available >= needed;                     // "legalább" -> >=
    const X = needed.toFixed(2);

    planner.classList.toggle("ready", ok);
    statusEl.textContent = ok
      ? `A program belefér! (${X} perc)`
      : `Rövid az időkeret! (${X} perc)`;

    // h) siker -> minden vezérlő letiltva; kudarc -> semmi nem tiltódik
    if (ok) {
      [minutes, pace, edition, workInput, addWork, checkBtn]
        .forEach(e => (e.disabled = true));
    }
  });
}
// task2();


/* ##########################################################################
   TASK-3  Könyvek visszapakolása (14 pont)     -> task-3/index.js
   library: { rows, cols, shelves:[{author,row,col}], books:[{title,author,row,col}] }
   DELEGÁLÁS a #map táblázaton (delegate a starterben van)
   ########################################################################## */
function task3() {
  const table    = document.querySelector("#map");
  const statusEl = document.querySelector("#status");

  // ---------- a) generálás: rows x cols ----------
  table.innerHTML = "";
  for (let r = 0; r < library.rows; r++) {
    const tr = document.createElement("tr");
    for (let c = 0; c < library.cols; c++) {
      tr.appendChild(document.createElement("td"));
    }
    table.appendChild(tr);
  }

  // ---------- b) polcok ----------
  for (const shelf of library.shelves) {
    const td = table.rows[shelf.row].cells[shelf.col];
    td.classList.add("shelf");
    td.dataset.author = shelf.author;          // data-author
  }

  // ---------- c) könyvek gombként ----------
  for (const book of library.books) {
    const btn = document.createElement("button");
    btn.type = "button";
    btn.classList.add("book");
    btn.textContent = book.title;
    btn.title = `${book.author}: ${book.title}`;   // "Szerző: Cím"
    btn.dataset.author = book.author;
    table.rows[book.row].cells[book.col].appendChild(btn);
  }

  // Segédek
  const getSelected = () => table.querySelector(".book.selected");
  const isOnShelf   = book => book.parentElement.classList.contains("shelf");

  function checkDone() {
    const books = [...table.querySelectorAll(".book")];
    const done = books.length > 0 && books.every(isOnShelf);
    statusEl.textContent = done ? "Minden könyv a helyén!" : "";
  }

  // ---------- d) + g1) kijelölés, delegálva ----------
  delegate(table, "button.book", "click", (e, book) => {
    if (isOnShelf(book)) return;               // f2) polcon lévőt nem jelölünk
    const prev = getSelected();
    if (prev && prev !== book) prev.classList.remove("selected"); // max 1
    book.classList.toggle("selected");
  });

  // ---------- e) f) + g2) cellakattintás, delegálva ----------
  delegate(table, "td", "click", (e, td) => {
    if (e.target.closest("button.book")) return; // könyvre kattintás csak kijelöl
    const selected = getSelected();
    if (!selected) return;                       // nincs kijelölt -> semmi

    if (td.classList.contains("shelf")) {
      // f1) polc: csak a saját szerző polcára
      if (td.dataset.author !== selected.dataset.author) return; // kijelölés marad
      td.appendChild(selected);                  // áthelyezés (nem másolás)
      selected.classList.remove("selected");
      checkDone();                               // f3)
    } else {
      // e) asztal: csak üres cellába
      if (td.querySelector(".book")) return;
      td.appendChild(selected);
      selected.classList.remove("selected");
    }
  });

  checkDone();   // kezdetben üres marad
}
// task3();
