 Security Policy

Rug Pulls Bubble - is an open-source, client-side web application for visualizing Solana tokens and potential rug-pull risk indicators using public data sources (DexScreener API) and open-source libraries.

Important disclaimers
- This tool is provided **as-is** for educational and informational purposes only.  
- It does **not** constitute financial, investment, or security advice.  
- Rug-pull risk scores and checks are heuristic/approximate and can produce false positives or false negatives.  
- Always **DYOR** (Do Your Own Research) and never rely solely on this tool for financial decisions.  
- The project has **no bounty program** at this time.

 Reporting a Vulnerability

We take security seriously — even for a small, client-side tool — especially since users may act on the displayed information.

If you discover a **security vulnerability** in Rug Pulls Bubble, please report it **privately** so we can address it before it becomes public knowledge.

Preferred way to report  
Send an email to:  
chaininsanity@gmail.com  


Please include in your report:
- A clear description of the vulnerability
- Steps to reproduce (if applicable)
- Affected versions / commit hash / deployed GitHub Pages URL
- Potential impact (what could an attacker achieve?)
- Any suggested fix or mitigation (optional but very welcome)
- Your name / handle / preferred way to be credited (if you want public acknowledgment after fix)

We will acknowledge receipt of your report within **72 hours** (usually much faster) and strive to provide regular status updates.

 What we consider security issues

Examples of things we treat as security reports:

- XSS / DOM-based XSS in the client-side code
- Open redirect or other client-side injection vulnerabilities
- Leakage of unintended user data (e.g. via localStorage mishandling)
- Incorrect / unsafe usage of Solana RPC endpoints or wallet-related code (if added later)
- Supply-chain attack via unmaintained / malicious dependency
- Server-side issues on any future backend components (currently none)

**Out of scope / not security issues**:
- False positives/negatives in rug-pull detection logic (these are expected limitations)
- Rate-limiting or abuse of public APIs (DexScreener, Solana RPC)
- Design suggestions ("it would be better if…")
- Missing features ("add wallet connect", etc.)

## Disclosure Policy

- We follow a **coordinated disclosure** process.
- After validation, we aim to fix critical issues within **30 days** (best effort).
- We will credit reporters in the release notes / README / Hall-of-Fame section unless you prefer to remain anonymous.
- We ask that you **do not publicly disclose** the issue until we have had reasonable time to fix it and deploy the patch (usually 30–90 days depending on severity).

Thank you for helping keep Rug Pulls Bubble and its users safer!

## Security-related Dependencies & Best Practices

We actively:
- Keep D3.js, @solana/web3.js, and @degenfrends/solana-rugchecker up to date
- Use Dependabot (or manual checks) for dependency updates
- Run the app in a sandboxed browser context (no server-side code)
- Avoid storing any sensitive user data

If you're using this project as a base, we recommend:
- Never commit API keys or private endpoints
- Use read-only public RPC endpoints
- Consider adding CSP headers if you deploy this somewhere with server control

Last updated: February 2026
