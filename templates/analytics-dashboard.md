# Analytics Dashboard
> Analytics dashboard with KPI cards, chart areas, date filters, and metric breakdowns
> KPI 카드, 차트 영역, 날짜 필터, 지표 분석이 포함된 애널리틱스 대시보드

**Category**: Dashboard | **Tags**: analytics, kpi, charts, metrics, tailwind | **Difficulty**: Intermediate

## Preview
```
+--------------------------------------------------+
|  Analytics    [Last 7 Days v]  [Export] [Refresh] |
+--------------------------------------------------+
| +------+ +-------+ +--------+ +---------+        |
| |Views | |Users  | |Bounce  | |Avg Time |        |
| |245K  | |12.4K  | |42.1%   | |3m 24s   |        |
| |+18%  | |+5.2%  | |-2.1%   | |+0.8%    |        |
| +------+ +-------+ +--------+ +---------+        |
|                                                    |
| +--- Line Chart (Traffic) ---+ +-- Pie Chart --+  |
| |                             | |               |  |
| +-----------------------------+ +---------------+  |
|                                                    |
| +--- Bar Chart (Pages) ------+ +-- Top Pages --+  |
| |                             | | /home   42K   |  |
| +-----------------------------+ | /about  28K   |  |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Save as index.html
# 2. For real charts, add Chart.js: <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
# 3. Replace KPI data with your analytics API responses
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Analytics Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4"></script>
</head>
<body class="bg-gray-50 dark:bg-gray-900 text-gray-900 dark:text-gray-100 min-h-screen">

  <div class="max-w-7xl mx-auto px-4 py-8">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
      <div>
        <h1 class="text-2xl font-bold">Analytics</h1>
        <p class="text-sm text-gray-500">Track your key performance metrics</p>
      </div>
      <div class="flex gap-2">
        <select id="dateRange" class="text-sm bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg px-3 py-2">
          <option>Last 7 days</option><option>Last 30 days</option><option>Last 90 days</option><option>This year</option>
        </select>
        <button class="px-4 py-2 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg text-sm hover:bg-gray-100 dark:hover:bg-gray-700 transition">Export</button>
        <button onclick="location.reload()" class="px-4 py-2 bg-indigo-600 text-white rounded-lg text-sm hover:bg-indigo-700 transition">Refresh</button>
      </div>
    </div>

    <!-- KPI Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
      <div class="bg-white dark:bg-gray-800 rounded-xl p-5 border border-gray-200 dark:border-gray-700">
        <div class="text-sm text-gray-500 mb-1">Page Views</div>
        <div class="text-3xl font-bold">245,831</div>
        <div class="mt-2 flex items-center gap-1 text-sm"><span class="text-green-600 font-medium">+18.2%</span><span class="text-gray-400">vs last period</span></div>
        <div class="mt-3 h-1 bg-gray-100 dark:bg-gray-700 rounded-full"><div class="h-1 bg-indigo-500 rounded-full" style="width:72%"></div></div>
      </div>
      <div class="bg-white dark:bg-gray-800 rounded-xl p-5 border border-gray-200 dark:border-gray-700">
        <div class="text-sm text-gray-500 mb-1">Unique Visitors</div>
        <div class="text-3xl font-bold">12,421</div>
        <div class="mt-2 flex items-center gap-1 text-sm"><span class="text-green-600 font-medium">+5.2%</span><span class="text-gray-400">vs last period</span></div>
        <div class="mt-3 h-1 bg-gray-100 dark:bg-gray-700 rounded-full"><div class="h-1 bg-emerald-500 rounded-full" style="width:58%"></div></div>
      </div>
      <div class="bg-white dark:bg-gray-800 rounded-xl p-5 border border-gray-200 dark:border-gray-700">
        <div class="text-sm text-gray-500 mb-1">Bounce Rate</div>
        <div class="text-3xl font-bold">42.1%</div>
        <div class="mt-2 flex items-center gap-1 text-sm"><span class="text-green-600 font-medium">-2.1%</span><span class="text-gray-400">vs last period</span></div>
        <div class="mt-3 h-1 bg-gray-100 dark:bg-gray-700 rounded-full"><div class="h-1 bg-amber-500 rounded-full" style="width:42%"></div></div>
      </div>
      <div class="bg-white dark:bg-gray-800 rounded-xl p-5 border border-gray-200 dark:border-gray-700">
        <div class="text-sm text-gray-500 mb-1">Avg. Session</div>
        <div class="text-3xl font-bold">3m 24s</div>
        <div class="mt-2 flex items-center gap-1 text-sm"><span class="text-green-600 font-medium">+0.8%</span><span class="text-gray-400">vs last period</span></div>
        <div class="mt-3 h-1 bg-gray-100 dark:bg-gray-700 rounded-full"><div class="h-1 bg-purple-500 rounded-full" style="width:65%"></div></div>
      </div>
    </div>

    <!-- Charts Row -->
    <div class="grid lg:grid-cols-3 gap-4 mb-8">
      <!-- Traffic Line Chart -->
      <div class="lg:col-span-2 bg-white dark:bg-gray-800 rounded-xl p-6 border border-gray-200 dark:border-gray-700">
        <h2 class="font-semibold mb-4">Traffic Overview</h2>
        <canvas id="trafficChart" height="120"></canvas>
      </div>
      <!-- Source Doughnut -->
      <div class="bg-white dark:bg-gray-800 rounded-xl p-6 border border-gray-200 dark:border-gray-700">
        <h2 class="font-semibold mb-4">Traffic Sources</h2>
        <canvas id="sourceChart" height="180"></canvas>
        <div class="mt-4 space-y-2 text-sm">
          <div class="flex justify-between"><span class="flex items-center gap-2"><span class="w-3 h-3 bg-indigo-500 rounded-full"></span>Organic</span><span class="font-medium">42%</span></div>
          <div class="flex justify-between"><span class="flex items-center gap-2"><span class="w-3 h-3 bg-emerald-500 rounded-full"></span>Direct</span><span class="font-medium">28%</span></div>
          <div class="flex justify-between"><span class="flex items-center gap-2"><span class="w-3 h-3 bg-amber-500 rounded-full"></span>Referral</span><span class="font-medium">18%</span></div>
          <div class="flex justify-between"><span class="flex items-center gap-2"><span class="w-3 h-3 bg-rose-500 rounded-full"></span>Social</span><span class="font-medium">12%</span></div>
        </div>
      </div>
    </div>

    <!-- Top Pages Table -->
    <div class="bg-white dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700 overflow-hidden">
      <div class="p-4 border-b border-gray-200 dark:border-gray-700"><h2 class="font-semibold">Top Pages</h2></div>
      <table class="w-full text-sm">
        <thead class="bg-gray-50 dark:bg-gray-700/50"><tr>
          <th class="text-left px-4 py-3 font-medium text-gray-500">Page</th>
          <th class="text-right px-4 py-3 font-medium text-gray-500">Views</th>
          <th class="text-right px-4 py-3 font-medium text-gray-500">Unique</th>
          <th class="text-right px-4 py-3 font-medium text-gray-500">Bounce</th>
          <th class="text-right px-4 py-3 font-medium text-gray-500">Trend</th>
        </tr></thead>
        <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
          <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30"><td class="px-4 py-3 font-medium">/home</td><td class="px-4 py-3 text-right">42,381</td><td class="px-4 py-3 text-right">28,432</td><td class="px-4 py-3 text-right">32%</td><td class="px-4 py-3 text-right text-green-600">+12%</td></tr>
          <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30"><td class="px-4 py-3 font-medium">/pricing</td><td class="px-4 py-3 text-right">28,104</td><td class="px-4 py-3 text-right">21,882</td><td class="px-4 py-3 text-right">45%</td><td class="px-4 py-3 text-right text-green-600">+8%</td></tr>
          <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30"><td class="px-4 py-3 font-medium">/docs</td><td class="px-4 py-3 text-right">19,442</td><td class="px-4 py-3 text-right">15,231</td><td class="px-4 py-3 text-right">28%</td><td class="px-4 py-3 text-right text-green-600">+22%</td></tr>
          <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30"><td class="px-4 py-3 font-medium">/blog</td><td class="px-4 py-3 text-right">15,221</td><td class="px-4 py-3 text-right">12,109</td><td class="px-4 py-3 text-right">52%</td><td class="px-4 py-3 text-right text-red-600">-3%</td></tr>
          <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30"><td class="px-4 py-3 font-medium">/signup</td><td class="px-4 py-3 text-right">11,082</td><td class="px-4 py-3 text-right">9,431</td><td class="px-4 py-3 text-right">18%</td><td class="px-4 py-3 text-right text-green-600">+31%</td></tr>
        </tbody>
      </table>
    </div>
  </div>

  <!-- Chart.js Init -->
  <script>
    // Traffic Line Chart
    new Chart(document.getElementById('trafficChart'), {
      type: 'line',
      data: {
        labels: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
        datasets: [{
          label: 'Views',
          data: [32000, 35000, 41000, 38000, 45000, 30000, 28000],
          borderColor: '#6366f1',
          backgroundColor: 'rgba(99,102,241,0.1)',
          fill: true,
          tension: 0.4,
          pointRadius: 4,
          pointBackgroundColor: '#6366f1',
        },{
          label: 'Visitors',
          data: [12000, 14000, 16000, 15000, 18000, 11000, 10000],
          borderColor: '#10b981',
          backgroundColor: 'rgba(16,185,129,0.1)',
          fill: true,
          tension: 0.4,
          pointRadius: 4,
          pointBackgroundColor: '#10b981',
        }]
      },
      options: {
        responsive: true,
        plugins: { legend: { position: 'bottom' } },
        scales: { y: { beginAtZero: true, grid: { color: 'rgba(156,163,175,0.1)' } }, x: { grid: { display: false } } }
      }
    });

    // Source Doughnut Chart
    new Chart(document.getElementById('sourceChart'), {
      type: 'doughnut',
      data: {
        labels: ['Organic','Direct','Referral','Social'],
        datasets: [{ data: [42,28,18,12], backgroundColor: ['#6366f1','#10b981','#f59e0b','#f43f5e'], borderWidth: 0 }]
      },
      options: {
        responsive: true,
        cutout: '65%',
        plugins: { legend: { display: false } }
      }
    });
  </script>

</body>
</html>
```

## Customization Guide
- **KPI cards**: Replace hard-coded numbers with `fetch()` calls to your API
- **Charts**: Modify `data` arrays and `labels` in the Chart.js configuration
- **Date filter**: Wire up the `<select>` to re-fetch data and update charts
- **Add more charts**: Create a new `<canvas>` and initialize another Chart.js instance
- **Real-time**: Add `setInterval(() => refreshData(), 30000)` for auto-refresh
- **Dark mode charts**: Set `Chart.defaults.color` and grid colors dynamically

## 2026 Trend Notes
- Chart.js v4 with tree-shaking support for smaller bundle sizes
- Progress bars under KPI values show percentage toward goals
- Doughnut chart with high cutout (65%) for modern donut look
- Grid layout with `lg:col-span-2` for primary chart emphasis
- Metric comparison text ("vs last period") provides immediate context
