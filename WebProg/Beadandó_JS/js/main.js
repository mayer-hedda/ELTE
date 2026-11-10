const UNKNOWN = 0;
const WALL = 1;
const LAND = 2;
const HOUSE = 3;

const menuScreen = document.querySelector("#menu-screen");
const gameScreen = document.querySelector("#game-screen");

const startForm = document.querySelector("#start-form");
const nameInput = document.querySelector("#player-name");
const nameError = document.querySelector("#name-error");
const menuTabs = document.querySelector("#menu-tabs");
const saveList = document.querySelector("#save-list");
const leaderboardDiv = document.querySelector("#leaderboard");

const gamePlayer = document.querySelector("#game-player");
const gameLevel = document.querySelector("#game-level");
const gameTimer = document.querySelector("#game-timer");
const board = document.querySelector("#board");
const progress = document.querySelector("#progress");
const errorList = document.querySelector("#error-list");
const saveStatus = document.querySelector("#save-status");
const saveButton = document.querySelector("#save-button");
const menuButton = document.querySelector("#menu-button");

const winDialog = document.querySelector("#win-dialog");
const winPlayer = document.querySelector("#win-player");
const winLevel = document.querySelector("#win-level");
const winTime = document.querySelector("#win-time");
const winMenuButton = document.querySelector("#win-menu-button");

let playerName = "";
let level = null;
let cells = [];
let seconds = 0;
let timer = null;
let saveId = null;
let finished = false;
let dragTarget = null;

function formatTime(sec) {
  const m = Math.floor(sec / 60);
  const s = sec % 60;
  return String(m).padStart(2, "0") + ":" + String(s).padStart(2, "0");
}

function levelName(lvl) {
  return `${lvl.name} (${lvl.grid.length}×${lvl.grid[0].length})`;
}

function showScreen(name) {
  menuScreen.hidden = name !== "menu";
  gameScreen.hidden = name !== "game";
}

function loadSaves() {
  return JSON.parse(localStorage.getItem("nevenincs-saves")) || [];
}

function writeSaves(saves) {
  localStorage.setItem("nevenincs-saves", JSON.stringify(saves));
}

function loadLeaderboard() {
  return JSON.parse(localStorage.getItem("nevenincs-leaderboard")) || { easy: [], medium: [], hard: [] };
}

function writeLeaderboard(leaderboard) {
  localStorage.setItem("nevenincs-leaderboard", JSON.stringify(leaderboard));
}

function showTab(name) {
  for (const button of document.querySelectorAll(".tab")) {
    button.classList.toggle("active", button.dataset.tab === name);
  }
  for (const panel of document.querySelectorAll(".tab-panel")) {
    panel.hidden = panel.dataset.panel !== name;
  }
}

function renderSaves() {
  saveList.innerHTML = "";
  const saves = loadSaves();

  if (saves.length === 0) {
    saveList.innerHTML = `<li class="empty">Még nincs mentett játékállás.</li>`;
    return;
  }

  for (const save of saves) {
    const lvl = LEVELS.find((l) => l.id === save.levelId);
    const li = document.createElement("li");
    li.className = "save-item";
    li.innerHTML = `
      <div class="save-info">
        <strong></strong>
        <span class="save-meta">${levelName(lvl)} · ${formatTime(save.seconds)}</span>
        <span class="save-meta">Mentve: ${new Date(save.date).toLocaleString("hu-HU")}</span>
      </div>
      <div class="save-actions">
        <button type="button" class="btn btn-small btn-primary" data-action="continue" data-id="${save.id}">Folytatás</button>
        <button type="button" class="btn btn-small btn-ghost" data-action="delete" data-id="${save.id}">Törlés</button>
      </div>`;
    li.querySelector("strong").textContent = save.playerName;
    saveList.append(li);
  }
}

function renderLeaderboard() {
  leaderboardDiv.innerHTML = "";
  const leaderboard = loadLeaderboard();

  for (const lvl of LEVELS) {
    const column = document.createElement("div");
    column.innerHTML = `<h3>${lvl.name}</h3>`;

    const results = leaderboard[lvl.id] || [];
    if (results.length === 0) {
      column.innerHTML += `<p class="empty">Még nincs eredmény.</p>`;
    } else {
      const ol = document.createElement("ol");
      ol.className = "leader-list";
      for (const result of results.slice(0, 10)) {
        const li = document.createElement("li");
        li.innerHTML = `<span class="leader-name"></span><span class="leader-time">${formatTime(result.seconds)}</span>`;
        li.querySelector(".leader-name").textContent = result.playerName;
        ol.append(li);
      }
      column.append(ol);
    }

    leaderboardDiv.append(column);
  }
}

function goToMenu() {
  clearInterval(timer);
  dragTarget = null;
  renderSaves();
  renderLeaderboard();
  showScreen("menu");
}

