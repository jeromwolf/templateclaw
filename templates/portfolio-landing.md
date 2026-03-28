# Developer Portfolio Landing Page
> Clean developer portfolio with project grid, skills visualization, and contact form
> 프로젝트 그리드, 스킬 시각화, 연락 폼을 갖춘 개발자 포트폴리오 페이지

**Category**: Landing Pages | **Tags**: portfolio, developer, tailwind, responsive, minimal | **Difficulty**: Beginner

## Preview
```
+--------------------------------------------------+
|  JD    About  Projects  Skills  Contact           |
+--------------------------------------------------+
|                                                    |
|    Hi, I'm Jane Doe                                |
|    Full-stack Developer & Open Source Contributor   |
|    [GitHub] [LinkedIn] [Resume]                    |
|                                                    |
|   +--------+  +--------+  +--------+               |
|   |Project1|  |Project2|  |Project3|               |
|   |  img   |  |  img   |  |  img   |               |
|   +--------+  +--------+  +--------+               |
|                                                    |
|    React ====90%    Python ===85%                   |
|                                                    |
|    [Name] [Email] [Message] [Send]                 |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Copy the HTML below into index.html
# 2. Replace name, bio, project links, and skill percentages
# 3. Open in browser — fully responsive, zero dependencies beyond Tailwind CDN
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Jane Doe - Developer Portfolio</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .skill-bar { transition: width 1.2s cubic-bezier(0.4,0,0.2,1); }
    @keyframes fadeUp { from { opacity:0; transform:translateY(20px); } to { opacity:1; transform:translateY(0); } }
    .fade-up { animation: fadeUp 0.6s ease forwards; }
  </style>
</head>
<body class="bg-gray-950 text-gray-100">

  <!-- Nav -->
  <nav class="fixed w-full top-0 z-50 bg-gray-950/80 backdrop-blur border-b border-gray-800">
    <div class="max-w-5xl mx-auto px-6 h-14 flex items-center justify-between">
      <a href="#" class="text-lg font-bold text-emerald-400">JD</a>
      <div class="flex gap-6 text-sm text-gray-400">
        <a href="#about" class="hover:text-white transition">About</a>
        <a href="#projects" class="hover:text-white transition">Projects</a>
        <a href="#skills" class="hover:text-white transition">Skills</a>
        <a href="#contact" class="hover:text-white transition">Contact</a>
      </div>
    </div>
  </nav>

  <!-- Hero / About -->
  <section id="about" class="pt-32 pb-20 px-6">
    <div class="max-w-3xl mx-auto text-center fade-up">
      <div class="w-24 h-24 mx-auto rounded-full bg-gradient-to-br from-emerald-400 to-cyan-400 flex items-center justify-center text-3xl font-bold text-gray-950 mb-6">JD</div>
      <h1 class="text-4xl md:text-5xl font-bold">Hi, I'm <span class="text-emerald-400">Jane Doe</span></h1>
      <p class="mt-4 text-lg text-gray-400">Full-stack developer specializing in React, Python, and cloud infrastructure. Open source contributor with 5+ years of experience building products used by thousands.</p>
      <div class="mt-8 flex gap-4 justify-center">
        <a href="https://github.com" target="_blank" class="px-5 py-2 bg-gray-800 rounded-lg text-sm hover:bg-gray-700 transition">GitHub</a>
        <a href="https://linkedin.com" target="_blank" class="px-5 py-2 bg-gray-800 rounded-lg text-sm hover:bg-gray-700 transition">LinkedIn</a>
        <a href="#" class="px-5 py-2 bg-emerald-600 rounded-lg text-sm hover:bg-emerald-700 transition">Resume</a>
      </div>
    </div>
  </section>

  <!-- Projects -->
  <section id="projects" class="py-20 px-6 bg-gray-900">
    <div class="max-w-5xl mx-auto">
      <h2 class="text-2xl font-bold text-center mb-12">Featured Projects</h2>
      <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-6">

        <div class="group bg-gray-800 rounded-xl overflow-hidden hover:ring-2 hover:ring-emerald-400 transition">
          <div class="h-40 bg-gradient-to-br from-emerald-900 to-cyan-900 flex items-center justify-center text-4xl">&#128187;</div>
          <div class="p-5">
            <div class="flex items-center justify-between">
              <h3 class="font-semibold">DevFlow CLI</h3>
              <span class="text-xs px-2 py-0.5 bg-emerald-900 text-emerald-300 rounded-full">Open Source</span>
            </div>
            <p class="mt-2 text-sm text-gray-400">A Git workflow automation tool used by 3,000+ developers. Built with Python and Click.</p>
            <div class="mt-4 flex gap-2 text-xs text-gray-500">
              <span class="px-2 py-0.5 bg-gray-700 rounded">Python</span>
              <span class="px-2 py-0.5 bg-gray-700 rounded">CLI</span>
            </div>
            <div class="mt-4 flex gap-3">
              <a href="#" class="text-sm text-emerald-400 hover:underline">Demo</a>
              <a href="#" class="text-sm text-gray-400 hover:underline">Source</a>
            </div>
          </div>
        </div>

        <div class="group bg-gray-800 rounded-xl overflow-hidden hover:ring-2 hover:ring-emerald-400 transition">
          <div class="h-40 bg-gradient-to-br from-purple-900 to-pink-900 flex items-center justify-center text-4xl">&#128200;</div>
          <div class="p-5">
            <div class="flex items-center justify-between">
              <h3 class="font-semibold">TradeViz</h3>
              <span class="text-xs px-2 py-0.5 bg-purple-900 text-purple-300 rounded-full">SaaS</span>
            </div>
            <p class="mt-2 text-sm text-gray-400">Real-time trading dashboard with candlestick charts and portfolio analytics.</p>
            <div class="mt-4 flex gap-2 text-xs text-gray-500">
              <span class="px-2 py-0.5 bg-gray-700 rounded">React</span>
              <span class="px-2 py-0.5 bg-gray-700 rounded">D3.js</span>
              <span class="px-2 py-0.5 bg-gray-700 rounded">FastAPI</span>
            </div>
            <div class="mt-4 flex gap-3">
              <a href="#" class="text-sm text-emerald-400 hover:underline">Live App</a>
              <a href="#" class="text-sm text-gray-400 hover:underline">Source</a>
            </div>
          </div>
        </div>

        <div class="group bg-gray-800 rounded-xl overflow-hidden hover:ring-2 hover:ring-emerald-400 transition">
          <div class="h-40 bg-gradient-to-br from-orange-900 to-yellow-900 flex items-center justify-center text-4xl">&#129302;</div>
          <div class="p-5">
            <div class="flex items-center justify-between">
              <h3 class="font-semibold">AgentKit</h3>
              <span class="text-xs px-2 py-0.5 bg-orange-900 text-orange-300 rounded-full">AI</span>
            </div>
            <p class="mt-2 text-sm text-gray-400">Multi-agent AI orchestration framework with tool-use and memory persistence.</p>
            <div class="mt-4 flex gap-2 text-xs text-gray-500">
              <span class="px-2 py-0.5 bg-gray-700 rounded">TypeScript</span>
              <span class="px-2 py-0.5 bg-gray-700 rounded">LangChain</span>
            </div>
            <div class="mt-4 flex gap-3">
              <a href="#" class="text-sm text-emerald-400 hover:underline">Docs</a>
              <a href="#" class="text-sm text-gray-400 hover:underline">Source</a>
            </div>
          </div>
        </div>

      </div>
    </div>
  </section>

  <!-- Skills -->
  <section id="skills" class="py-20 px-6">
    <div class="max-w-3xl mx-auto">
      <h2 class="text-2xl font-bold text-center mb-12">Skills</h2>
      <div class="space-y-5">
        <div><div class="flex justify-between text-sm mb-1"><span>React / Next.js</span><span class="text-gray-500">92%</span></div><div class="h-2 bg-gray-800 rounded-full"><div class="skill-bar h-2 bg-emerald-500 rounded-full" style="width:92%"></div></div></div>
        <div><div class="flex justify-between text-sm mb-1"><span>Python / FastAPI</span><span class="text-gray-500">88%</span></div><div class="h-2 bg-gray-800 rounded-full"><div class="skill-bar h-2 bg-cyan-500 rounded-full" style="width:88%"></div></div></div>
        <div><div class="flex justify-between text-sm mb-1"><span>TypeScript</span><span class="text-gray-500">85%</span></div><div class="h-2 bg-gray-800 rounded-full"><div class="skill-bar h-2 bg-blue-500 rounded-full" style="width:85%"></div></div></div>
        <div><div class="flex justify-between text-sm mb-1"><span>PostgreSQL / Redis</span><span class="text-gray-500">80%</span></div><div class="h-2 bg-gray-800 rounded-full"><div class="skill-bar h-2 bg-purple-500 rounded-full" style="width:80%"></div></div></div>
        <div><div class="flex justify-between text-sm mb-1"><span>AWS / Docker / K8s</span><span class="text-gray-500">78%</span></div><div class="h-2 bg-gray-800 rounded-full"><div class="skill-bar h-2 bg-orange-500 rounded-full" style="width:78%"></div></div></div>
      </div>
    </div>
  </section>

  <!-- Contact -->
  <section id="contact" class="py-20 px-6 bg-gray-900">
    <div class="max-w-lg mx-auto">
      <h2 class="text-2xl font-bold text-center mb-8">Get In Touch</h2>
      <form class="space-y-4" action="https://formspree.io/f/YOUR_ID" method="POST">
        <input name="name" type="text" placeholder="Your Name" required class="w-full px-4 py-3 bg-gray-800 border border-gray-700 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500">
        <input name="email" type="email" placeholder="your@email.com" required class="w-full px-4 py-3 bg-gray-800 border border-gray-700 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500">
        <textarea name="message" rows="4" placeholder="Your message..." required class="w-full px-4 py-3 bg-gray-800 border border-gray-700 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-emerald-500 resize-none"></textarea>
        <button type="submit" class="w-full py-3 bg-emerald-600 rounded-xl font-semibold hover:bg-emerald-700 transition">Send Message</button>
      </form>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-8 px-6 text-center text-sm text-gray-500">
    Built with Tailwind CSS. &copy; 2026 Jane Doe. All rights reserved.
  </footer>

</body>
</html>
```

## Customization Guide
- **Avatar**: Replace the initials div with an `<img src="your-photo.jpg" class="w-24 h-24 rounded-full object-cover">`
- **Projects**: Duplicate a project card block and change content; use real screenshot images for the gradient placeholders
- **Skills**: Adjust percentage widths and label text; change bar colors per skill
- **Contact form**: Replace `formspree.io/f/YOUR_ID` with your Formspree, Netlify Forms, or custom endpoint
- **Color theme**: Change `emerald` to any Tailwind color (`blue`, `violet`, `rose`)
- **Add blog section**: Insert a new `<section>` with grid of blog post cards

## 2026 Trend Notes
- Dark-first design reflects developer aesthetic preferences
- Subtle ring hover effects (`hover:ring-2`) instead of heavy box shadows
- Gradient mesh backgrounds on project cards for visual interest without images
- Native form validation with `required` attribute (no JS needed)
- Formspree integration for serverless form handling
