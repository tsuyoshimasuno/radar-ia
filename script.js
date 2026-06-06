/* ============================================================
   SOURCES DEFINITION
   ============================================================ */
const SOURCES = [
    { id: 'mckinsey',    name: 'McKinsey',        color: '#4a9eff', tier: 'auto',   rssUrl: 'https://www.mckinsey.com/business-functions/mckinsey-digital/our-insights/rss' },
    { id: 'mit',         name: 'MIT Tech Review',  color: '#ff6b6b', tier: 'auto',   rssUrl: 'https://www.technologyreview.com/feed/' },
    { id: 'anthropic',   name: 'Anthropic Blog',   color: '#8b5cf6', tier: 'auto',   rssUrl: null },
    { id: 'deepmind',    name: 'DeepMind Blog',    color: '#06b6d4', tier: 'auto',   rssUrl: null },
{ id: 'venturebeat', name: 'VentureBeat',      color: '#f59e0b', tier: 'rss',    rssUrl: 'https://venturebeat.com/category/ai/feed/' },
    { id: 'gartner',     name: 'Gartner',          color: '#ffb800', tier: 'manual', rssUrl: 'https://news.google.com/rss/search?q=site:gartner.com+%22artificial+intelligence%22&hl=pt-BR&gl=BR&ceid=BR:pt-419' },
    { id: 'forrester',   name: 'Forrester',        color: '#e879f9', tier: 'manual', rssUrl: null },
    { id: 'svpg',        name: 'SVPG',             color: '#f97316', tier: 'manual', rssUrl: null },
    { id: 'tiinside',   name: 'TI Inside',        color: '#10b981', tier: 'auto',   rssUrl: null },
];

const SOURCE_MAP = Object.fromEntries(SOURCES.map(s => [s.id, s]));


/* ============================================================
   TAG DESCRIPTIONS (for reading panel key points)
   ============================================================ */
const TAG_DESCRIPTIONS = {
    'GenAI':          'IA generativa aplicada a conteúdo, código, imagens e automação criativa',
    'LLM':            'Modelos de linguagem de grande porte — capacidades, benchmarks e evolução',
    'Agentic AI':     'Sistemas autônomos que planejam, raciocinam e executam tarefas de múltiplos passos',
    'Estratégia':     'Adoção corporativa, casos de uso reais e impacto competitivo nos negócios',
    'Ética':          'Uso responsável, viés, transparência e governança de sistemas de IA',
    'Regulação':      'Leis, frameworks e políticas públicas para regulação de IA no mundo',
    'Segurança':      'Ameaças, vulnerabilidades e defesas em sistemas que usam modelos de IA',
    'Multimodalidade':'Processamento simultâneo de texto, imagens, áudio, vídeo e código',
    'Hardware':       'Chips, GPUs, infraestrutura e capacidade computacional para IA',
    'Pesquisa':       'Avanços científicos, papers e publicações acadêmicas recentes',
    'ROI':            'Métricas de retorno, produtividade e valor de negócio gerado pela IA',
    'Mercado':        'Investimentos, valuations, competição e dinâmica do setor',
    'Edge AI':        'IA em dispositivos locais com baixa latência e menor custo de inferência',
    'Tecnologia':     'Avanços técnicos, frameworks e implementações práticas de IA',
};


/* ============================================================
   STATE
   ============================================================ */
let allArticles = [];
let activeSourceFilter = 'all';
let searchQuery = '';
let sortOrder = 'recent';
let generatedPostsCount = 0;
let currentModalArticle = null;

/* ============================================================
   DOM REFS
   ============================================================ */