function startGame(name, levelId, savedCells, savedSeconds, id) {
  playerName = name;
  level = LEVELS.find((l) => l.id === levelId);
  cells = savedCells || level.grid.map((row) => row.map((n) => (n > 0 ? HOUSE : UNKNOWN)));
  seconds = savedSeconds || 0;
  saveId = id || null;
  finished = false;

  gamePlayer.textContent = playerName;
  gameLevel.textContent = levelName(level);
  gameTimer.textContent = formatTime(seconds);
  saveButton.disabled = false;
  saveStatus.textContent = "";
  board.classList.remove("solved");
  board.style.setProperty("--cols", level.grid[0].length);

  render();
  showScreen("game");

  clearInterval(timer);
  timer = setInterval(() => {
    seconds++;
    gameTimer.textContent = formatTime(seconds);
  }, 1000);
}

function render() {
  const errors = findErrors();

  board.innerHTML = "";
  for (let r = 0; r < cells.length; r++) {
    for (let c = 0; c < cells[r].length; c++) {
      const cell = document.createElement("div");
      cell.classList.add("cell");
      cell.dataset.row = r;
      cell.dataset.col = c;

      if (cells[r][c] === HOUSE) {
        cell.classList.add("house");
        cell.textContent = level.grid[r][c];
      } else if (cells[r][c] === WALL) {
        cell.classList.add("wall");
      } else if (cells[r][c] === LAND) {
        cell.classList.add("land");
      }

      if (errors.grid[r][c]) {
        cell.classList.add("error");
      }

      board.append(cell);
    }
  }

  const unknownCount = cells.flat().filter((s) => s === UNKNOWN).length;
  progress.textContent = unknownCount === 0 ? "Minden mező el van döntve." : `Eldöntetlen mezők: ${unknownCount}`;

  errorList.innerHTML = "";
  for (const message of errors.messages) {
    const li = document.createElement("li");
    li.textContent = message;
    errorList.append(li);
  }

  if (errors.messages.length === 0 && !finished) {
    const problem = solutionProblem();
    if (problem === "") {
      win();
    } else if (unknownCount === 0) {
      errorList.innerHTML = `<li>${problem}</li>`;
    } else {
      errorList.innerHTML = `<li class="ok">Nincs szabálysértés.</li>`;
    }
  }
}

function neighbours(r, c) {
  const list = [
    [r - 1, c],
    [r + 1, c],
    [r, c - 1],
    [r, c + 1],
  ];
  return list.filter(([nr, nc]) => nr >= 0 && nr < cells.length && nc >= 0 && nc < cells[0].length);
}

function bfs(startR, startC, canEnter) {
  const visited = cells.map((row) => row.map(() => false));
  visited[startR][startC] = true;
  const queue = [[startR, startC]];
  const area = [];

  while (queue.length > 0) {
    const [r, c] = queue.shift();
    area.push([r, c]);

    for (const [nr, nc] of neighbours(r, c)) {
      if (!visited[nr][nc] && canEnter(cells[nr][nc])) {
        visited[nr][nc] = true;
        queue.push([nr, nc]);
      }
    }
  }

  return area;
}

function findErrors() {
  const grid = cells.map((row) => row.map(() => false));
  const messages = [];

  function mark(area) {
    for (const [r, c] of area) {
      grid[r][c] = true;
    }
  }

  for (let r = 0; r < cells.length; r++) {
    for (let c = 0; c < cells[r].length; c++) {
      if (cells[r][c] !== HOUSE) continue;
      const need = level.grid[r][c];

      const estate = bfs(r, c, (s) => s === LAND);
      if (estate.length > need) {
        messages.push(`Túl nagy birtok: a(z) ${need} fős háznak ${estate.length} mezője van.`);
        mark(estate);
      }

      const possible = bfs(r, c, (s) => s === LAND || s === UNKNOWN);
      if (possible.length < need) {
        messages.push(`Túl kicsi birtok: a(z) ${need} fős ház legfeljebb ${possible.length} mezőt kaphat.`);
        mark(possible);
      }
    }
  }

  let blocks = 0;
  for (let r = 0; r < cells.length - 1; r++) {
    for (let c = 0; c < cells[r].length - 1; c++) {
      if (cells[r][c] === WALL && cells[r][c + 1] === WALL && cells[r + 1][c] === WALL && cells[r + 1][c + 1] === WALL) {
        blocks++;
        mark([[r, c], [r, c + 1], [r + 1, c], [r + 1, c + 1]]);
      }
    }
  }
  if (blocks > 0) {
    messages.push(`Szabálytalan 2×2-es faltömb (${blocks} helyen).`);
  }

  return { grid, messages };
}

