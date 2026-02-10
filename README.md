# 🫧 Rug Pulls Bubble
> Visualize Solana token rug-pull risks with interactive bubbles. **Educational tool only - NOT financial advice.**

[![Deployed with GitHub Pages](https://img.shields.io/badge/Deploy-GitHub_Pages-2ea44f)](https://insanitychain.github.io/rug-pulls-bubble/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

![Demo](https://github.com/InsanityChain/rug-pulls-bubble/tree/main/screenshot.PNG) <!-- ADD REAL SCREENSHOT LATER -->

## 🔒 Critical Disclaimer
- **Rug detection is imperfect** - false results happen
- **Never risk funds** based on this tool
- Public RPCs are slow/unreliable - use Helius free tier for better experience
- Data sourced from DexScreener (no affiliation)

## 🌐 Live Demo
https://rug-pulls-bubble-v2.netlify.app/

## 🚀 Features
- 🔴🟢 Bubbles colored by rug-risk score (0-100)
- 📱 Fully responsive (mobile/desktop)
- 🔍 Zoom/pan with mouse/touch
- 🎚️ Filter by risk threshold
- 💡 Hover tooltips with token metrics
- ⚡ Zero dependencies beyond CDN-loaded D3

## 🗺️ Roadmap
| Priority | Feature |
|----------|---------|
| ✅ | Core bubble visualization |
| ✅ | Rug risk scoring (solana-rugchecker) |
| ✅ | Zoom/pan + risk filtering |
| 🟡 | Helius RPC integration guide |
| 🟡 | "High-risk only" toggle |
| 🔴 | Birdeye API integration |
| 🔴 | Chrome extension version |

## 🛠️ Deploy Your Own
1. Fork this repo
2. Go to **Settings → Pages** → Select `main` branch, `/ (root)`
3. Wait 2 minutes → Visit `https://<your-username>.github.io/rug-pulls-bubble/`
4. *(Optional)* Add Helius RPC key in `app.js` for faster checks

## 🤝 Contributing
PRs welcome! Focus areas:
- Mobile performance optimizations
- Better risk visualization (icons, gradients)
- Accessibility improvements
- Additional data sources (Birdeye, etc.)

⚠️ **All contributions must include updated disclaimers**

## 📜 License
MIT License - See [LICENSE](LICENSE)  
*Includes critical disclaimers required for crypto tools*

## Quick Start (Local Development)

1. Clone the repo:
   ```bash
   git clone https://github.com/nsanityChain/rug-pulls-bubble.git
   cd rug-pulls-bubble
