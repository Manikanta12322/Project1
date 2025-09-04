<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Simple Banking App (Demo)</title>
  <style>
    :root {
      --bg: #0f172a;
      --card: #111827;
      --muted: #94a3b8;
      --text: #e5e7eb;
      --accent: #22c55e;
      --accent-2: #3b82f6;
      --danger: #ef4444;
      --warning: #f59e0b;
      --shadow: 0 8px 30px rgba(0,0,0,.35);
      --radius: 18px;
    }
    * { box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      margin: 0; font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
      background: radial-gradient(1200px 800px at 80% -10%, #172554 0%, transparent 60%),
                  radial-gradient(1000px 700px at -5% 20%, #064e3b 0%, transparent 60%),
                  var(--bg);
      color: var(--text);
    }
    header {
      display:flex; align-items:center; justify-content:space-between;
      padding:16px 22px; position:sticky; top:0; backdrop-filter: blur(8px);
      background: rgba(15,23,42,.55); border-bottom: 1px solid rgba(148,163,184,.15);
      z-index: 10;
    }
    .brand { display:flex; align-items:center; gap:12px; font-weight:700; letter-spacing:.3px; }
    .badge { font-size:12px; color:var(--muted); }
    .container { max-width:1100px; margin: 24px auto; padding: 0 16px; }
    .grid { display:grid; gap:20px; grid-template-columns: 1fr; }
    @media (min-width: 900px) { .grid { grid-template-columns: 320px 1fr; } }

    .card { background: linear-gradient(180deg, rgba(255,255,255,.02), rgba(255,255,255,.008)); border:1px solid rgba(148,163,184,.12); border-radius: var(--radius); box-shadow: var(--shadow); }
    .card-header { padding:18px 20px; border-bottom:1px solid rgba(148,163,184,.12); display:flex; align-items:center; justify-content:space-between; }
    .card-body { padding:20px; }
    .row { display:grid; gap:12px; grid-template-columns: 1fr 1fr; }
    .row-3 { display:grid; gap:12px; grid-template-columns: 1fr 1fr 1fr; }
    .input { width:100%; padding:12px 14px; border-radius:12px; border:1px solid rgba(148,163,184,.22); background:#0b1220; color:var(--text); outline:none; }
    .input::placeholder { color: #64748b; }
    .btn { cursor:pointer; border:none; padding:12px 14px; border-radius:12px; font-weight:600; }
    .btn-primary { background: var(--accent-2); color:white; }
    .btn-success { background: var(--accent); color:#052e16; }
    .btn-danger { background: var(--danger); color:white; }
    .btn-ghost { background: transparent; color: var(--muted); border: 1px dashed rgba(148,163,184,.3) }
    .muted { color: var(--muted); font-size: 14px; }
    .balance { font-size: 36px; font-weight: 800; letter-spacing: .5px; }
    .pill { display:inline-flex; align-items:center; gap:8px; padding:6px 10px; border-radius:999px; border:1px solid rgba(148,163,184,.22); color: var(--muted); font-size: 12px; }
    .list { display:flex; flex-direction:column; gap:10px; max-height: 320px; overflow:auto; }
    .tx { padding:12px; border:1px solid rgba(148,163,184,.12); background:#0b1220; border-radius:12px; display:flex; align-items:center; justify-content:space-between; }
    .tx .name { font-weight:600; }
    .tx .amount.negative { color: var(--danger); }
    .tx .amount.positive { color: var(--accent); }

    .login { max-width: 480px; margin: 48px auto; text-align:center; }
    .logo { width:36px; height:36px; border-radius:9px; display:inline-grid; place-items:center; font-weight:800; color:#052e16; background:var(--accent); }
    .foot { text-align:center; padding: 28px; color: var(--muted); font-size: 13px; }
    .hidden{ display:none !important; }
    .error { color: var(--danger); font-size: 13px; margin-top: 6px; }
  </style>
</head>
<body>
  <header>
    <div class="brand">
      <div class="logo">SB</div>
      <div>
        Simple Bank <span class="badge">(Demo)</span>
      </div>
    </div>
    <div class="pill" id="userPill" aria-live="polite">Not signed in</div>
  </header>

  <!-- LOGIN VIEW -->
  <main class="container" id="loginView">
    <div class="login card">
      <div class="card-header">
        <h2>Sign in</h2>
        <span class="muted">Demo credentials below</span>
      </div>
      <div class="card-body">
        <p class="muted" style="margin-top:0">Use the demo user to explore. No backend, no real money – everything is in your browser memory.</p>
        <div class="row">
          <div>
            <label class="muted">Username</label>
            <input id="username" class="input" placeholder="e.g. demo" value="demo" />
          </div>
          <div>
            <label class="muted">Password</label>
            <input id="password" type="password" class="input" placeholder="e.g. demo" value="demo" />
          </div>
        </div>
        <div id="loginError" class="error hidden">Invalid credentials. Try <b>demo / demo</b>.</div>
        <div style="display:flex; gap:10px; justify-content:center; margin-top:16px">
          <button class="btn btn-primary" id="loginBtn">Sign in</button>
          <button class="btn btn-ghost" id="resetBtn">Reset demo data</button>
        </div>
      </div>
    </div>
  </main>

  <!-- APP VIEW -->
  <main class="container hidden" id="appView">
    <div class="grid">
      <!-- LEFT: Accounts & Actions -->
      <section class="card">
        <div class="card-header">
          <h3>Your Accounts</h3>
          <span class="pill">Secure • Demo Only</span>
        </div>
        <div class="card-body">
          <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:10px">
            <div>
              <div class="muted">Primary Balance</div>
              <div class="balance" id="balanceText">$0.00</div>
            </div>
            <div>
              <button class="btn btn-success" id="deposit20">Deposit $20</button>
            </div>
          </div>

          <div class="row">
            <div>
              <label class="muted">Deposit amount</label>
              <input id="depAmount" class="input" type="number" min="1" placeholder="e.g. 100" />
            </div>
            <div>
              <label class="muted">Withdraw amount</label>
              <input id="wdAmount" class="input" type="number" min="1" placeholder="e.g. 50" />
            </div>
          </div>
          <div style="display:flex; gap:10px; margin-top:10px">
            <button class="btn btn-success" id="depositBtn">Deposit</button>
            <button class="btn btn-danger" id="withdrawBtn">Withdraw</button>
          </div>

          <hr style="border:0; border-top:1px solid rgba(148,163,184,.12); margin:18px 0" />

          <h4 style="margin:0 0 8px">Transfer</h4>
          <div class="row">
            <div>
              <label class="muted">To (payee)</label>
              <input id="payee" class="input" placeholder="e.g. Alice" />
            </div>
            <div>
              <label class="muted">Amount</label>
              <input id="xferAmount" class="input" type="number" min="1" placeholder="e.g. 25" />
            </div>
          </div>
          <button class="btn btn-primary" style="margin-top:10px" id="transferBtn">Send Transfer</button>
          <div id="actionError" class="error hidden"></div>
        </div>
      </section>

      <!-- RIGHT: Activity -->
      <section class="card">
        <div class="card-header">
          <h3>Recent Activity</h3>
          <button class="btn btn-ghost" id="clearTx">Clear</button>
        </div>
        <div class="card-body">
          <div class="list" id="txList"></div>
          <p class="muted" id="emptyState">No transactions yet. Try a deposit or transfer.</p>
        </div>
      </section>
    </div>
  </main>

  <footer class="foot">⚠️ Demo only. No server, no persistence beyond your browser (localStorage). Built with plain HTML, CSS and JavaScript.</footer>

  <script>
    // --- Simple Banking Demo (client-side only) ---
    const fmt = n => new Intl.NumberFormat('en-US', { style:'currency', currency:'USD'}).format(n);

    const store = {
      get() {
        const raw = localStorage.getItem('sb:data');
        if (!raw) return { user: null, balance: 250, tx: [] };
        try { return JSON.parse(raw); } catch { return { user: null, balance: 250, tx: [] }; }
      },
      set(data) { localStorage.setItem('sb:data', JSON.stringify(data)); }
    };

    let state = store.get();

    const $ = sel => document.querySelector(sel);
    const byId = id => document.getElementById(id);

    const loginView = byId('loginView');
    const appView = byId('appView');
    const userPill = byId('userPill');

    function render() {
      // header
      userPill.textContent = state.user ? `Signed in as ${state.user}` : 'Not signed in';
      // balance
      byId('balanceText').textContent = fmt(state.balance);
      // transactions
      const list = byId('txList');
      list.innerHTML = '';
      if (!state.tx.length) {
        byId('emptyState').classList.remove('hidden');
      } else {
        byId('emptyState').classList.add('hidden');
        state.tx.slice().reverse().forEach(t => {
          const div = document.createElement('div');
          div.className = 'tx';
          div.innerHTML = `<div><div class="name">${t.type}</div><div class="muted">${new Date(t.at).toLocaleString()}</div></div>
                           <div class="amount ${t.amount < 0 ? 'negative' : 'positive'}">${fmt(t.amount)}</div>`;
          list.appendChild(div);
        });
      }
      store.set(state);
    }

    function setAuthed(on) {
      if (on) { loginView.classList.add('hidden'); appView.classList.remove('hidden'); }
      else { appView.classList.add('hidden'); loginView.classList.remove('hidden'); }
    }

    // --- Auth (demo) ---
    byId('loginBtn').addEventListener('click', () => {
      const u = byId('username').value.trim();
      const p = byId('password').value;
      if (u === 'demo' && p === 'demo') {
        state.user = u;
        render();
        setAuthed(true);
        byId('loginError').classList.add('hidden');
      } else {
        byId('loginError').classList.remove('hidden');
      }
    });

    byId('resetBtn').addEventListener('click', () => {
      state = { user: null, balance: 250, tx: [] };
      store.set(state);
      render();
      setAuthed(false);
    });

    // --- Actions ---
    function addTx(type, amount) { state.tx.push({ type, amount, at: Date.now() }); }

    byId('deposit20').addEventListener('click', () => {
      state.balance += 20; addTx('Quick deposit', 20); render();
    });

    byId('depositBtn').addEventListener('click', () => {
      const v = Number(byId('depAmount').value);
      if (!v || v <= 0) return showErr('Enter a valid deposit amount');
      state.balance += v; addTx('Deposit', v); clearErr(); render();
      byId('depAmount').value = '';
    });

    byId('withdrawBtn').addEventListener('click', () => {
      const v = Number(byId('wdAmount').value);
      if (!v || v <= 0) return showErr('Enter a valid withdrawal amount');
      if (v > state.balance) return showErr('Insufficient funds');
      state.balance -= v; addTx('Withdrawal', -v); clearErr(); render();
      byId('wdAmount').value = '';
    });

    byId('transferBtn').addEventListener('click', () => {
      const who = byId('payee').value.trim();
      const v = Number(byId('xferAmount').value);
      if (!who) return showErr('Enter the payee name');
      if (!v || v <= 0) return showErr('Enter a valid amount to transfer');
      if (v > state.balance) return showErr('Insufficient funds for transfer');
      state.balance -= v; addTx(`Transfer to ${who}`, -v); clearErr(); render();
      byId('payee').value = ''; byId('xferAmount').value = '';
    });

    byId('clearTx').addEventListener('click', () => { state.tx = []; render(); });

    function showErr(msg){ const e = byId('actionError'); e.textContent = msg; e.classList.remove('hidden'); }
    function clearErr(){ const e = byId('actionError'); e.textContent = ''; e.classList.add('hidden'); }

    // boot
    if (state.user) { setAuthed(true); } else { setAuthed(false); }
    render();
  </script>
</body>
</html>