function solutionProblem() {
  if (cells.flat().includes(UNKNOWN)) {
    return "Még vannak eldöntetlen mezők.";
  }

  const checked = cells.map((row) => row.map(() => false));
  for (let r = 0; r < cells.length; r++) {
    for (let c = 0; c < cells[r].length; c++) {
      if (cells[r][c] === WALL || checked[r][c]) continue;

      const area = bfs(r, c, (s) => s !== WALL);
      for (const [ar, ac] of area) {
        checked[ar][ac] = true;
      }

      const houses = area.filter(([ar, ac]) => cells[ar][ac] === HOUSE);
      if (houses.length !== 1) {
        return "Minden birtokon pontosan egy háznak kell lennie.";
      }
      const [hr, hc] = houses[0];
      if (area.length !== level.grid[hr][hc]) {
        return "Valamelyik birtok mérete nem egyezik a házon lévő számmal.";
      }
    }
  }

  const walls = [];
  for (let r = 0; r < cells.length; r++) {
    for (let c = 0; c < cells[r].length; c++) {
      if (cells[r][c] === WALL) walls.push([r, c]);
    }
  }
  if (walls.length > 0 && bfs(walls[0][0], walls[0][1], (s) => s === WALL).length !== walls.length) {
    return "A falak nem alkotnak egyetlen összefüggő hálózatot.";
  }

  return "";
}

function setCell(r, c) {
  if (cells[r][c] === HOUSE || cells[r][c] === dragTarget) return;
  cells[r][c] = dragTarget;
  saveStatus.textContent = "";
  render();
}

board.addEventListener("mousedown", (e) => {
  if (finished) return;
  const cell = e.target.closest(".cell");
  if (!cell) return;
  e.preventDefault();

  const r = Number(cell.dataset.row);
  const c = Number(cell.dataset.col);
  if (cells[r][c] === HOUSE) return;

  if (e.button === 0) {
    dragTarget = cells[r][c] === WALL ? UNKNOWN : WALL;
  } else if (e.button === 2) {
    dragTarget = cells[r][c] === LAND ? UNKNOWN : LAND;
  } else {
    return;
  }

  setCell(r, c);
});

board.addEventListener("mouseover", (e) => {
  if (dragTarget === null || finished) return;
  if (e.buttons === 0) {
    dragTarget = null;
    return;
  }
  const cell = e.target.closest(".cell");
  if (cell) {
    setCell(Number(cell.dataset.row), Number(cell.dataset.col));
  }
});

document.addEventListener("mouseup", () => {
  dragTarget = null;
});

board.addEventListener("contextmenu", (e) => {
  e.preventDefault();
});

function win() {
  finished = true;
  dragTarget = null;
  clearInterval(timer);
  board.classList.add("solved");
  saveButton.disabled = true;
  errorList.innerHTML = `<li class="ok">Megoldva!</li>`;

  const leaderboard = loadLeaderboard();
  leaderboard[level.id].push({ playerName, levelId: level.id, seconds });
  leaderboard[level.id].sort((a, b) => a.seconds - b.seconds);
  writeLeaderboard(leaderboard);

  if (saveId !== null) {
    writeSaves(loadSaves().filter((s) => s.id !== saveId));
    saveId = null;
  }

  winPlayer.textContent = playerName;
  winLevel.textContent = levelName(level);
  winTime.textContent = formatTime(seconds);
  winDialog.showModal();
}

saveButton.addEventListener("click", () => {
  if (finished) return;
  if (saveId === null) {
    saveId = Date.now();
  }

  const save = { id: saveId, playerName, levelId: level.id, cells, seconds, date: Date.now() };
  const saves = loadSaves();
  const index = saves.findIndex((s) => s.id === saveId);
  if (index >= 0) {
    saves[index] = save;
  } else {
    saves.push(save);
  }
  writeSaves(saves);

  saveStatus.textContent = "Elmentve.";
});

menuButton.addEventListener("click", goToMenu);

winMenuButton.addEventListener("click", () => {
  winDialog.close();
  goToMenu();
  showTab("leaderboard");
});

startForm.addEventListener("submit", (e) => {
  e.preventDefault();
  const name = nameInput.value.trim();
  if (name === "") {
    nameError.hidden = false;
    return;
  }
  nameError.hidden = true;

  const levelId = startForm.querySelector("input[name='level']:checked").value;
  startGame(name, levelId);
});

menuTabs.addEventListener("click", (e) => {
  const tab = e.target.closest(".tab");
  if (tab) showTab(tab.dataset.tab);
});

saveList.addEventListener("click", (e) => {
  const button = e.target.closest("button");
  if (!button) return;
  const id = Number(button.dataset.id);

  if (button.dataset.action === "continue") {
    const save = loadSaves().find((s) => s.id === id);
    startGame(save.playerName, save.levelId, save.cells, save.seconds, save.id);
  } else if (button.dataset.action === "delete") {
    writeSaves(loadSaves().filter((s) => s.id !== id));
    renderSaves();
  }
});

renderSaves();
renderLeaderboard();
