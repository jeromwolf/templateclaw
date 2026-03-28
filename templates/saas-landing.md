# SaaS Landing Page
> Modern SaaS landing page with hero, features, pricing, and CTA sections built with Tailwind CSS
> Tailwind CSS 기반 모던 SaaS 랜딩 페이지 (히어로, 기능, 가격, CTA 섹션 포함)

**Category**: Landing Pages | **Tags**: saas, tailwind, landing, responsive, dark-mode | **Difficulty**: Beginner

## Preview
```
+--------------------------------------------------+
|  Logo    Features  Pricing  Login  [Get Started]  |
+--------------------------------------------------+
|                                                    |
|        Build Faster. Ship Smarter.                 |
|   The all-in-one platform for modern teams         |
|                                                    |
|     [Start Free Trial]  [Watch Demo ->]            |
|                                                    |
|     +--------+  +--------+  +--------+             |
|     |Feature1|  |Feature2|  |Feature3|             |
|     +--------+  +--------+  +--------+             |
|                                                    |
|   Starter $9   Pro $29   Enterprise $99            |
|                                                    |
|        Ready to get started? [Sign Up]             |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Create index.html and paste the Full Code below
# 2. Open in browser - no build step needed
# 3. Tailwind loads via CDN (swap to local build for production)
# Tip: Replace colors by changing "indigo" to your brand color
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SaaSify - Build Faster. Ship Smarter.</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      darkMode: 'class',
      theme: {
        extend: {
          colors: { brand: { 50:'#eef2ff',100:'#e0e7ff',500:'#6366f1',600:'#4f46e5',700:'#4338ca',900:'#312e81' } }
        }
      }
    }
  </script>
</head>
<body class="bg-white text-gray-900 dark:bg-gray-950 dark:text-gray-100">

  <!-- Navbar -->
  <nav class="fixed w-full top-0 z-50 bg-white/80 dark:bg-gray-950/80 backdrop-blur border-b border-gray-200 dark:border-gray-800">
    <div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">
      <a href="#" class="text-xl font-bold text-brand-600">SaaSify</a>
      <div class="hidden md:flex items-center gap-8">
        <a href="#features" class="text-sm hover:text-brand-600 transition">Features</a>
        <a href="#pricing" class="text-sm hover:text-brand-600 transition">Pricing</a>
        <a href="#faq" class="text-sm hover:text-brand-600 transition">FAQ</a>
        <a href="#" class="text-sm text-gray-500">Log in</a>
        <a href="#" class="px-4 py-2 bg-brand-600 text-white text-sm rounded-lg hover:bg-brand-700 transition">Get Started</a>
      </div>
      <button id="menu-btn" class="md:hidden p-2" onclick="document.getElementById('mobile-menu').classList.toggle('hidden')">
        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/></svg>
      </button>
    </div>
    <div id="mobile-menu" class="hidden md:hidden px-6 pb-4 space-y-3">
      <a href="#features" class="block text-sm">Features</a>
      <a href="#pricing" class="block text-sm">Pricing</a>
      <a href="#" class="block px-4 py-2 bg-brand-600 text-white text-sm rounded-lg text-center">Get Started</a>
    </div>
  </nav>

  <!-- Hero -->
  <section class="pt-32 pb-20 px-6">
    <div class="max-w-4xl mx-auto text-center">
      <div class="inline-block px-4 py-1 mb-6 text-xs font-medium bg-brand-50 text-brand-700 dark:bg-brand-900/30 dark:text-brand-100 rounded-full">New: AI-powered workflows</div>
      <h1 class="text-5xl md:text-6xl font-extrabold tracking-tight leading-tight">Build Faster.<br><span class="text-brand-600">Ship Smarter.</span></h1>
      <p class="mt-6 text-lg text-gray-600 dark:text-gray-400 max-w-2xl mx-auto">The all-in-one platform that helps modern teams automate workflows, collaborate in real-time, and ship products 10x faster.</p>
      <div class="mt-10 flex flex-col sm:flex-row gap-4 justify-center">
        <a href="#" class="px-8 py-3 bg-brand-600 text-white font-semibold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/25 transition">Start Free Trial</a>
        <a href="#" class="px-8 py-3 border border-gray-300 dark:border-gray-700 rounded-xl font-semibold hover:bg-gray-50 dark:hover:bg-gray-900 transition flex items-center gap-2 justify-center">Watch Demo <span>&#8594;</span></a>
      </div>
      <p class="mt-4 text-xs text-gray-400">No credit card required. 14-day free trial.</p>
    </div>
  </section>

  <!-- Logos -->
  <section class="py-12 border-y border-gray-100 dark:border-gray-800">
    <div class="max-w-5xl mx-auto px-6 text-center">
      <p class="text-xs uppercase tracking-widest text-gray-400 mb-6">Trusted by 2,000+ teams worldwide</p>
      <div class="flex flex-wrap justify-center gap-10 opacity-40 grayscale text-2xl font-bold">
        <span>Stripe</span><span>Vercel</span><span>Linear</span><span>Notion</span><span>Figma</span>
      </div>
    </div>
  </section>

  <!-- Features -->
  <section id="features" class="py-24 px-6">
    <div class="max-w-6xl mx-auto">
      <h2 class="text-3xl font-bold text-center">Everything you need to ship fast</h2>
      <p class="text-center text-gray-500 mt-3 max-w-xl mx-auto">Powerful tools that integrate seamlessly into your existing workflow.</p>
      <div class="mt-16 grid md:grid-cols-3 gap-8">
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-brand-50 dark:bg-brand-900/30 rounded-xl flex items-center justify-center text-brand-600 text-xl mb-4">&#9889;</div>
          <h3 class="font-semibold text-lg">Lightning Fast</h3>
          <p class="mt-2 text-sm text-gray-500">Sub-100ms response times with edge computing and smart caching built in.</p>
        </div>
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-green-50 dark:bg-green-900/30 rounded-xl flex items-center justify-center text-green-600 text-xl mb-4">&#128274;</div>
          <h3 class="font-semibold text-lg">Enterprise Security</h3>
          <p class="mt-2 text-sm text-gray-500">SOC2 Type II certified. End-to-end encryption. SSO and RBAC included.</p>
        </div>
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-purple-50 dark:bg-purple-900/30 rounded-xl flex items-center justify-center text-purple-600 text-xl mb-4">&#128640;</div>
          <h3 class="font-semibold text-lg">AI Workflows</h3>
          <p class="mt-2 text-sm text-gray-500">Automate repetitive tasks with AI-powered pipelines that learn your patterns.</p>
        </div>
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-orange-50 dark:bg-orange-900/30 rounded-xl flex items-center justify-center text-orange-600 text-xl mb-4">&#128295;</div>
          <h3 class="font-semibold text-lg">API First</h3>
          <p class="mt-2 text-sm text-gray-500">RESTful and GraphQL APIs with SDKs for Python, Node.js, Go, and Rust.</p>
        </div>
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-cyan-50 dark:bg-cyan-900/30 rounded-xl flex items-center justify-center text-cyan-600 text-xl mb-4">&#128202;</div>
          <h3 class="font-semibold text-lg">Real-time Analytics</h3>
          <p class="mt-2 text-sm text-gray-500">Live dashboards, custom reports, and automated alerts for your key metrics.</p>
        </div>
        <div class="p-6 rounded-2xl border border-gray-200 dark:border-gray-800 hover:shadow-lg transition">
          <div class="w-12 h-12 bg-pink-50 dark:bg-pink-900/30 rounded-xl flex items-center justify-center text-pink-600 text-xl mb-4">&#127760;</div>
          <h3 class="font-semibold text-lg">Global Scale</h3>
          <p class="mt-2 text-sm text-gray-500">Deploy to 30+ edge regions. Auto-scaling handles traffic spikes seamlessly.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Pricing -->
  <section id="pricing" class="py-24 px-6 bg-gray-50 dark:bg-gray-900">
    <div class="max-w-5xl mx-auto text-center">
      <h2 class="text-3xl font-bold">Simple, transparent pricing</h2>
      <p class="text-gray-500 mt-3">No hidden fees. Cancel anytime.</p>
      <div class="mt-16 grid md:grid-cols-3 gap-8">
        <!-- Starter -->
        <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 border border-gray-200 dark:border-gray-700 text-left">
          <h3 class="font-semibold text-lg">Starter</h3>
          <div class="mt-4"><span class="text-4xl font-bold">$9</span><span class="text-gray-400">/mo</span></div>
          <ul class="mt-6 space-y-3 text-sm text-gray-600 dark:text-gray-400">
            <li>&#10003; Up to 5 users</li><li>&#10003; 10GB storage</li><li>&#10003; Basic analytics</li><li>&#10003; Email support</li>
          </ul>
          <a href="#" class="mt-8 block text-center py-2.5 border border-gray-300 dark:border-gray-600 rounded-xl font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition">Get Started</a>
        </div>
        <!-- Pro (popular) -->
        <div class="bg-brand-600 text-white rounded-2xl p-8 shadow-xl shadow-brand-600/20 text-left relative">
          <span class="absolute -top-3 left-1/2 -translate-x-1/2 px-3 py-0.5 bg-yellow-400 text-yellow-900 text-xs font-bold rounded-full">Most Popular</span>
          <h3 class="font-semibold text-lg">Pro</h3>
          <div class="mt-4"><span class="text-4xl font-bold">$29</span><span class="text-indigo-200">/mo</span></div>
          <ul class="mt-6 space-y-3 text-sm text-indigo-100">
            <li>&#10003; Up to 25 users</li><li>&#10003; 100GB storage</li><li>&#10003; Advanced analytics</li><li>&#10003; Priority support</li><li>&#10003; AI workflows</li>
          </ul>
          <a href="#" class="mt-8 block text-center py-2.5 bg-white text-brand-700 rounded-xl font-bold hover:bg-indigo-50 transition">Start Free Trial</a>
        </div>
        <!-- Enterprise -->
        <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 border border-gray-200 dark:border-gray-700 text-left">
          <h3 class="font-semibold text-lg">Enterprise</h3>
          <div class="mt-4"><span class="text-4xl font-bold">$99</span><span class="text-gray-400">/mo</span></div>
          <ul class="mt-6 space-y-3 text-sm text-gray-600 dark:text-gray-400">
            <li>&#10003; Unlimited users</li><li>&#10003; 1TB storage</li><li>&#10003; Custom integrations</li><li>&#10003; Dedicated support</li><li>&#10003; SSO & RBAC</li>
          </ul>
          <a href="#" class="mt-8 block text-center py-2.5 border border-gray-300 dark:border-gray-600 rounded-xl font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition">Contact Sales</a>
        </div>
      </div>
    </div>
  </section>

  <!-- CTA -->
  <section class="py-24 px-6">
    <div class="max-w-3xl mx-auto text-center">
      <h2 class="text-3xl font-bold">Ready to build something amazing?</h2>
      <p class="mt-4 text-gray-500">Join 2,000+ teams already shipping faster with SaaSify.</p>
      <a href="#" class="inline-block mt-8 px-8 py-3 bg-brand-600 text-white font-semibold rounded-xl hover:bg-brand-700 shadow-lg shadow-brand-600/25 transition">Start Your Free Trial</a>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-12 px-6 border-t border-gray-200 dark:border-gray-800">
    <div class="max-w-6xl mx-auto flex flex-col md:flex-row justify-between gap-8 text-sm text-gray-500">
      <div><span class="font-bold text-gray-900 dark:text-white">SaaSify</span> &copy; 2026</div>
      <div class="flex gap-6"><a href="#" class="hover:text-gray-900 dark:hover:text-white">Privacy</a><a href="#" class="hover:text-gray-900 dark:hover:text-white">Terms</a><a href="#" class="hover:text-gray-900 dark:hover:text-white">Twitter</a><a href="#" class="hover:text-gray-900 dark:hover:text-white">GitHub</a></div>
    </div>
  </footer>

</body>
</html>
```

## Customization Guide
- **Brand color**: Replace all `brand-` / `indigo-` classes with your color (`emerald`, `rose`, `amber`, etc.)
- **Dark mode**: Toggle by adding/removing `dark` class on `<html>` element
- **Add sections**: Copy any section block and modify content
- **Logo**: Replace the text "SaaSify" with an `<img>` or SVG
- **Forms**: Add email capture by inserting an `<input>` + `<button>` in the hero section
- **Analytics**: Add `<script>` tag for Plausible/PostHog before `</head>`

## 2026 Trend Notes
- Glassmorphism navbar with `backdrop-blur` for modern transparent feel
- `scroll-smooth` for native smooth scrolling without JS
- Shadow with brand color (`shadow-brand-600/25`) for depth
- Edge-to-edge sections with contained content (`max-w-7xl mx-auto`)
- CDN Tailwind for prototyping; swap to `@tailwindcss/cli` for production
