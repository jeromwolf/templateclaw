# Mobile App Landing Page
> Mobile app landing page with app store badges, screenshot mockups, and feature highlights
> 앱스토어 배지, 스크린샷 목업, 기능 하이라이트가 포함된 모바일 앱 랜딩 페이지

**Category**: Landing Pages | **Tags**: mobile, app, ios, android, tailwind | **Difficulty**: Beginner

## Preview
```
+--------------------------------------------------+
|  AppName                    [Download Free]        |
+--------------------------------------------------+
|                                                    |
|    Your Finances,              +----------+        |
|    Simplified.                 |  [Phone] |        |
|                                | Screenshot|        |
|    [App Store] [Google Play]   +----------+        |
|                                                    |
|   4.9 Stars | 1M+ Downloads | Featured by Apple   |
|                                                    |
|   Feature 1    Feature 2    Feature 3              |
|   [ screen ]   [ screen ]   [ screen ]             |
|                                                    |
|        Download Free on iOS & Android              |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Save as index.html, open in browser
# 2. Replace app screenshots with your real images
# 3. Update App Store / Google Play links with your app URLs
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>FinTrack - Your Finances, Simplified</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-950 text-white overflow-x-hidden">

  <!-- Nav -->
  <nav class="fixed w-full top-0 z-50 bg-gray-950/80 backdrop-blur border-b border-gray-800">
    <div class="max-w-6xl mx-auto px-6 h-14 flex items-center justify-between">
      <span class="text-lg font-bold text-violet-400">FinTrack</span>
      <div class="flex items-center gap-6 text-sm">
        <a href="#features" class="hidden md:inline text-gray-400 hover:text-white">Features</a>
        <a href="#download" class="px-4 py-2 bg-violet-600 rounded-lg font-medium hover:bg-violet-700 transition">Download Free</a>
      </div>
    </div>
  </nav>

  <!-- Hero -->
  <section class="pt-28 pb-20 px-6">
    <div class="max-w-6xl mx-auto flex flex-col md:flex-row items-center gap-12">
      <div class="flex-1 text-center md:text-left">
        <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight leading-tight">Your Finances,<br><span class="bg-gradient-to-r from-violet-400 to-pink-400 bg-clip-text text-transparent">Simplified.</span></h1>
        <p class="mt-6 text-lg text-gray-400 max-w-md">Track spending, set budgets, and reach your savings goals. All in one beautiful app. No bank login required.</p>
        <!-- App Store Badges -->
        <div class="mt-8 flex flex-wrap gap-4 justify-center md:justify-start">
          <a href="#" class="inline-flex items-center gap-3 px-5 py-3 bg-gray-800 rounded-xl hover:bg-gray-700 transition border border-gray-700">
            <svg class="w-7 h-7" viewBox="0 0 24 24" fill="white"><path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/></svg>
            <div class="text-left"><div class="text-[10px] text-gray-400 leading-none">Download on the</div><div class="text-sm font-semibold leading-tight">App Store</div></div>
          </a>
          <a href="#" class="inline-flex items-center gap-3 px-5 py-3 bg-gray-800 rounded-xl hover:bg-gray-700 transition border border-gray-700">
            <svg class="w-7 h-7" viewBox="0 0 24 24" fill="white"><path d="M3.18 23.76c.28.44.84.58 1.28.3L12 19.41l7.54 4.65c.44.28 1 .14 1.28-.3.13-.2.18-.44.15-.66l-1.98-8.63 6.7-5.81c.37-.33.42-.9.09-1.27a.9.9 0 0 0-.57-.3l-8.82-.77L12.82.94A.91.91 0 0 0 12 .36a.91.91 0 0 0-.82.58L8.61 6.32l-8.82.77a.91.91 0 0 0-.48 1.57l6.7 5.81-1.98 8.63c-.06.24 0 .49.15.66z"/></svg>
            <div class="text-left"><div class="text-[10px] text-gray-400 leading-none">GET IT ON</div><div class="text-sm font-semibold leading-tight">Google Play</div></div>
          </a>
        </div>
      </div>
      <!-- Phone Mockup -->
      <div class="flex-shrink-0">
        <div class="w-64 h-[500px] bg-gray-800 rounded-[2.5rem] border-4 border-gray-700 relative overflow-hidden shadow-2xl shadow-violet-500/10">
          <div class="absolute top-0 left-1/2 -translate-x-1/2 w-24 h-6 bg-gray-950 rounded-b-2xl"></div>
          <!-- Replace this gradient with a real screenshot -->
          <div class="w-full h-full bg-gradient-to-b from-violet-600 via-purple-700 to-indigo-900 flex flex-col items-center justify-center p-6 text-center">
            <div class="text-5xl mb-4">&#128176;</div>
            <div class="text-2xl font-bold">$12,450</div>
            <div class="text-sm text-violet-200 mt-1">Total Balance</div>
            <div class="mt-6 w-full space-y-3">
              <div class="flex justify-between text-sm"><span>Groceries</span><span>-$234</span></div>
              <div class="flex justify-between text-sm"><span>Salary</span><span class="text-emerald-300">+$5,000</span></div>
              <div class="flex justify-between text-sm"><span>Netflix</span><span>-$15</span></div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Social Proof -->
  <section class="py-12 px-6 border-y border-gray-800">
    <div class="max-w-4xl mx-auto flex flex-wrap justify-center gap-10 md:gap-16 text-center">
      <div><div class="text-2xl font-bold text-violet-400">4.9 &#9733;</div><div class="text-xs text-gray-500 mt-1">App Store Rating</div></div>
      <div><div class="text-2xl font-bold text-violet-400">1M+</div><div class="text-xs text-gray-500 mt-1">Downloads</div></div>
      <div><div class="text-2xl font-bold text-violet-400">#1</div><div class="text-xs text-gray-500 mt-1">Finance Category</div></div>
      <div><div class="text-2xl font-bold text-violet-400">Featured</div><div class="text-xs text-gray-500 mt-1">By Apple</div></div>
    </div>
  </section>

  <!-- Features -->
  <section id="features" class="py-20 px-6">
    <div class="max-w-5xl mx-auto">
      <h2 class="text-3xl font-bold text-center mb-14">Why People Love FinTrack</h2>
      <div class="grid md:grid-cols-3 gap-8">
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-violet-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#128202;</div>
          <h3 class="font-bold text-lg">Smart Insights</h3>
          <p class="mt-2 text-sm text-gray-400">AI analyzes your spending patterns and suggests where you can save more each month.</p>
        </div>
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-pink-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#127919;</div>
          <h3 class="font-bold text-lg">Goal Tracking</h3>
          <p class="mt-2 text-sm text-gray-400">Set savings goals and get daily nudges to stay on track. Visualize your progress.</p>
        </div>
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-emerald-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#128274;</div>
          <h3 class="font-bold text-lg">Bank-Level Security</h3>
          <p class="mt-2 text-sm text-gray-400">256-bit encryption. Biometric auth. We never store your bank credentials.</p>
        </div>
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-orange-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#128276;</div>
          <h3 class="font-bold text-lg">Bill Reminders</h3>
          <p class="mt-2 text-sm text-gray-400">Never miss a payment again. Get notified before bills are due.</p>
        </div>
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-blue-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#128101;</div>
          <h3 class="font-bold text-lg">Shared Budgets</h3>
          <p class="mt-2 text-sm text-gray-400">Split expenses with family or roommates. Everyone sees the same dashboard.</p>
        </div>
        <div class="text-center">
          <div class="w-16 h-16 mx-auto bg-cyan-900/50 rounded-2xl flex items-center justify-center text-3xl mb-4">&#127760;</div>
          <h3 class="font-bold text-lg">Multi-Currency</h3>
          <p class="mt-2 text-sm text-gray-400">Track expenses in 50+ currencies. Real-time exchange rates built in.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Download CTA -->
  <section id="download" class="py-20 px-6 bg-gradient-to-br from-violet-900 to-indigo-900">
    <div class="max-w-2xl mx-auto text-center">
      <h2 class="text-3xl font-bold">Start Saving Today</h2>
      <p class="mt-4 text-violet-200">Join 1 million+ people who've taken control of their money. Free forever.</p>
      <div class="mt-8 flex flex-wrap gap-4 justify-center">
        <a href="#" class="inline-flex items-center gap-3 px-6 py-3 bg-white text-gray-900 rounded-xl font-semibold hover:bg-gray-100 transition">
          <svg class="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/></svg>
          App Store
        </a>
        <a href="#" class="inline-flex items-center gap-3 px-6 py-3 bg-white text-gray-900 rounded-xl font-semibold hover:bg-gray-100 transition">
          <svg class="w-6 h-6" viewBox="0 0 24 24" fill="currentColor"><path d="M3 20.5v-17c0-.59.34-1.11.84-1.35L13.69 12l-9.85 9.85c-.5-.24-.84-.76-.84-1.35zm13.81-5.38L6.05 21.34l8.49-8.49 2.27 2.27zm.91-.91L19.87 12 17.72 9.79l-2.44 2.44 2.44 2.98zM6.05 2.66l10.76 6.22-2.27 2.27-8.49-8.49z"/></svg>
          Google Play
        </a>
      </div>
      <p class="mt-4 text-xs text-violet-300">Available on iOS 16+ and Android 12+</p>
    </div>
  </section>

  <footer class="py-8 px-6 text-center text-xs text-gray-500">
    &copy; 2026 FinTrack Inc. &middot; <a href="#" class="hover:text-white">Privacy</a> &middot; <a href="#" class="hover:text-white">Terms</a>
  </footer>

</body>
</html>
```

## Customization Guide
- **Phone mockup**: Replace the inner gradient `<div>` with `<img src="screenshot.png" class="w-full h-full object-cover">`
- **App store links**: Update the `href="#"` with your actual App Store / Google Play URLs
- **Color scheme**: Replace `violet` with your brand color throughout
- **Stats**: Update ratings, downloads, and category ranking
- **Features**: Replace the 6 feature blocks with your app's actual features
- **Add reviews**: Insert a testimonials section between features and CTA

## 2026 Trend Notes
- Gradient text (`bg-clip-text text-transparent`) for hero headings
- CSS-only phone mockup with rounded corners and notch (no image needed)
- Dark mode default for modern app landing pages
- Inline SVG app store badges for consistent sizing (no external image dependencies)
- Minimalist feature icons using system emoji (replace with your icon library)