const themeToggleBtn    = document.getElementById('theme-toggle');
const refreshBtn        = document.getElementById('refresh-btn');
const syncDot           = document.getElementById('sync-dot');
const syncText          = document.getElementById('sync-text');
const sourcesList       = document.getElementById('sources-list');
const searchInput       = document.getElementById('search-input');
const clearSearchBtn    = document.getElementById('clear-search-btn');
const sortSelect        = document.getElementById('sort-select');
const addUrlBtn         = document.getElementById('add-url-btn');
const addUrlPanel       = document.getElementById('add-url-panel');
const urlInput          = document.getElementById('url-input');
const urlConfirmBtn     = document.getElementById('url-confirm-btn');
const urlConfirmText    = document.getElementById('url-confirm-text');
const urlConfirmLoading = document.getElementById('url-confirm-loading');
const urlCancelBtn      = document.getElementById('url-cancel-btn');
const addUrlError       = document.getElementById('add-url-error');
const loadingSpinner    = document.getElementById('loading-spinner');
const emptyState        = document.getElementById('empty-state');
const timelineGroups    = document.getElementById('timeline-groups');
const readingBackdrop   = document.getElementById('reading-backdrop');
const readingPanel      = document.getElementById('reading-panel');
const readingCloseBtn   = document.getElementById('reading-close-btn');
const rpSourceBadge     = document.getElementById('rp-source-badge');
const rpDate            = document.getElementById('rp-date');
const rpTitle           = document.getElementById('rp-title');
const rpTags            = document.getElementById('rp-tags');
const rpSummary         = document.getElementById('rp-summary');
const rpTopics          = document.getElementById('rp-topics');
const rpLink            = document.getElementById('rp-link');
const linkedinOverlay   = document.getElementById('linkedin-overlay');
const linkedinBackdrop  = document.getElementById('linkedin-backdrop');
const modalArticleRef   = document.getElementById('modal-article-ref');
const modalCloseBtn     = document.getElementById('modal-close-btn');
const modalGenerating   = document.getElementById('modal-generating');
const modalPostArea     = document.getElementById('modal-post-area');
const postTextarea      = document.getElementById('post-textarea');
const charCount         = document.getElementById('char-count');
const linkedinModalFooter = document.getElementById('linkedin-modal-footer');
const btnModalCancel    = document.getElementById('btn-modal-cancel');
const btnModalRegenerate = document.getElementById('btn-modal-regenerate');
const btnModalPublish   = document.getElementById('btn-modal-publish');

/* ============================================================
   INIT
   ============================================================ */
document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    loadPersistedData();
    initSidebar();
    setupEventListeners();
    syncArticles();
});

/* ============================================================
   THEME
   ============================================================ */
function initTheme() {
    const saved = localStorage.getItem('radar_theme') || 'dark';
    document.documentElement.setAttribute('data-theme', saved);
    updateThemeIcon(saved);

    themeToggleBtn.addEventListener('click', () => {
        const curr = document.documentElement.getAttribute('data-theme');
        const next = curr === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem('radar_theme', next);
        updateThemeIcon(next);
    });
}

function updateThemeIcon(theme) {
    const icon = themeToggleBtn.querySelector('i');
    if (theme === 'light') {
        icon.className = 'fa-solid fa-sun';
    } else {
        icon.className = 'fa-solid fa-moon';
    }
}

/* ============================================================
   PERSISTED DATA (bookmarks + posts count)
   ============================================================ */
function loadPersistedData() {
    try {
        generatedPostsCount = parseInt(localStorage.getItem('radar_posts') || '0', 10);
    } catch (e) {
        console.warn('Could not load persisted data', e);
    }
}

function persistSavedArticles() {
    const savedIds = allArticles.filter(a => a.saved).map(a => a.id);
    localStorage.setItem('radar_saved', JSON.stringify(savedIds));
}

/* ============================================================
   SIDEBAR
   ============================================================ */
function initSidebar() {
    renderSourcesList();
    updateStats();
}

function renderSourcesList() {
    sourcesList.innerHTML = '';

    // "All" option
    const allItem = document.createElement('li');
    allItem.className = `source-item ${activeSourceFilter === 'all' ? 'active' : ''}`;
    allItem.dataset.id = 'all';
    allItem.innerHTML = `
        <span class="source-dot" style="background:#6366f1"></span>
        <span class="source-item-name">Todas as fontes</span>
    `;
    allItem.addEventListener('click', () => setSourceFilter('all'));
    sourcesList.appendChild(allItem);

    SOURCES.forEach(source => {
        const count = allArticles.filter(a => a.source_id === source.id).length;
        const li = document.createElement('li');
        li.className = `source-item ${activeSourceFilter === source.id ? 'active' : ''}`;
        li.dataset.id = source.id;
        li.innerHTML = `
            <span class="source-dot" style="background:${source.color}"></span>
            <span class="source-item-name">${source.name}</span>
            <span class="source-item-right">
                ${count > 0 ? `<span class="source-count">${count}</span>` : ''}
            </span>
        `;
        li.addEventListener('click', () => setSourceFilter(source.id));
        sourcesList.appendChild(li);
    });
}

