# Hero Section Components
> Hero section variants: centered text, split layout, video background, animated gradient, and minimal
> 히어로 섹션 변형: 중앙 텍스트, 분할 레이아웃, 비디오 배경, 애니메이션 그라디언트, 미니멀

**Category**: Components | **Tags**: hero, header, above-fold, animation, tailwind | **Difficulty**: Beginner

## Preview
```
+---- Centered Hero ----+  +---- Split Hero ------+
| Build Amazing Things  |  | Text     |  [Image]  |
| [CTA]   [Secondary]  |  | CTA      |           |
+-----------------------+  +----------------------+

+---- Gradient Hero ----+  +---- Minimal Hero ----+
| ~~~animated colors~~~ |  |                      |
| Bold Statement        |  | One line. That's it. |
| [CTA]                 |  |        [CTA]         |
+-----------------------+  +----------------------+
```

## Quick Start
```bash
# 1. Pick a hero style and copy the HTML block
# 2. Replace headline, subtext, and CTA buttons
# 3. Each hero is self-contained (no dependencies between them)
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hero Components</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @keyframes gradient { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }
    .animate-gradient { background-size: 200% 200%; animation: gradient 6s ease infinite; }
    @keyframes float { 0%, 100% { transform: translateY(0); } 50% { transform: translateY(-10px); } }
    .float { animation: float 3s ease-in-out infinite; }
  </style>
</head>
<body class="bg-gray-950 text-white space-y-4">

  <!-- 1. Centered Hero -->
  <section class="min-h-[80vh] flex items-center px-6 bg-gray-950 relative overflow-hidden">
    <div class="absolute inset-0 bg-[radial-gradient(ellipse_at_center,rgba(99,102,241,0.15),transparent_70%)]"></div>
    <div class="max-w-3xl mx-auto text-center relative">
      <div class="inline-block px-4 py-1 mb-6 text-xs font-medium bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 rounded-full">Announcing v3.0</div>
      <h1 class="text-5xl md:text-7xl font-extrabold tracking-tight leading-[1.1]">Build Amazing<br>Things <span class="text-indigo-400">Faster</span></h1>
      <p class="mt-6 text-lg text-gray-400 max-w-xl mx-auto">The developer platform that helps you ship products 10x faster with AI-powered tools and seamless collaboration.</p>
      <div class="mt-10 flex flex-col sm:flex-row gap-4 justify-center">
        <a href="#" class="px-8 py-3.5 bg-indigo-600 font-semibold rounded-xl hover:bg-indigo-700 shadow-lg shadow-indigo-600/25 transition">Get Started Free</a>
        <a href="#" class="px-8 py-3.5 border border-gray-700 rounded-xl font-semibold hover:bg-gray-800 transition flex items-center gap-2 justify-center">Live Demo <span>&#8594;</span></a>
      </div>
    </div>
  </section>

  <!-- 2. Split Hero (Text + Visual) -->
  <section class="min-h-[80vh] flex items-center px-6 bg-gray-900">
    <div class="max-w-6xl mx-auto grid md:grid-cols-2 gap-12 items-center">
      <div>
        <span class="text-sm font-bold text-emerald-400 uppercase tracking-wider">For Developers</span>
        <h1 class="mt-4 text-4xl md:text-5xl font-extrabold tracking-tight leading-tight">Ship Code<br>With Confidence</h1>
        <p class="mt-6 text-lg text-gray-400">Automated testing, deployment pipelines, and real-time monitoring in one platform. Push code and sleep well.</p>
        <div class="mt-8 flex gap-4">
          <a href="#" class="px-6 py-3 bg-emerald-600 font-semibold rounded-xl hover:bg-emerald-700 transition">Start Building</a>
          <a href="#" class="px-6 py-3 text-gray-400 font-semibold hover:text-white transition">Read Docs &#8594;</a>
        </div>
        <div class="mt-8 flex gap-8 text-sm text-gray-500">
          <div><span class="text-white font-bold text-lg">99.99%</span><br>Uptime SLA</div>
          <div><span class="text-white font-bold text-lg">50ms</span><br>Avg Latency</div>
          <div><span class="text-white font-bold text-lg">10K+</span><br>Teams</div>
        </div>
      </div>
      <div class="float">
        <div class="bg-gray-800 rounded-2xl p-6 border border-gray-700 shadow-xl">
          <div class="flex items-center gap-2 mb-4"><div class="w-3 h-3 bg-red-500 rounded-full"></div><div class="w-3 h-3 bg-yellow-500 rounded-full"></div><div class="w-3 h-3 bg-green-500 rounded-full"></div></div>
          <pre class="text-sm text-gray-300 font-mono leading-relaxed"><code><span class="text-emerald-400">$</span> npx create-app my-project
<span class="text-gray-500">Creating project...</span>
<span class="text-emerald-400">&#10003;</span> Dependencies installed
<span class="text-emerald-400">&#10003;</span> CI/CD configured
<span class="text-emerald-400">&#10003;</span> Monitoring enabled

<span class="text-emerald-400">$</span> git push origin main
<span class="text-blue-400">Deploying to production...</span>
<span class="text-emerald-400">&#10003;</span> Live at https://my-project.app</code></pre>
        </div>
      </div>
    </div>
  </section>

  <!-- 3. Animated Gradient Hero -->
  <section class="min-h-[80vh] flex items-center px-6 animate-gradient bg-gradient-to-br from-purple-900 via-indigo-900 to-cyan-900 relative">
    <div class="max-w-3xl mx-auto text-center">
      <h1 class="text-5xl md:text-7xl font-black tracking-tight">The Future of <span class="bg-gradient-to-r from-cyan-300 to-purple-300 bg-clip-text text-transparent">AI Development</span></h1>
      <p class="mt-6 text-lg text-gray-300 max-w-xl mx-auto">Build, train, and deploy AI models with zero infrastructure. From prototype to production in minutes.</p>
      <a href="#" class="inline-block mt-10 px-10 py-4 bg-white text-gray-900 font-bold rounded-2xl hover:bg-gray-100 transition shadow-2xl">Start Free Trial</a>
      <p class="mt-4 text-xs text-gray-400">No credit card required</p>
    </div>
  </section>

  <!-- 4. Video Background Hero -->
  <section class="min-h-[80vh] flex items-center px-6 bg-gray-950 relative overflow-hidden">
    <!-- Replace with: <video autoplay muted loop class="absolute inset-0 w-full h-full object-cover opacity-30"><source src="bg.mp4" type="video/mp4"></video> -->
    <div class="absolute inset-0 bg-gradient-to-b from-transparent via-gray-950/50 to-gray-950"></div>
    <div class="absolute inset-0 bg-[url('data:image/svg+xml;charset=utf-8,%3Csvg%20width%3D%2220%22%20height%3D%2220%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Ccircle%20cx%3D%221%22%20cy%3D%221%22%20r%3D%221%22%20fill%3D%22rgba(255%2C255%2C255%2C0.05)%22%2F%3E%3C%2Fsvg%3E')] opacity-50"></div>
    <div class="max-w-4xl mx-auto text-center relative">
      <h1 class="text-5xl md:text-7xl font-black tracking-tight">Create Without<br>Limits</h1>
      <p class="mt-6 text-xl text-gray-300">The creative platform for the next generation of makers.</p>
      <div class="mt-10 flex gap-4 justify-center">
        <a href="#" class="px-8 py-3 bg-white text-gray-900 font-bold rounded-xl hover:bg-gray-100 transition">Get Started</a>
        <a href="#" class="px-8 py-3 border border-white/30 rounded-xl font-semibold hover:bg-white/10 transition flex items-center gap-2">Watch Video <span>&#9654;</span></a>
      </div>
    </div>
  </section>

  <!-- 5. Minimal Hero -->
  <section class="min-h-[60vh] flex items-center px-6 bg-white">
    <div class="max-w-2xl mx-auto text-center">
      <h1 class="text-4xl md:text-6xl font-extrabold tracking-tight text-gray-900">Simple tools for<br>complex work.</h1>
      <p class="mt-6 text-lg text-gray-500">Less noise. More focus. The workspace that gets out of your way.</p>
      <a href="#" class="inline-block mt-8 px-8 py-3 bg-gray-900 text-white font-semibold rounded-xl hover:bg-gray-800 transition">Try It Free</a>
    </div>
  </section>

</body>
</html>
```

## Customization Guide
- **Centered hero**: Add a background image with `bg-[url('...')]` and overlay with gradient
- **Split hero**: Replace the terminal mockup with a product screenshot or illustration
- **Gradient hero**: Change gradient colors in the `from-` `via-` `to-` classes
- **Video hero**: Uncomment the `<video>` tag and provide your video file
- **Minimal hero**: Works great on light backgrounds; change to dark by swapping colors
- **Heights**: Adjust `min-h-[80vh]` to `min-h-screen` for full viewport height

## 2026 Trend Notes
- Radial gradient backgrounds add depth without images
- Animated gradients (`background-size: 200% + animation`) create visual interest
- Split hero with code/terminal mockup is popular for developer tools
- Floating animation on visual elements adds subtle motion
- Minimal heroes with high contrast text are trending for productivity tools
