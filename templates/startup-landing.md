# Startup Pitch Landing Page
> Startup pitch page with problem/solution framework, team section, and investor highlights
> 문제/해결 프레임워크, 팀 소개, 투자자 하이라이트가 포함된 스타트업 피치 랜딩 페이지

**Category**: Landing Pages | **Tags**: startup, pitch, investors, team, tailwind | **Difficulty**: Beginner

## Preview
```
+--------------------------------------------------+
|  StartupName                  [Request Demo]       |
+--------------------------------------------------+
|                                                    |
|    We're solving [PROBLEM]                         |
|    for [TARGET MARKET]                             |
|                                                    |
|    PROBLEM            SOLUTION                     |
|    [pain point 1]     [feature 1]                  |
|    [pain point 2]     [feature 2]                  |
|                                                    |
|    $2.4B TAM   |  10x Growth  |  500+ Users       |
|                                                    |
|    Team: CEO  CTO  Head of Product                 |
|                                                    |
|    Backed by: Y Combinator, a16z, Sequoia          |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Paste HTML into index.html
# 2. Replace company name, problem/solution statements, metrics, team
# 3. Send the link to investors alongside your pitch deck
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>NexaAI - AI-Powered Enterprise Automation</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-white text-gray-900">

  <!-- Nav -->
  <nav class="fixed w-full top-0 z-50 bg-white/90 backdrop-blur border-b border-gray-100">
    <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
      <span class="text-xl font-bold">Nexa<span class="text-blue-600">AI</span></span>
      <div class="flex items-center gap-6 text-sm">
        <a href="#problem" class="hidden md:inline text-gray-500 hover:text-gray-900">Problem</a>
        <a href="#solution" class="hidden md:inline text-gray-500 hover:text-gray-900">Solution</a>
        <a href="#team" class="hidden md:inline text-gray-500 hover:text-gray-900">Team</a>
        <a href="#cta" class="px-5 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 transition">Request Demo</a>
      </div>
    </div>
  </nav>

  <!-- Hero -->
  <section class="pt-32 pb-20 px-6">
    <div class="max-w-3xl mx-auto text-center">
      <div class="inline-flex items-center gap-2 px-3 py-1 bg-blue-50 text-blue-700 text-xs font-medium rounded-full mb-6">
        <span class="w-2 h-2 bg-blue-500 rounded-full animate-pulse"></span> Y Combinator W26 Batch
      </div>
      <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight leading-tight">Enterprise teams waste<br><span class="text-blue-600">40% of time</span> on repetitive tasks</h1>
      <p class="mt-6 text-lg text-gray-500">NexaAI automates complex workflows with AI agents that learn from your team's patterns. Save 15+ hours per employee per week.</p>
      <div class="mt-8 flex flex-col sm:flex-row gap-3 justify-center">
        <a href="#cta" class="px-8 py-3 bg-blue-600 text-white font-semibold rounded-xl hover:bg-blue-700 transition">Request Demo</a>
        <a href="#" class="px-8 py-3 border border-gray-200 rounded-xl font-semibold hover:bg-gray-50 transition">Read Our Deck</a>
      </div>
    </div>
  </section>

  <!-- Problem / Solution -->
  <section id="problem" class="py-20 px-6 bg-gray-50">
    <div class="max-w-5xl mx-auto grid md:grid-cols-2 gap-12">
      <div>
        <span class="text-xs font-bold text-red-500 uppercase tracking-wider">The Problem</span>
        <h2 class="text-3xl font-bold mt-3">Manual Processes Are Killing Productivity</h2>
        <ul class="mt-6 space-y-4">
          <li class="flex gap-3"><span class="text-red-400 text-lg mt-0.5">&#10007;</span><div><p class="font-medium">Data entry consumes 12 hours/week per employee</p><p class="text-sm text-gray-500 mt-1">Teams manually copy data between 5+ tools daily</p></div></li>
          <li class="flex gap-3"><span class="text-red-400 text-lg mt-0.5">&#10007;</span><div><p class="font-medium">$50K+/year wasted on failed automation attempts</p><p class="text-sm text-gray-500 mt-1">Traditional RPA breaks when workflows change</p></div></li>
          <li class="flex gap-3"><span class="text-red-400 text-lg mt-0.5">&#10007;</span><div><p class="font-medium">Top talent quits due to tedious work</p><p class="text-sm text-gray-500 mt-1">35% of knowledge workers cite "boring tasks" as reason for leaving</p></div></li>
        </ul>
      </div>
      <div id="solution">
        <span class="text-xs font-bold text-green-600 uppercase tracking-wider">Our Solution</span>
        <h2 class="text-3xl font-bold mt-3">AI Agents That Adapt and Learn</h2>
        <ul class="mt-6 space-y-4">
          <li class="flex gap-3"><span class="text-green-500 text-lg mt-0.5">&#10003;</span><div><p class="font-medium">Watch and learn from employee actions</p><p class="text-sm text-gray-500 mt-1">Our agents observe workflows and suggest automations</p></div></li>
          <li class="flex gap-3"><span class="text-green-500 text-lg mt-0.5">&#10003;</span><div><p class="font-medium">Self-healing when tools or processes change</p><p class="text-sm text-gray-500 mt-1">AI detects UI changes and adapts automatically</p></div></li>
          <li class="flex gap-3"><span class="text-green-500 text-lg mt-0.5">&#10003;</span><div><p class="font-medium">ROI visible within 2 weeks</p><p class="text-sm text-gray-500 mt-1">Average customer saves 15 hours/employee/week by week 3</p></div></li>
        </ul>
      </div>
    </div>
  </section>

  <!-- Traction / Metrics -->
  <section class="py-20 px-6">
    <div class="max-w-4xl mx-auto">
      <h2 class="text-2xl font-bold text-center mb-12">Traction</h2>
      <div class="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
        <div class="p-6 bg-blue-50 rounded-2xl"><div class="text-3xl font-black text-blue-600">$2.4B</div><div class="text-sm text-gray-500 mt-1">TAM (Enterprise Automation)</div></div>
        <div class="p-6 bg-green-50 rounded-2xl"><div class="text-3xl font-black text-green-600">10x</div><div class="text-sm text-gray-500 mt-1">YoY Revenue Growth</div></div>
        <div class="p-6 bg-purple-50 rounded-2xl"><div class="text-3xl font-black text-purple-600">500+</div><div class="text-sm text-gray-500 mt-1">Active Users</div></div>
        <div class="p-6 bg-orange-50 rounded-2xl"><div class="text-3xl font-black text-orange-600">$1.2M</div><div class="text-sm text-gray-500 mt-1">ARR</div></div>
      </div>
    </div>
  </section>

  <!-- Team -->
  <section id="team" class="py-20 px-6 bg-gray-50">
    <div class="max-w-4xl mx-auto">
      <h2 class="text-2xl font-bold text-center mb-12">Built by World-Class Team</h2>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="text-center">
          <div class="w-24 h-24 mx-auto bg-gradient-to-br from-blue-500 to-indigo-600 rounded-full flex items-center justify-center text-3xl font-bold text-white">SK</div>
          <h3 class="mt-4 font-bold">Sarah Kim</h3>
          <p class="text-sm text-gray-500">CEO &middot; Ex-Google PM</p>
          <p class="text-xs text-gray-400 mt-2">Led Google Workspace automation. Stanford CS.</p>
        </div>
        <div class="text-center">
          <div class="w-24 h-24 mx-auto bg-gradient-to-br from-emerald-500 to-teal-600 rounded-full flex items-center justify-center text-3xl font-bold text-white">JL</div>
          <h3 class="mt-4 font-bold">James Lee</h3>
          <p class="text-sm text-gray-500">CTO &middot; Ex-OpenAI</p>
          <p class="text-xs text-gray-400 mt-2">Core contributor to GPT-4 fine-tuning. MIT PhD.</p>
        </div>
        <div class="text-center">
          <div class="w-24 h-24 mx-auto bg-gradient-to-br from-purple-500 to-pink-600 rounded-full flex items-center justify-center text-3xl font-bold text-white">MP</div>
          <h3 class="mt-4 font-bold">Maya Patel</h3>
          <p class="text-sm text-gray-500">Head of Product &middot; Ex-Notion</p>
          <p class="text-xs text-gray-400 mt-2">Built Notion AI from 0 to 1M users. Berkeley MBA.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Investors -->
  <section class="py-16 px-6">
    <div class="max-w-4xl mx-auto text-center">
      <p class="text-xs uppercase tracking-widest text-gray-400 mb-6">Backed by</p>
      <div class="flex flex-wrap justify-center gap-10 text-xl font-bold text-gray-300">
        <span>Y Combinator</span><span>a16z</span><span>Sequoia</span><span>Founders Fund</span>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section id="cta" class="py-20 px-6 bg-blue-600 text-white">
    <div class="max-w-2xl mx-auto text-center">
      <h2 class="text-3xl font-bold">Ready to Eliminate Busywork?</h2>
      <p class="mt-4 text-blue-100">Schedule a 15-minute demo and see NexaAI in action on your workflows.</p>
      <form class="mt-8 flex flex-col sm:flex-row gap-3 max-w-md mx-auto">
        <input type="email" placeholder="work@company.com" class="flex-1 px-4 py-3 rounded-xl text-gray-900 text-sm focus:outline-none focus:ring-2 focus:ring-blue-300">
        <button class="px-6 py-3 bg-white text-blue-700 font-bold rounded-xl hover:bg-blue-50 transition">Book Demo</button>
      </form>
    </div>
  </section>

  <footer class="py-8 px-6 text-center text-sm text-gray-400">
    &copy; 2026 NexaAI Inc. &middot; <a href="#" class="hover:text-gray-900">Privacy</a> &middot; <a href="#" class="hover:text-gray-900">Terms</a>
  </footer>

</body>
</html>
```

## Customization Guide
- **Problem/Solution**: Replace bullet points with your specific pain points and value propositions
- **Metrics**: Update the 4 traction stats with your real numbers
- **Team**: Replace names, titles, and backgrounds; add real headshot images
- **Investors**: Replace investor names with actual backers or remove section if pre-funding
- **Industry**: Change from "Enterprise Automation" to your vertical
- **CTA form**: Connect to your CRM (HubSpot, Pipedrive) or calendar booking (Calendly)

## 2026 Trend Notes
- Problem/Solution side-by-side layout is the standard pitch page pattern for investors
- Animated pulse dot on badge creates urgency (YC batch indicator)
- Colored stat cards with large numbers follow the "metrics wall" pattern popular in pitch decks
- Clean white design conveys trust and professionalism for B2B/enterprise
- Email capture in colored CTA section drives conversions