function setSourceFilter(id) {
    activeSourceFilter = id;
    renderSourcesList();
    renderTimeline();
}

function updateStats() {
    const weekAgo = new Date(Date.now() - 7 * 86400000);
    const weekArticles = allArticles.filter(a => new Date(a.published_at) >= weekAgo);
    const activeSources = new Set(weekArticles.map(a => a.source_id)).size;
    const savedCount = allArticles.filter(a => a.saved).length;

    document.getElementById('stat-articles').textContent = weekArticles.length;
    document.getElementById('stat-sources').textContent  = activeSources;
    document.getElementById('stat-posts').textContent    = generatedPostsCount;
    document.getElementById('stat-saved').textContent    = savedCount;
}

/* ============================================================
   SYNC / FETCH
   ============================================================ */
function syncArticles() {
    setSyncStatus('loading', 'Sincronizando...');
    loadingSpinner.style.display = 'flex';
    emptyState.style.display = 'none';
    timelineGroups.innerHTML = '';

    const articleMap = new Map();

    // Load RSS articles from rss_data.js (managed by update_rss.ps1)
    let rssCount = 0;
    if (window.RSS_ARTICLES && Array.isArray(window.RSS_ARTICLES)) {
        window.RSS_ARTICLES.forEach(a => {
            const source = SOURCE_MAP[a.source_id] || {};
            const art = enrichArticle({
                id: 'rss-' + urlHash(a.url),
                url: a.url,
                title: a.title_pt || a.title,
                source_id: a.source_id,
                collection_tier: source.tier || 'rss',
                summary: a.summary_pt || a.summary || '',
                tags: autoTags((a.title_pt || a.title) + ' ' + (a.summary_pt || a.summary || '')),
                published_at: (a.pub_date || a.first_seen) + 'T12:00:00.000Z',
                saved: false,
                linkedin_generated: false,
            });
            articleMap.set(art.url, art);
            rssCount++;
        });
    }

    // Load manually added articles
    try {
        const manual = JSON.parse(localStorage.getItem('radar_manual') || '[]');
        manual.forEach(a => articleMap.set(a.url, enrichArticle(a)));
    } catch (e) { /* ignore */ }

    // Load Gartner scraped articles from gartner_data.js
    if (window.GARTNER_ARTICLES && Array.isArray(window.GARTNER_ARTICLES)) {
        window.GARTNER_ARTICLES.forEach(a => {
            const art = enrichArticle({
                id: 'gartner-' + urlHash(a.url),
                url: a.url,
                title: a.title_pt || a.title,
                source_id: 'gartner',
                collection_tier: 'auto',
                summary: a.summary_pt || '',
                tags: autoTags(a.title_pt || a.title),
                published_at: a.first_seen + 'T12:00:00.000Z',
                saved: false,
                linkedin_generated: false,
            });
            articleMap.set(art.url, art);
        });
    }

    // Load SVPG articles from svpg_data.js
    if (window.SVPG_ARTICLES && Array.isArray(window.SVPG_ARTICLES)) {
        window.SVPG_ARTICLES.forEach(a => {
            const art = enrichArticle({
                id: 'svpg-' + urlHash(a.url),
                url: a.url,
                title: a.title_pt || a.title,
                source_id: 'svpg',
                collection_tier: 'manual',
                summary: a.summary_pt || '',
                tags: autoTags(a.title_pt || a.title),
                published_at: a.first_seen + 'T12:00:00.000Z',
                saved: false,
                linkedin_generated: false,
            });
            articleMap.set(art.url, art);
        });
    }

    allArticles = Array.from(articleMap.values());

    // Re-apply saved flags
    try {
        const savedIds = JSON.parse(localStorage.getItem('radar_saved') || '[]');
        allArticles.forEach(a => { if (savedIds.includes(a.id)) a.saved = true; });
    } catch (e) { /* ignore */ }

    loadingSpinner.style.display = 'none';

    const t = new Date();
    const timeStr = `${String(t.getHours()).padStart(2,'0')}:${String(t.getMinutes()).padStart(2,'0')}`;
    setSyncStatus('connected', `Carregado às ${timeStr} · ${rssCount} artigos RSS`);

    renderSourcesList();
    updateStats();
    renderTimeline();
}

