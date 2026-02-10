# Rug Pulls Bubble

**Interactive bubble visualization of Solana tokens with rug-pull risk highlighting**  
Inspired by the beautiful [CryptoBubbles.net](https://cryptobubbles.net/) — but focused exclusively on **Solana ecosystem tokens** and designed to spotlight potential **rug pulls** and high-risk patterns.

Live demo:(https://rug-pulls-bubble-v2.netlify.app/)  
*(Replace YOUR-USERNAME after deploying to GitHub Pages)*

## Screenshot

*([Rug Pull Bubble web.PNG](https://github.com/InsanityChain/rug-pulls-bubble/blob/main/Rug%20Pull%20Bubble%20web.PNG))*

![Desktop view example](https://rug-pulls-bubble-v2.netlify.app/)
![Mobile view example](https://rug-pulls-bubble-v2.netlify.app/)

## Features

- **Bubble chart visualization** — bubbles sized by market cap / FDV, colored by rug risk (green = low risk → red = high risk)
- **Real-time-ish data** from free DexScreener API (trending Raydium / Pump.fun / Jupiter pairs on Solana)
- **Rug-pull risk scoring** using the open-source [@degenfrends/solana-rugchecker](https://github.com/degenfrends/solana-rugchecker) library
  - Checks: metadata mutability, top holder concentration, liquidity lock status, freeze/mint authority, etc.
- Fully **responsive** design — works on desktop, tablet, mobile
- Interactive: hover for details (price, 24h change, liquidity, risk score, etc.)
- Force-directed bubbles for organic, playful movement (like CryptoBubbles)
- **100% client-side** — no backend, no API keys needed (uses public Solana RPC + DexScreener)

## Important Warnings & Disclaimers

**This is NOT financial advice. Use at your own risk.**

- Rug detection is **heuristic only** — it can produce **false positives** and **false negatives**.
- Scores are **not guarantees** — many rugs bypass common checks; always **DYOR**.
- Public RPC endpoints can be slow or rate-limited → risk checks may timeout or be approximate.
- Crypto is highly speculative; rug pulls, honeypots, and scams are common on Solana.
- Never send funds or connect wallets based solely on this tool.

See [SECURITY.md](./SECURITY.md) for vulnerability reporting.

## Tech Stack

- **Frontend**: Vanilla JavaScript + D3.js v7 (force simulation + packing)
- **Solana interaction**: @solana/web3.js
- **Rug checking**: @degenfrends/solana-rugchecker
- **Data**: DexScreener public API (no key required)
- **Deployment**: Static site → GitHub Pages
- No build tools / frameworks — keep it lightweight & easy to fork

## Quick Start (Local Development)

1. Clone the repo:
   ```bash
   git clone https://github.com/YOUR-USERNAME/rug-pulls-bubble.git
   cd rug-pulls-bubble
