# Product Launch Landing Page
> Product launch page with hero video area, feature carousel, and testimonials
> 히어로 비디오 영역, 기능 캐러셀, 후기 섹션이 포함된 제품 출시 랜딩 페이지

**Category**: Landing Pages | **Tags**: product, launch, video, testimonials, tailwind | **Difficulty**: Intermediate

## Preview
```
+--------------------------------------------------+
|  Brand   Features  Reviews   [Pre-Order ->]       |
+--------------------------------------------------+
|                                                    |
|    Introducing ProductX                            |
|    [ ========= VIDEO ========= ]                  |
|                                                    |
|   << Feature 1  |  Feature 2  |  Feature 3 >>     |
|                                                    |
|   "Amazing product" - User A                       |
|   "Changed my life" - User B                       |
|                                                    |
|        [Pre-Order Now - $99]                       |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Save as index.html
# 2. Replace video placeholder with your <video> or YouTube embed
# 3. Carousel uses pure CSS scroll-snap (no JS library needed)
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ProductX - The Future Is Here</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .carousel { scroll-snap-type: x mandatory; -webkit-overflow-scrolling: touch; }
    .carousel > div { scroll-snap-align: start; }
    .carousel::-webkit-scrollbar { display: none; }
  </style>
</head>
<body class="bg-black text-white">

  <!-- Nav -->
  <nav class="fixed w-full top-0 z-50 bg-black/70 backdrop-blur">
    <div class="max-w-6xl mx-auto px-6 h-16 flex items-center justify-between">
      <span class="text-xl font-bold">Product<span class="text-rose-500">X</span></span>
      <div class="hidden md:flex items-center gap-8 text-sm text-gray-300">
        <a href="#features" class="hover:text-white">Features</a>
        <a href="#reviews" class="hover:text-white">Reviews</a>
        <a href="#order" class="px-5 py-2 bg-rose-600 rounded-full font-medium hover:bg-rose-700 transition text-white">Pre-Order</a>
      </div>
    </div>
  </nav>

  <!-- Hero with Video -->
  <section class="pt-28 pb-16 px-6">
    <div class="max-w-4xl mx-auto text-center">
      <p class="text-rose-400 text-sm font-medium tracking-wider uppercase mb-4">Launching March 2026</p>
      <h1 class="text-5xl md:text-7xl font-black tracking-tight">The Future<br>Is <span class="text-rose-500">Here</span></h1>
      <p class="mt-6 text-lg text-gray-400 max-w-xl mx-auto">ProductX redefines what's possible. Precision-engineered with cutting-edge technology for the modern creator.</p>
    </div>
    <!-- Video Placeholder -->
    <div class="max-w-4xl mx-auto mt-12 aspect-video bg-gray-900 rounded-2xl overflow-hidden border border-gray-800 relative group cursor-pointer">
      <div class="absolute inset-0 flex items-center justify-center">
        <div class="w-20 h-20 bg-rose-600 rounded-full flex items-center justify-center group-hover:scale-110 transition shadow-lg shadow-rose-600/30">
          <svg class="w-8 h-8 text-white ml-1" fill="currentColor" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
        </div>
      </div>
      <div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
      <!-- Replace with: <video src="hero.mp4" autoplay muted loop class="w-full h-full object-cover"> -->
      <!-- Or: <iframe src="https://youtube.com/embed/VIDEO_ID" class="w-full h-full"></iframe> -->
    </div>
  </section>

  <!-- Feature Carousel -->
  <section id="features" class="py-20 px-6">
    <div class="max-w-6xl mx-auto">
      <h2 class="text-3xl font-bold text-center mb-12">Built Different</h2>
      <div class="carousel flex gap-6 overflow-x-auto pb-4">
        <div class="min-w-[300px] md:min-w-[350px] bg-gray-900 rounded-2xl p-8 border border-gray-800 flex-shrink-0">
          <div class="text-4xl mb-4">&#9889;</div>
          <h3 class="text-xl font-bold">Blazing Performance</h3>
          <p class="mt-3 text-gray-400 text-sm leading-relaxed">Our custom M4 chip delivers 3x the speed of competitors while using 50% less power. Benchmarks don't lie.</p>
          <div class="mt-6 text-rose-400 font-bold text-2xl">3x Faster</div>
        </div>
        <div class="min-w-[300px] md:min-w-[350px] bg-gray-900 rounded-2xl p-8 border border-gray-800 flex-shrink-0">
          <div class="text-4xl mb-4">&#128267;</div>
          <h3 class="text-xl font-bold">48hr Battery</h3>
          <p class="mt-3 text-gray-400 text-sm leading-relaxed">Go two full days without charging. Our next-gen battery technology adapts to your usage patterns in real-time.</p>
          <div class="mt-6 text-rose-400 font-bold text-2xl">48 Hours</div>
        </div>
        <div class="min-w-[300px] md:min-w-[350px] bg-gray-900 rounded-2xl p-8 border border-gray-800 flex-shrink-0">
          <div class="text-4xl mb-4">&#128247;</div>
          <h3 class="text-xl font-bold">200MP Camera</h3>
          <p class="mt-3 text-gray-400 text-sm leading-relaxed">Capture every detail with our quad-lens system. AI-enhanced night mode makes darkness irrelevant.</p>
          <div class="mt-6 text-rose-400 font-bold text-2xl">200 MP</div>
        </div>
        <div class="min-w-[300px] md:min-w-[350px] bg-gray-900 rounded-2xl p-8 border border-gray-800 flex-shrink-0">
          <div class="text-4xl mb-4">&#128737;</div>
          <h3 class="text-xl font-bold">Military-Grade Build</h3>
          <p class="mt-3 text-gray-400 text-sm leading-relaxed">Titanium frame with sapphire glass. IP69 water and dust resistant. Built to survive anything life throws at it.</p>
          <div class="mt-6 text-rose-400 font-bold text-2xl">IP69</div>
        </div>
      </div>
      <div class="flex justify-center gap-2 mt-6">
        <div class="w-8 h-1 bg-rose-500 rounded-full"></div>
        <div class="w-8 h-1 bg-gray-700 rounded-full"></div>
        <div class="w-8 h-1 bg-gray-700 rounded-full"></div>
        <div class="w-8 h-1 bg-gray-700 rounded-full"></div>
      </div>
    </div>
  </section>

  <!-- Testimonials -->
  <section id="reviews" class="py-20 px-6 bg-gray-950">
    <div class="max-w-5xl mx-auto">
      <h2 class="text-3xl font-bold text-center mb-12">What Early Reviewers Say</h2>
      <div class="grid md:grid-cols-3 gap-6">
        <div class="bg-gray-900 rounded-2xl p-6 border border-gray-800">
          <div class="flex gap-1 text-yellow-400 mb-4">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
          <p class="text-gray-300 text-sm">"The performance is unreal. I edited a 4K video on this thing faster than my desktop. Game changer."</p>
          <div class="mt-4 flex items-center gap-3">
            <div class="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center font-bold text-sm">MK</div>
            <div><p class="text-sm font-medium">MKBHD</p><p class="text-xs text-gray-500">Tech Reviewer</p></div>
          </div>
        </div>
        <div class="bg-gray-900 rounded-2xl p-6 border border-gray-800">
          <div class="flex gap-1 text-yellow-400 mb-4">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
          <p class="text-gray-300 text-sm">"Best camera system I've tested in 2026. Night mode photos look like they were taken in daylight."</p>
          <div class="mt-4 flex items-center gap-3">
            <div class="w-10 h-10 bg-purple-600 rounded-full flex items-center justify-center font-bold text-sm">TG</div>
            <div><p class="text-sm font-medium">The Verge</p><p class="text-xs text-gray-500">Publication</p></div>
          </div>
        </div>
        <div class="bg-gray-900 rounded-2xl p-6 border border-gray-800">
          <div class="flex gap-1 text-yellow-400 mb-4">&#9733;&#9733;&#9733;&#9733;&#9734;</div>
          <p class="text-gray-300 text-sm">"Two days of battery life isn't marketing speak - I actually got 47 hours with heavy use. Impressive."</p>
          <div class="mt-4 flex items-center gap-3">
            <div class="w-10 h-10 bg-emerald-600 rounded-full flex items-center justify-center font-bold text-sm">AH</div>
            <div><p class="text-sm font-medium">Ars Technica</p><p class="text-xs text-gray-500">Publication</p></div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Pre-Order CTA -->
  <section id="order" class="py-24 px-6">
    <div class="max-w-2xl mx-auto text-center">
      <h2 class="text-4xl font-black">Ready to Experience It?</h2>
      <p class="mt-4 text-gray-400">Ships worldwide starting April 2026. Reserve yours today.</p>
      <div class="mt-10 inline-flex flex-col items-center">
        <div class="text-5xl font-black">$999</div>
        <div class="text-sm text-gray-500 mt-1">Starting price &middot; Free shipping</div>
        <a href="#" class="mt-6 px-10 py-4 bg-rose-600 text-lg font-bold rounded-full hover:bg-rose-700 shadow-xl shadow-rose-600/25 transition">Pre-Order Now</a>
        <p class="mt-3 text-xs text-gray-500">$99 deposit &middot; Full refund if you cancel</p>
      </div>
    </div>
  </section>

  <footer class="py-8 px-6 border-t border-gray-800 text-center text-xs text-gray-500">
    &copy; 2026 ProductX Inc. All rights reserved. | <a href="#" class="hover:text-white">Privacy</a> | <a href="#" class="hover:text-white">Terms</a>
  </footer>

</body>
</html>
```

## Customization Guide
- **Video**: Replace the placeholder `<div>` with `<video autoplay muted loop>` or a YouTube `<iframe>`
- **Carousel**: Add or remove feature cards; the CSS scroll-snap handles alignment
- **Testimonials**: Replace reviewer info with real quotes and avatars
- **Price**: Update the `$999` and deposit amount
- **Color accent**: Change `rose` to `violet`, `amber`, or any Tailwind color
- **Countdown timer**: Add a JS countdown before the pre-order CTA for urgency

## 2026 Trend Notes
- Pure CSS carousel with `scroll-snap-type` eliminates the need for Swiper/Slick
- Full-black background with high-contrast text is standard for premium product pages
- Large stat numbers in feature cards provide visual anchors
- Play button overlay on video area encourages interaction
- Deposit model with refund policy reduces purchase friction