function enrichArticle(art) {
    const source = SOURCE_MAP[art.source_id] || { name: art.source_id, color: '#888888', tier: 'manual' };
    return {
        ...art,
        source_name:  source.name,
        source_color: source.color,
    };
}


/* ============================================================
   UTILITIES
   ============================================================ */
function urlHash(url) {
    let h = 0;
    for (let i = 0; i < url.length; i++) {
        h = (Math.imul(31, h) + url.charCodeAt(i)) | 0;
    }
    return Math.abs(h).toString(36);
}

function autoTags(text) {
    const t = text.toLowerCase();
    const tags = [];
    if (/genai|generative|gpt|copilot|sora|claude/.test(t))            tags.push('GenAI');
    if (/llm|language model|transformer|foundation model/.test(t))      tags.push('LLM');
    if (/agent|agente|autonomous|autônomo|agentic/.test(t))             tags.push('Agentic AI');
    if (/strategy|business|ceo|market|estratégia|mercado/.test(t))      tags.push('Estratégia');
    if (/ethic|ética|bias|regulation|regulação|copyright/.test(t))      tags.push('Ética');
    if (/security|segurança|privacy|cyber/.test(t))                     tags.push('Segurança');
    if (/multimodal|vision|image|audio/.test(t))                        tags.push('Multimodalidade');
    if (/hardware|chip|gpu|energy|energia/.test(t))                     tags.push('Hardware');
    return tags.length > 0 ? tags.slice(0, 3) : ['Tecnologia'];
}

function formatTime(isoString) {
    const d = new Date(isoString);
    if (isNaN(d.getTime())) return '';
    return `${String(d.getHours()).padStart(2,'0')}:${String(d.getMinutes()).padStart(2,'0')}`;
}

function setSyncStatus(status, text) {
    syncDot.className = `sync-dot status-${status}`;
    syncText.textContent = text;
}

/* ============================================================
   FILTERING & SORTING
   ============================================================ */
function getFilteredArticles() {
    let list = [...allArticles];

    // Source filter
    if (activeSourceFilter !== 'all') {
        list = list.filter(a => a.source_id === activeSourceFilter);
    }

    // Sort/mode
    if (sortOrder === 'saved') {
        list = list.filter(a => a.saved);
    } else if (sortOrder === 'source') {
        list.sort((a, b) => {
            const sc = a.source_id.localeCompare(b.source_id);
            if (sc !== 0) return sc;
            return new Date(b.published_at) - new Date(a.published_at);
        });
    } else {
        list.sort((a, b) => new Date(b.published_at) - new Date(a.published_at));
    }

    // Text search
    if (searchQuery) {
        const q = searchQuery.toLowerCase();
        list = list.filter(a =>
            a.title.toLowerCase().includes(q) ||
            (a.summary || '').toLowerCase().includes(q) ||
            (a.source_name || '').toLowerCase().includes(q) ||
            a.tags.some(t => t.toLowerCase().includes(q))
        );
    }

    return list;
}

/* ============================================================
   TIMELINE GROUPING
   ============================================================ */
function groupByDay(articles) {
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    const groupMap = {};

    articles.forEach(art => {
        const d = new Date(art.published_at);
        if (isNaN(d.getTime())) return;
        const dayKey = new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
        const dayDate = new Date(dayKey);

        let label;
        if (dayKey === today.getTime()) {
            label = 'Hoje';
        } else if (dayKey === yesterday.getTime()) {
            label = 'Ontem';
        } else {
            label = dayDate.toLocaleDateString('pt-BR', { day: 'numeric', month: 'short' });
        }

        if (!groupMap[dayKey]) groupMap[dayKey] = { label, key: dayKey, items: [] };
        groupMap[dayKey].items.push(art);
    });

    return Object.values(groupMap).sort((a, b) => b.key - a.key);
}

/* ============================================================
   RENDER TIMELINE
   ============================================================ */
function renderTimeline() {
    timelineGroups.innerHTML = '';

    const articles = getFilteredArticles();

    if (articles.length === 0) {
        emptyState.style.display = 'flex';
        return;
    }

    emptyState.style.display = 'none';

    const groups = groupByDay(articles);

    groups.forEach(group => {
        const groupEl = document.createElement('div');
        groupEl.className = 'day-group';

        const count = group.items.length;
        groupEl.innerHTML = `
            <div class="day-group-header">
                <span class="day-label">${group.label} — ${count} artigo${count !== 1 ? 's' : ''}</span>
                <div class="day-line"></div>
            </div>
            <div class="articles-list"></div>
        `;

        const listEl = groupEl.querySelector('.articles-list');
        group.items.forEach(art => listEl.appendChild(buildArticleRow(art)));

        timelineGroups.appendChild(groupEl);
    });
}

