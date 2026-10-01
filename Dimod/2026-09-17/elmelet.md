# Oszthatóság

$$a, b \in \mathbb{Z}$$
$$a \mid b \qquad \text{, ha } \exists c \in \mathbb{Z} \qquad b = a \cdot c$$
$$2 \mid 6 \qquad \exists 3 \in \mathbb{Z} \qquad 6 = 2 \cdot 3$$

---

$$a \mid 0$$
$$1 \mid a$$
$$a \mid b \quad \land \quad b \mid c \quad \Rightarrow \quad a \mid c$$
$$2 \mid 4 \quad \land \quad 4 \mid 8 \quad \Rightarrow \quad 2 \mid 8$$
$$a \mid b \quad \land \quad a \mid c \quad \Rightarrow \quad a \mid b + c$$
$$ a \mid b \quad \Rightarrow \quad \forall k \in \mathbb{Z} \quad a \mid b \cdot k$$

---

$$ a \mid a \qquad \rightarrow \text{reflexív}$$
$$2 \mid 6 \neq 6 \mid 2 \qquad \rightarrow \text{nem szimmetrikus}$$
$$a \mid b \quad \land \quad b \mid a \quad \Rightarrow \quad a = b$$
$$a \mid b \quad \Rightarrow \quad b \mid a \quad \lor \quad a = b$$

---

**Részbenrendezés:**

- reflexív
- antiszimmetrikus
- tranzitív

---

---

# Definíciók

### Asszociált:

$$a, b \in \mathbb{Z} \qquad a \sim b \quad \text{, ha } \quad a \mid b \quad \land \quad b \mid a$$
$$-a \sim a$$

Két egész szám, a és b, akkor asszociált, ha kölcsönösen osztják egymást: a osztója b-nek, és b osztója a-nak. Az egész számok között ez azt jelenti, hogy legfeljebb előjelben különböznek, ezért minden a asszociált a −a-val (pl. 5 ~ −5).

---

### Egység:

$$e \in \mathbb{Z} \text{ egység, ha } \quad \forall a \in \mathbb{Z} : \exists a' \in \mathbb{Z} \quad a = e \cdot a'$$
$$a = (-a) \cdot (-1)$$

Egy e egész szám egység, ha minden egész számnak osztója, vagyis bármely a felírható e és egy alkalmas egész szám szorzataként. Ez ugyanazt jelenti, mint hogy e osztója az 1-nek. Az egész számok között pontosan két egység van, az 1 és a −1, mert például a = (−1) · (−a) minden a-ra teljesül.

---

### Irreducibilis:

$$a \in \mathbb{Z} \text{ irreducibilis, ha} \quad \forall a = b \cdot c \quad \text{ esetén } b \text{ vagy } c \text{ egység}$$
$$5 = 1 \cdot 5 \quad \lor \quad (-1) \cdot (-5) \qquad // \qquad 4 = 1\cdot 4 = 2 \cdot 2$$

Egy a egész szám irreducibilis, ha nem nulla, nem egység, és bármely kéttényezős felbontásában (a = b · c) a két tényező közül legalább az egyik egység. Másképp: csak „triviálisan” bontható fel. Az 5 irreducibilis, mert csak 1 · 5 vagy (−1) · (−5) alakban írható fel. A 4 nem az, mert 4 = 2 · 2, és itt egyik tényező sem egység.

---

### Prímelem:

$$p \in \mathbb{Z} \text{ prím} \qquad p \mid ab \quad \Rightarrow \quad p \mid a \quad \lor \quad p \mid b$$
$$4 \mid 2 \cdot 18 \qquad DE \qquad 4 \nmid 2 \quad \land \quad 4 \nmid 18$$

Egy p egész szám prímelem, ha nem nulla, nem egység, és teljesül rá, hogy ha osztója egy szorzatnak, akkor a szorzat legalább egyik tényezőjének is osztója. A 4 ezért nem prímelem: osztója a 2 · 18 = 36-nak, de sem a 2-nek, sem a 18-nak nem osztója.

---

### Prímszám:

$$\mathbb{N} \text{ felett a prímelemek}$$
$$\mathbb{N} \text{ felett irreducibilis elemek}$$
$$\text{nincs valódi osztója}$$

_$$(p1, p2, p3 ... pn) \text{ szorzata páros}$$_

A prímszámok a pozitív prímelemek. Az egész számok körében a prímelem és az irreducibilis elem fogalma egybeesik, ezért a prímszámok ugyanígy a pozitív irreducibilis elemek is. Hétköznapi megfogalmazásban: olyan 1-nél nagyobb természetes szám, amelynek nincs valódi osztója, vagyis csak az 1 és önmaga osztja.

---

### Gyűrű: (n x n -es mátrixok)

$$\text{Halmaz, ami zárt összeadásra és szorzásra, igaz rá a disztributivitás.}$$
$$\Rightarrow a(b + c) = ab + ac$$

A gyűrű egy halmaz két művelettel, összeadással és szorzással, amelyekre a halmaz zárt, és teljesülnek a következők. Az összeadás asszociatív és kommutatív, van nullelem, és minden elemnek van ellentettje. A szorzás asszociatív. A két műveletet a disztributivitás köti össze, mindkét oldalról: a(b + c) = ab + ac és (b + c)a = ba + ca. Példa erre az n × n-es mátrixok halmaza, amelyben a szorzás nem kommutatív.

---

### Kongurencia:

Két egész szám, a és b, kongruens modulo m, ha m-mel osztva ugyanazt a maradékot adják, vagyis ugyanabba a maradékosztályba tartoznak. Ez azzal egyenértékű, hogy m osztója az a − b különbségnek. Jelölése: a ≡ b (mod m). Például m = 8 esetén 3 ≡ 11 (mod 8), mert mindkettő 3 maradékot ad 8-cal osztva, és 11 − 3 = 8 osztható 8-cal.
