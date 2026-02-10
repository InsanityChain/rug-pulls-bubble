import * as d3 from 'd3';
import { SPLRugchecker } from '@degenfrends/solana-rugchecker';

// Config
const RPC_ENDPOINT = 'https://api.mainnet-beta.solana.com'; // Upgrade to Helius free key later for speed
const rugChecker = new SPLRugchecker({ solanaRpcEndpoint: RPC_ENDPOINT });
const DEXSCREENER_BASE = 'https://api.dexscreener.com/latest/dex';

let svg, g, simulation, root, node, tooltip;

// Fetch tokens (expand queries for more results)
async function fetchSolanaTokens() {
    const queries = ['raydium solana', 'pump solana', 'orca solana', 'jupiter solana'];
    let allPairs = [];
    for (const q of queries) {
        try {
            const res = await fetch(`${DEXSCREENER_BASE}/search?q=${encodeURIComponent(q)}`);
            const data = await res.json();
            allPairs = allPairs.concat(data.pairs.filter(p => p.chainId === 'solana'));
        } catch (e) { console.error(e); }
    }
    // Dedupe by address & limit to avoid overload
    const unique = [...new Map(allPairs.map(p => [p.baseToken.address, p])).values()];
    return unique.slice(0, 60).map(pair => ({
        name: pair.baseToken.symbol || '???',
        address: pair.baseToken.address,
        marketCap: pair.fdv || pair.liquidity?.usd * 2 || 10000,
        liquidity: pair.liquidity?.usd || 0,
        price: pair.priceUsd || 0,
        priceChange24h: pair.priceChange?.h24 || 0,
    }));
}

async function getRugRisk(tokenAddress) {
    try {
        const result = await rugChecker.check(tokenAddress);
        const score = rugChecker.rugScore(result) || 50;
        return {
            score,
            isRug: rugChecker.isRug(result) || score > 75,
            details: result
        };
    } catch (e) {
        console.error(e);
        return { score: 60, isRug: false, details: {} };
    }
}

function getColor(score) {
    return d3.scaleLinear()
        .domain([0, 40, 70, 100])
        .range(['#238636', '#f0b429', '#d18616', '#da3633'])(score);
}

// Render / update chart
function renderChart(tokens) {
    const enriched = tokens.map(t => ({ ...t, risk: { score: 50, isRug: false } })); // placeholder

    // We'll enrich in background to not block render
    Promise.all(enriched.map(async (t) => {
        t.risk = await getRugRisk(t.address);
        return t;
    })).then(() => updateBubbles()); // re-render once risks are ready

    // Initial render with placeholders
    updateBubbles(enriched);
}

function updateBubbles(data = null) {
    if (!data) data = root?.data?.children?.map(d => d.data) || [];

    const width = window.innerWidth;
    const height = window.innerHeight;

    if (!svg) {
        svg = d3.select('#chart')
            .append('svg')
            .attr('viewBox', `0 0 ${width} ${height}`)
            .attr('preserveAspectRatio', 'xMidYMid meet')
            .style('width', '100%')
            .style('height', '100%');

        g = svg.append('g');
    } else {
        svg.attr('viewBox', `0 0 ${width} ${height}`);
    }

    const pack = d3.pack()
        .size([width, height])
        .padding(4);

    const hierarchy = d3.hierarchy({ children: data })
        .sum(d => Math.max(d.marketCap, 5000)); // avoid zero-size bubbles

    root = pack(hierarchy);

    // Circles
    node = g.selectAll('.node')
        .data(root.leaves(), d => d.data.address);

    const nodeEnter = node.enter().append('g')
        .attr('class', 'node')
        .attr('transform', d => `translate(${d.x},${d.y})`);

    nodeEnter.append('circle')
        .attr('class', 'bubble')
        .attr('r', d => d.r)
        .attr('fill', d => getColor(d.data.risk?.score ?? 50));

    nodeEnter.append('text')
        .attr('class', 'label')
        .text(d => d.data.name.substring(0, Math.floor(d.r / 4)));

    // Merge & update
    node = nodeEnter.merge(node);
    node.select('circle')
        .attr('r', d => d.r)
        .attr('fill', d => getColor(d.data.risk?.score ?? 50));

    node.select('text')
        .text(d => d.data.name.substring(0, Math.floor(d.r / 4)));

    node.transition().duration(750)
        .attr('transform', d => `translate(${d.x},${d.y})`);

    // Tooltip
    tooltip = d3.select('#tooltip');
    node.on('mouseover', function(event, d) {
        const risk = d.data.risk || { score: 'N/A' };
        tooltip.style('display', 'block')
            .html(`
<strong>${d.data.name} (${d.data.address.slice(0,6)}...)</strong><br>
Price: $${(d.data.price || 0).toFixed(6)}<br>
Market Cap: $${(d.data.marketCap || 0).toLocaleString()}<br>
24h: ${d.data.priceChange24h?.toFixed(1) ?? '?'}%<br>
Liquidity: $${(d.data.liquidity || 0).toLocaleString()}<br>
Rug Risk: ${risk.score}/100 ${risk.isRug ? '⚠ HIGH' : ''}<br>
            `);
        const [x, y] = d3.pointer(event, svg.node());
        tooltip.style('left', `${x + 15}px`).style('top', `${y + 15}px`);
    })
    .on('mouseout', () => tooltip.style('display', 'none'));

    // Force for movement
    if (simulation) simulation.stop();

    simulation = d3.forceSimulation(root.leaves())
        .force('charge', d3.forceManyBody().strength(d => -d.r * 1.5))
        .force('center', d3.forceCenter(width / 2, height / 2))
        .force('collision', d3.forceCollide().radius(d => d.r + 2).strength(0.9))
        .force('x', d3.forceX(width / 2).strength(0.05))
        .force('y', d3.forceY(height / 2).strength(0.05))
        .on('tick', () => {
            node.attr('transform', d => `translate(${d.x},${d.y})`);
        })
        .alphaDecay(0.02);
}

// Main
async function init() {
    const tokens = await fetchSolanaTokens();
    renderChart(tokens);

    // Resize handler
    const resize = () => {
        updateBubbles(); // Re-packs & re-centers
    };

    window.addEventListener('resize', () => {
        clearTimeout(window.resizeTimer);
        window.resizeTimer = setTimeout(resize, 150); // debounce
    });
}

init().catch(console.error);