function buildArticleRow(art) {
    const source = SOURCE_MAP[art.source_id] || { name: art.source_name || art.source_id, color: '#888888' };
    const color  = source.color;
    const time   = formatTime(art.published_at);
    const tagsHtml = art.tags.map(t => `<span class="tag-pill">${escapeHtml(t)}</span>`).join('');

    const row = document.createElement('div');
    row.className = 'article-row';
    row.innerHTML = `
        <div class="article-meta-col">
            <span class="article-time">${time}</span>
            <span class="article-source-badge" style="background:${color}1a; color:${color};">${escapeHtml(source.name.toUpperCase())}</span>
        </div>
        <div class="article-content-col">
            <h3 class="article-row-title">
                <button class="article-title-btn">${escapeHtml(art.title)}</button>
            </h3>
            ${art.summary ? `<p class="article-row-summary">${escapeHtml(art.summary)}</p>` : ''}
            <div class="article-row-tags">${tagsHtml}</div>
        </div>
        <div class="article-actions-col">
            <button class="btn-bookmark-row ${art.saved ? 'bookmarked' : ''}"
                    aria-label="${art.saved ? 'Remover dos salvos' : 'Salvar artigo'}">
                <i class="${art.saved ? 'fa-solid' : 'fa-regular'} fa-bookmark"></i>
            </button>
            <button class="btn-linkedin-post ${art.linkedin_generated ? 'generated' : ''}"
                    aria-label="Gerar post LinkedIn">
                in Post
            </button>
        </div>
    `;

    row.querySelector('.article-title-btn').addEventListener('click', () => openReadingPanel(art));

    row.querySelector('.btn-bookmark-row').addEventListener('click', e => {
        e.stopPropagation();
        toggleSave(art, row);
    });

    row.querySelector('.btn-linkedin-post').addEventListener('click', e => {
        e.stopPropagation();
        openLinkedInModal(art);
    });

    return row;
}

function summaryToHtml(text) {
    if (!text) return '<p>Resumo não disponível para este artigo.</p>';
    return text.split(/\n\n+/).map(para => {
        const lines = para.split('\n');
        if (lines.some(l => l.startsWith('- '))) {
            const nonBullet = lines.filter(l => !l.startsWith('- '));
            const bullets   = lines.filter(l =>  l.startsWith('- '));
            const label = nonBullet.length
                ? `<p class="summary-label">${escapeHtml(nonBullet.join(' ').trim())}</p>`
                : '';
            const items = bullets.map(l => `<li>${escapeHtml(l.slice(2))}</li>`).join('');
            return `${label}<ul>${items}</ul>`;
        }
        return `<p>${escapeHtml(para.trim())}</p>`;
    }).join('');
}

