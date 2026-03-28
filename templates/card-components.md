# Card Components
> 8 card variants: product, profile, pricing, stat, testimonial, blog, feature, and glass morphism
> 8가지 카드 변형: 제품, 프로필, 가격, 통계, 후기, 블로그, 기능, 글래스모피즘

**Category**: Components | **Tags**: cards, ui, tailwind, responsive, glassmorphism | **Difficulty**: Beginner

## Preview
```
+----------+  +----------+  +----------+  +----------+
| Product  |  | Profile  |  | Pricing  |  |  Stat    |
| [image]  |  | [avatar] |  | $29/mo   |  | 12,421   |
| Name $49 |  | Jane Doe |  | [CTA]    |  | +12%     |
+----------+  +----------+  +----------+  +----------+
+----------+  +----------+  +----------+  +----------+
|Testimonl |  |  Blog    |  | Feature  |  |  Glass   |
| "Quote"  |  | [thumb]  |  | [icon]   |  | Frosted  |
| - Author |  | Title... |  | Desc...  |  | effect   |
+----------+  +----------+  +----------+  +----------+
```

## Quick Start
```bash
# 1. Copy any card component below into your project
# 2. Each card is self-contained - mix and match freely
# 3. All cards are responsive and support dark mode
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Card Components</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 dark:bg-gray-900 p-8 min-h-screen">
  <div class="max-w-6xl mx-auto space-y-12">

    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Card Components</h1>

    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">

      <!-- 1. Product Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl overflow-hidden border border-gray-200 dark:border-gray-700 hover:shadow-xl transition group">
        <div class="h-48 bg-gradient-to-br from-indigo-400 to-purple-500 relative overflow-hidden">
          <div class="absolute top-3 right-3 px-2 py-1 bg-white/90 text-xs font-bold rounded-full text-indigo-700">NEW</div>
          <div class="absolute inset-0 flex items-center justify-center text-6xl group-hover:scale-110 transition">&#128240;</div>
        </div>
        <div class="p-5">
          <div class="flex items-center justify-between">
            <h3 class="font-semibold text-gray-900 dark:text-white">Wireless Headphones</h3>
            <span class="text-lg font-bold text-indigo-600">$49</span>
          </div>
          <p class="mt-2 text-sm text-gray-500">Premium noise-cancelling with 30hr battery life.</p>
          <div class="mt-3 flex gap-1">
            <span class="text-yellow-400 text-sm">&#9733;&#9733;&#9733;&#9733;&#9733;</span>
            <span class="text-xs text-gray-400">(128)</span>
          </div>
          <button class="mt-4 w-full py-2 bg-indigo-600 text-white text-sm rounded-xl font-medium hover:bg-indigo-700 transition">Add to Cart</button>
        </div>
      </div>

      <!-- 2. Profile Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 p-6 text-center hover:shadow-xl transition">
        <div class="w-20 h-20 mx-auto bg-gradient-to-br from-emerald-400 to-cyan-500 rounded-full flex items-center justify-center text-3xl font-bold text-white">JD</div>
        <h3 class="mt-4 font-semibold text-gray-900 dark:text-white">Jane Doe</h3>
        <p class="text-sm text-gray-500">Senior Frontend Engineer</p>
        <p class="mt-3 text-xs text-gray-400">Building beautiful interfaces at scale. React, TypeScript, and design systems.</p>
        <div class="mt-4 flex justify-center gap-6 text-center">
          <div><div class="font-bold text-gray-900 dark:text-white">142</div><div class="text-[10px] text-gray-400">Posts</div></div>
          <div><div class="font-bold text-gray-900 dark:text-white">3.2K</div><div class="text-[10px] text-gray-400">Followers</div></div>
          <div><div class="font-bold text-gray-900 dark:text-white">89</div><div class="text-[10px] text-gray-400">Following</div></div>
        </div>
        <button class="mt-4 w-full py-2 border border-gray-300 dark:border-gray-600 rounded-xl text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition text-gray-900 dark:text-white">Follow</button>
      </div>

      <!-- 3. Pricing Card -->
      <div class="bg-indigo-600 text-white rounded-2xl p-6 relative overflow-hidden hover:shadow-xl transition">
        <div class="absolute top-0 right-0 w-32 h-32 bg-indigo-500 rounded-full -translate-y-1/2 translate-x-1/2 opacity-50"></div>
        <span class="relative text-xs font-bold bg-white/20 px-2 py-1 rounded-full">POPULAR</span>
        <h3 class="mt-4 font-semibold text-lg relative">Pro Plan</h3>
        <div class="mt-2 relative"><span class="text-4xl font-black">$29</span><span class="text-indigo-200">/mo</span></div>
        <ul class="mt-4 space-y-2 text-sm text-indigo-100 relative">
          <li>&#10003; 25 team members</li>
          <li>&#10003; 100GB storage</li>
          <li>&#10003; Advanced analytics</li>
          <li>&#10003; Priority support</li>
        </ul>
        <button class="mt-6 w-full py-2.5 bg-white text-indigo-700 rounded-xl font-bold hover:bg-indigo-50 transition relative">Get Started</button>
      </div>

      <!-- 4. Stat Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 p-6 hover:shadow-xl transition">
        <div class="flex items-center justify-between mb-4">
          <div class="w-10 h-10 bg-emerald-100 dark:bg-emerald-900/30 rounded-xl flex items-center justify-center text-emerald-600">&#128200;</div>
          <span class="text-xs px-2 py-0.5 bg-emerald-100 text-emerald-700 rounded-full font-medium">+12.5%</span>
        </div>
        <div class="text-3xl font-bold text-gray-900 dark:text-white">12,421</div>
        <div class="text-sm text-gray-500 mt-1">Total Customers</div>
        <div class="mt-4 h-1.5 bg-gray-100 dark:bg-gray-700 rounded-full">
          <div class="h-1.5 bg-emerald-500 rounded-full" style="width:72%"></div>
        </div>
        <div class="mt-2 text-xs text-gray-400">72% of yearly target</div>
      </div>

      <!-- 5. Testimonial Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 p-6 hover:shadow-xl transition">
        <div class="flex gap-1 text-yellow-400 mb-3">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <p class="text-sm text-gray-600 dark:text-gray-300 italic leading-relaxed">"This product completely transformed our workflow. We went from 3 hours of manual work to 15 minutes. The ROI was visible within a week."</p>
        <div class="mt-4 flex items-center gap-3">
          <div class="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white text-sm font-bold">AK</div>
          <div>
            <div class="text-sm font-medium text-gray-900 dark:text-white">Alex Kim</div>
            <div class="text-xs text-gray-400">CTO, TechNova</div>
          </div>
        </div>
      </div>

      <!-- 6. Blog Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl overflow-hidden border border-gray-200 dark:border-gray-700 hover:shadow-xl transition group">
        <div class="h-40 bg-gradient-to-br from-rose-400 to-orange-400 relative overflow-hidden">
          <div class="absolute inset-0 flex items-center justify-center text-5xl group-hover:scale-110 transition">&#128221;</div>
        </div>
        <div class="p-5">
          <div class="flex gap-2 mb-2">
            <span class="text-[10px] px-2 py-0.5 bg-rose-100 text-rose-700 rounded-full font-medium">Tutorial</span>
            <span class="text-[10px] text-gray-400">5 min read</span>
          </div>
          <h3 class="font-semibold text-gray-900 dark:text-white leading-snug">Building a Real-time Dashboard with React and WebSockets</h3>
          <p class="mt-2 text-xs text-gray-500 line-clamp-2">Learn how to create a responsive real-time dashboard with live data streaming using React hooks and native WebSocket API.</p>
          <div class="mt-4 flex items-center gap-2">
            <div class="w-6 h-6 bg-rose-500 rounded-full flex items-center justify-center text-white text-[8px] font-bold">SM</div>
            <span class="text-xs text-gray-500">Sarah Miller &middot; Mar 25, 2026</span>
          </div>
        </div>
      </div>

      <!-- 7. Feature Card -->
      <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 p-6 hover:shadow-xl hover:border-indigo-300 dark:hover:border-indigo-700 transition group">
        <div class="w-12 h-12 bg-indigo-100 dark:bg-indigo-900/30 rounded-2xl flex items-center justify-center text-indigo-600 text-2xl mb-4 group-hover:scale-110 transition">&#9889;</div>
        <h3 class="font-semibold text-gray-900 dark:text-white">Lightning Fast</h3>
        <p class="mt-2 text-sm text-gray-500 leading-relaxed">Sub-100ms response times powered by edge computing. Your users feel the speed difference instantly.</p>
        <a href="#" class="mt-4 inline-flex items-center gap-1 text-sm text-indigo-600 font-medium hover:gap-2 transition-all">Learn more <span>&#8594;</span></a>
      </div>

      <!-- 8. Glass Card -->
      <div class="relative overflow-hidden rounded-2xl p-6 hover:shadow-xl transition" style="background: rgba(255,255,255,0.08); backdrop-filter: blur(16px); border: 1px solid rgba(255,255,255,0.15);">
        <div class="absolute -top-10 -right-10 w-32 h-32 bg-purple-500/30 rounded-full blur-2xl"></div>
        <div class="absolute -bottom-10 -left-10 w-32 h-32 bg-blue-500/30 rounded-full blur-2xl"></div>
        <div class="relative">
          <div class="text-3xl mb-3">&#128142;</div>
          <h3 class="font-semibold text-white text-lg">Glass Morphism</h3>
          <p class="mt-2 text-sm text-gray-300 leading-relaxed">A frosted glass effect using backdrop-filter and semi-transparent backgrounds for a modern, layered aesthetic.</p>
          <button class="mt-4 px-4 py-2 bg-white/10 border border-white/20 rounded-xl text-sm text-white hover:bg-white/20 transition">Explore</button>
        </div>
      </div>

    </div>
  </div>
</body>
</html>
```

## Customization Guide
- **Product card**: Replace gradient background with `<img>` tag for real product photos
- **Profile card**: Use real avatar images instead of initials
- **Pricing card**: Change the accent color and update feature list
- **Stat card**: Wire up to real-time API data with JavaScript
- **Blog card**: Add `line-clamp-2` utility for consistent excerpt height
- **Glass card**: Works best on dark or gradient backgrounds; adjust `rgba` values for transparency
- **All cards**: Change `rounded-2xl` to `rounded-xl` or `rounded-lg` for different border radius

## 2026 Trend Notes
- Glassmorphism (`backdrop-filter: blur`) continues as a premium design pattern
- Subtle hover transforms (`group-hover:scale-110`) on icons add interactivity
- Color-coded badges (NEW, POPULAR) improve visual scanning
- Progress bars inside stat cards provide goal context
- `line-clamp` utility prevents text overflow in variable-content cards