function escapeHtml(str) {
    return String(str)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

/* ============================================================
   BOOKMARK / SAVE
   ============================================================ */
function toggleSave(art, rowEl) {
    art.saved = !art.saved;

    const btn = rowEl.querySelector('.btn-bookmark-row');
    btn.className = `btn-bookmark-row ${art.saved ? 'bookmarked' : ''}`;
    btn.innerHTML = `<i class="${art.saved ? 'fa-solid' : 'fa-regular'} fa-bookmark"></i>`;
    btn.setAttribute('aria-label', art.saved ? 'Remover dos salvos' : 'Salvar artigo');

    persistSavedArticles();
    updateStats();

    // If currently in "saved" filter, re-render to reflect removal
    if (sortOrder === 'saved' && !art.saved) renderTimeline();
}

/* ============================================================
   READING PANEL
   ============================================================ */
function openReadingPanel(art) {
    const source = SOURCE_MAP[art.source_id] || { name: art.source_name || art.source_id, color: '#888888' };
    const color  = source.color;

    rpSourceBadge.textContent = source.name;
    rpSourceBadge.style.cssText = `background:${color}1a; color:${color};`;

    const d = new Date(art.published_at);
    rpDate.textContent = isNaN(d) ? '' : d.toLocaleDateString('pt-BR', {
        day: 'numeric', month: 'long', year: 'numeric', hour: '2-digit', minute: '2-digit'
    });

    rpTitle.textContent = art.title;

    rpTags.innerHTML = art.tags
        .map(t => `<span class="tag-pill">${escapeHtml(t)}</span>`)
        .join('');

    rpSummary.innerHTML = summaryToHtml(art.summary);

    rpTopics.innerHTML = '';
    const topicTags = art.tags.length > 0 ? art.tags : ['Tecnologia'];
    topicTags.forEach(tag => {
        const desc = TAG_DESCRIPTIONS[tag] || 'Tópico relevante abordado neste artigo';
        const li = document.createElement('li');
        li.className = 'reading-topic-item';
        li.innerHTML = `
            <span class="reading-topic-dot" style="background:${color};"></span>
            <span class="reading-topic-text">
                <span class="reading-topic-name">${escapeHtml(tag)}:</span>
                <span class="reading-topic-desc"> ${escapeHtml(desc)}</span>
            </span>
        `;
        rpTopics.appendChild(li);
    });

    rpLink.href = art.url;

    readingBackdrop.classList.add('open');
    readingPanel.classList.add('open');
    document.body.style.overflow = 'hidden';
}

function closeReadingPanel() {
    readingBackdrop.classList.remove('open');
    readingPanel.classList.remove('open');
    document.body.style.overflow = '';
}

/* ============================================================
   ADD URL
   ============================================================ */
function openAddUrlPanel() {
    addUrlPanel.classList.add('open');
    addUrlError.classList.remove('visible');
    urlInput.value = '';
    urlInput.focus();
}

function closeAddUrlPanel() {
    addUrlPanel.classList.remove('open');
    setUrlBtnLoading(false);
}

function setUrlBtnLoading(loading) {
    urlConfirmText.style.display    = loading ? 'none' : 'inline';
    urlConfirmLoading.style.display = loading ? 'inline-flex' : 'none';
    urlConfirmBtn.disabled          = loading;
}

async function handleAddUrl() {
    const url = urlInput.value.trim();
    if (!url) {
        showUrlError('Por favor, insira uma URL válida.');
        return;
    }

    if (allArticles.some(a => a.url === url)) {
        showUrlError('Este artigo já foi adicionado.');
        return;
    }

    setUrlBtnLoading(true);
    addUrlError.classList.remove('visible');

    try {
        const meta = await fetchUrlMetadata(url);

        const newArticle = enrichArticle({
            id: 'manual-' + urlHash(url),
            url,
            title: meta.title || url,
            source_id: meta.sourceId || 'forrester',
            collection_tier: 'manual',
            summary: meta.summary || '',
            tags: autoTags((meta.title || '') + ' ' + (meta.summary || '')),
            published_at: meta.published_at || new Date().toISOString(),
            saved: false,
            linkedin_generated: false,
        });

        allArticles.push(newArticle);

        // Persist manual articles
        try {
            const existing = JSON.parse(localStorage.getItem('radar_manual') || '[]');
            existing.push(newArticle);
            localStorage.setItem('radar_manual', JSON.stringify(existing));
        } catch (e) { /* ignore */ }

        closeAddUrlPanel();
        renderSourcesList();
        updateStats();
        renderTimeline();
    } catch (err) {
        showUrlError('Não foi possível extrair o conteúdo desta URL. Verifique se é acessível publicamente.');
        setUrlBtnLoading(false);
    }
}

function showUrlError(msg) {
    addUrlError.textContent = msg;
    addUrlError.classList.add('visible');
}

async function fetchUrlMetadata(url) {
    const proxyUrl = `https://api.allorigins.win/get?url=${encodeURIComponent(url)}`;
    const response = await fetch(proxyUrl, { signal: AbortSignal.timeout(15000) });
    if (!response.ok) throw new Error('Proxy error');

    const data = await response.json();
    if (!data.contents) throw new Error('Empty response');

    const doc = new DOMParser().parseFromString(data.contents, 'text/html');

    const title =
        doc.querySelector('meta[property="og:title"]')?.getAttribute('content') ||
        doc.querySelector('h1')?.textContent?.trim() ||
        doc.title || url;

    const summary =
        doc.querySelector('meta[property="og:description"]')?.getAttribute('content') ||
        doc.querySelector('meta[name="description"]')?.getAttribute('content') ||
        '';

    const published_at =
        doc.querySelector('meta[property="article:published_time"]')?.getAttribute('content') ||
        doc.querySelector('time[datetime]')?.getAttribute('datetime') ||
        new Date().toISOString();

    const siteName =
        doc.querySelector('meta[property="og:site_name"]')?.getAttribute('content') ||
        (() => { try { return new URL(url).hostname.replace(/^www\./, ''); } catch { return url; } })();

    // Try to match site to known sources
    const domain = (() => { try { return new URL(url).hostname; } catch { return ''; } })();
    let sourceId = 'forrester';
    for (const s of SOURCES) {
        if (domain.includes(s.id) || domain.includes(s.name.toLowerCase().replace(/\s/g,''))) {
            sourceId = s.id;
            break;
        }
    }
    if (domain.includes('gartner'))    sourceId = 'gartner';
    if (domain.includes('mckinsey'))   sourceId = 'mckinsey';
    if (domain.includes('mit') || domain.includes('technologyreview')) sourceId = 'mit';
if (domain.includes('venturebeat')) sourceId = 'venturebeat';
    if (domain.includes('anthropic'))  sourceId = 'anthropic';
    if (domain.includes('deepmind') || domain.includes('google')) sourceId = 'deepmind';
    if (domain.includes('forrester'))  sourceId = 'forrester';

    return { title: title.trim(), summary: summary.trim(), published_at, siteName, sourceId };
}

/* ============================================================
   LINKEDIN MODAL
   ============================================================ */
function openLinkedInModal(art) {
    currentModalArticle = art;
    modalArticleRef.textContent = art.title;

    // Show overlay
    linkedinOverlay.classList.add('open');
    document.body.style.overflow = 'hidden';

    // Show generating state
    modalGenerating.style.display = 'flex';
    modalPostArea.style.display   = 'none';
    linkedinModalFooter.classList.remove('visible');

    // Simulate generation delay (300-800ms) then show result
    const delay = 400 + Math.random() * 400;
    setTimeout(() => {
        const post = buildLinkedInPost(art);
        postTextarea.value = post;
        updateCharCount();

        modalGenerating.style.display = 'none';
        modalPostArea.style.display   = 'block';
        linkedinModalFooter.classList.add('visible');
    }, delay);
}

function closeLinkedInModal() {
    linkedinOverlay.classList.remove('open');
    document.body.style.overflow = '';
    currentModalArticle = null;
}

function buildLinkedInPost(art) {
    const title   = art.title || '';
    const summary = art.summary || '';
    const source  = art.source_name || '';
    const tags    = art.tags || [];

    const hook = title.length > 90 ? title.slice(0, 87) + '…' : title;

    const implications = getImplications(tags);
    const hashtags = [
        ...tags.slice(0, 3).map(t => '#' + t.replace(/[\s\-]/g, '')),
        '#InteligenciaArtificial',
        '#IA',
    ].slice(0, 5).join(' ');

    return `${hook}

${summary}

O que isso muda na prática:
→ ${implications[0]}
→ ${implications[1]}
→ ${implications[2]}

Como você e sua equipe estão se preparando para essa transformação?

Fonte: ${source}

${hashtags}`;
}

function getImplications(tags) {
    const map = {
        'GenAI':       ['A produtividade em criação de conteúdo pode crescer significativamente com as ferramentas certas', 'Equipes que dominarem IA generativa terão vantagem competitiva real e mensurável', 'A qualidade dos outputs já supera expectativas em vários casos de uso empresarial'],
        'LLM':         ['Modelos maiores exigem novas estratégias de implantação e otimização de custos', 'O preço de inferência continua caindo — democratizando o acesso à IA avançada', 'Fine-tuning e RAG se consolidam como abordagens práticas para personalização corporativa'],
        'Agentic AI':  ['Agentes autônomos já executam tarefas complexas sem supervisão contínua', 'Workflows de múltiplos agentes exigem nova governança e monitoramento ativo', 'A transição de assistentes reativos para agentes proativos é real, urgente e irreversível'],
        'Estratégia':  ['Líderes que não adaptarem suas estratégias perderão posição rapidamente', 'A fase de experimentação chegou ao fim — é hora de escalar com responsabilidade', 'ROI tangível já é demonstrável em marketing, vendas e desenvolvimento de produtos'],
        'Ética':       ['Frameworks de governança de IA deixaram de ser opcionais para empresas sérias', 'Regulação está chegando — quem se preparar antes sairá na frente', 'Transparência e explicabilidade dos modelos são diferenciais competitivos crescentes'],
        'Segurança':   ['Superfícies de ataque crescem com a adoção acelerada de IA nos processos críticos', 'Red teaming e testes adversariais de modelos devem ser parte do ciclo de desenvolvimento', 'Privacidade de dados de treinamento é o próximo grande campo de batalha regulatório'],
    };

    for (const tag of tags) {
        if (map[tag]) return map[tag];
    }

    return [
        'Organizações precisam revisar seus processos internos à luz dessa mudança',
        'Profissionais que ignorarem essa tendência terão dificuldades crescentes de empregabilidade',
        'A adoção estruturada e responsável é o diferencial das empresas líderes em tecnologia',
    ];
}

function updateCharCount() {
    const len = postTextarea.value.length;
    charCount.textContent = len;
    const counter = charCount.closest('.char-counter');
    if (len > 1300) counter.classList.add('over-limit');
    else counter.classList.remove('over-limit');
}

function handlePublish() {
    if (!currentModalArticle) return;

    // Mark article as having generated post
    currentModalArticle.linkedin_generated = true;
    generatedPostsCount++;
    localStorage.setItem('radar_posts', String(generatedPostsCount));

    // Update the LinkedIn button in the timeline row
    const btns = document.querySelectorAll('.btn-linkedin-post');
    btns.forEach(btn => {
        const row = btn.closest('.article-row');
        if (row) {
            const titleBtn = row.querySelector('.article-title-btn');
            if (titleBtn && titleBtn.textContent.trim() === currentModalArticle.title) {
                btn.classList.add('generated');
            }
        }
    });

    updateStats();
    closeLinkedInModal();
}

/* ============================================================
   EVENT LISTENERS
   ============================================================ */
function setupEventListeners() {
    // Refresh
    refreshBtn.addEventListener('click', syncArticles);

    // Search
    searchInput.addEventListener('input', e => {
        searchQuery = e.target.value.trim();
        clearSearchBtn.style.display = searchQuery ? 'flex' : 'none';
        renderTimeline();
    });

    clearSearchBtn.addEventListener('click', () => {
        searchInput.value = '';
        searchQuery = '';
        clearSearchBtn.style.display = 'none';
        renderTimeline();
    });

    // Sort
    sortSelect.addEventListener('change', () => {
        sortOrder = sortSelect.value;
        renderTimeline();
    });

    // Add URL
    addUrlBtn.addEventListener('click', () => {
        if (addUrlPanel.classList.contains('open')) {
            closeAddUrlPanel();
        } else {
            openAddUrlPanel();
        }
    });

    urlConfirmBtn.addEventListener('click', handleAddUrl);

    urlInput.addEventListener('keydown', e => {
        if (e.key === 'Enter') handleAddUrl();
        if (e.key === 'Escape') closeAddUrlPanel();
    });

    urlCancelBtn.addEventListener('click', closeAddUrlPanel);

    // LinkedIn modal
    modalCloseBtn.addEventListener('click', closeLinkedInModal);
    linkedinBackdrop.addEventListener('click', closeLinkedInModal);
    btnModalCancel.addEventListener('click', closeLinkedInModal);

    btnModalRegenerate.addEventListener('click', () => {
        if (!currentModalArticle) return;
        modalGenerating.style.display = 'flex';
        modalPostArea.style.display   = 'none';
        linkedinModalFooter.classList.remove('visible');
        setTimeout(() => {
            postTextarea.value = buildLinkedInPost(currentModalArticle);
            updateCharCount();
            modalGenerating.style.display = 'none';
            modalPostArea.style.display   = 'block';
            linkedinModalFooter.classList.add('visible');
        }, 400);
    });

    btnModalPublish.addEventListener('click', handlePublish);

    postTextarea.addEventListener('input', updateCharCount);

    // Reading panel close
    readingCloseBtn.addEventListener('click', closeReadingPanel);
    readingBackdrop.addEventListener('click', closeReadingPanel);

    // Close on Escape (panel takes priority over modal)
    document.addEventListener('keydown', e => {
        if (e.key !== 'Escape') return;
        if (readingPanel.classList.contains('open')) {
            closeReadingPanel();
        } else if (linkedinOverlay.classList.contains('open')) {
            closeLinkedInModal();
        }
    });
}
