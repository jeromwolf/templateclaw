# System Monitoring Dashboard
> System monitoring dashboard with status indicators, uptime metrics, alerts log, and service health
> 상태 표시기, 업타임 지표, 알림 로그, 서비스 헬스 체크가 포함된 시스템 모니터링 대시보드

**Category**: Dashboard | **Tags**: monitoring, devops, status, uptime, alerts | **Difficulty**: Intermediate

## Preview
```
+--------------------------------------------------+
|  System Monitor         [All Systems Operational] |
+--------------------------------------------------+
| API: [GREEN] 99.99%   DB: [GREEN] 99.95%         |
| CDN: [GREEN] 100%     Queue: [YELLOW] 98.2%      |
+--------------------------------------------------+
|                                                    |
| +--- Response Time ---+  +--- Error Rate ----+   |
| | [area chart]        |  | [area chart]      |   |
| +---------------------+  +-------------------+   |
|                                                    |
| +--- Recent Alerts -------------------------+     |
| | WARN  Queue latency high   2m ago         |     |
| | OK    API restored         15m ago        |     |
| | CRIT  DB connection spike  1h ago         |     |
| +-------------------------------------------+     |
+--------------------------------------------------+
```

## Quick Start
```bash
# 1. Save as index.html, open in browser
# 2. Replace static data with polling from your /health endpoints
# 3. Add WebSocket connection for real-time alerts
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>System Monitor</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    @keyframes pulse-green { 0%, 100% { box-shadow: 0 0 0 0 rgba(34,197,94,0.4); } 50% { box-shadow: 0 0 0 6px rgba(34,197,94,0); } }
    .pulse-green { animation: pulse-green 2s infinite; }
    @keyframes pulse-yellow { 0%, 100% { box-shadow: 0 0 0 0 rgba(234,179,8,0.4); } 50% { box-shadow: 0 0 0 6px rgba(234,179,8,0); } }
    .pulse-yellow { animation: pulse-yellow 2s infinite; }
    @keyframes pulse-red { 0%, 100% { box-shadow: 0 0 0 0 rgba(239,68,68,0.4); } 50% { box-shadow: 0 0 0 6px rgba(239,68,68,0); } }
    .pulse-red { animation: pulse-red 1.5s infinite; }
  </style>
</head>
<body class="bg-gray-950 text-gray-100 min-h-screen p-6">

  <div class="max-w-6xl mx-auto">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row items-start sm:items-center justify-between gap-4 mb-8">
      <div>
        <h1 class="text-2xl font-bold">System Monitor</h1>
        <p class="text-sm text-gray-400">Real-time infrastructure health</p>
      </div>
      <div class="flex items-center gap-3">
        <span class="flex items-center gap-2 px-4 py-2 bg-green-900/30 border border-green-800 rounded-lg text-sm text-green-400">
          <span class="w-2.5 h-2.5 bg-green-500 rounded-full pulse-green"></span>
          All Systems Operational
        </span>
        <span class="text-xs text-gray-500">Updated 5s ago</span>
      </div>
    </div>

    <!-- Service Status Grid -->
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5">
        <div class="flex items-center gap-2 mb-3">
          <span class="w-3 h-3 bg-green-500 rounded-full pulse-green"></span>
          <span class="text-sm font-medium">API Server</span>
        </div>
        <div class="text-2xl font-bold text-green-400">99.99%</div>
        <div class="text-xs text-gray-500 mt-1">Uptime (30d)</div>
        <div class="mt-3 text-xs text-gray-400">Latency: <span class="text-white font-medium">42ms</span></div>
      </div>
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5">
        <div class="flex items-center gap-2 mb-3">
          <span class="w-3 h-3 bg-green-500 rounded-full pulse-green"></span>
          <span class="text-sm font-medium">Database</span>
        </div>
        <div class="text-2xl font-bold text-green-400">99.95%</div>
        <div class="text-xs text-gray-500 mt-1">Uptime (30d)</div>
        <div class="mt-3 text-xs text-gray-400">Connections: <span class="text-white font-medium">48/100</span></div>
      </div>
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5">
        <div class="flex items-center gap-2 mb-3">
          <span class="w-3 h-3 bg-green-500 rounded-full pulse-green"></span>
          <span class="text-sm font-medium">CDN</span>
        </div>
        <div class="text-2xl font-bold text-green-400">100%</div>
        <div class="text-xs text-gray-500 mt-1">Uptime (30d)</div>
        <div class="mt-3 text-xs text-gray-400">Hit Rate: <span class="text-white font-medium">94.2%</span></div>
      </div>
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5">
        <div class="flex items-center gap-2 mb-3">
          <span class="w-3 h-3 bg-yellow-500 rounded-full pulse-yellow"></span>
          <span class="text-sm font-medium">Queue</span>
        </div>
        <div class="text-2xl font-bold text-yellow-400">98.2%</div>
        <div class="text-xs text-gray-500 mt-1">Uptime (30d)</div>
        <div class="mt-3 text-xs text-gray-400">Depth: <span class="text-yellow-300 font-medium">1,240 msgs</span></div>
      </div>
    </div>

    <!-- Metrics Row -->
    <div class="grid md:grid-cols-2 gap-4 mb-8">
      <!-- Response Time -->
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-6">
        <div class="flex items-center justify-between mb-4">
          <h2 class="font-semibold">Response Time (p95)</h2>
          <span class="text-sm text-emerald-400 font-medium">42ms avg</span>
        </div>
        <div class="flex items-end gap-1 h-32">
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:60%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:55%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:70%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:45%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:80%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:65%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:50%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:42%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:58%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:75%"></div>
          <div class="flex-1 bg-emerald-900/40 rounded-t" style="height:35%"></div>
          <div class="flex-1 bg-emerald-500 rounded-t" style="height:42%"></div>
        </div>
        <div class="flex justify-between text-xs text-gray-500 mt-2"><span>12h ago</span><span>Now</span></div>
      </div>
      <!-- Error Rate -->
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-6">
        <div class="flex items-center justify-between mb-4">
          <h2 class="font-semibold">Error Rate</h2>
          <span class="text-sm text-emerald-400 font-medium">0.02%</span>
        </div>
        <div class="flex items-end gap-1 h-32">
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:10%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:8%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:15%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:12%"></div>
          <div class="flex-1 bg-red-500/40 rounded-t" style="height:45%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:18%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:5%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:3%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:7%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:4%"></div>
          <div class="flex-1 bg-red-900/30 rounded-t" style="height:2%"></div>
          <div class="flex-1 bg-red-500 rounded-t" style="height:2%"></div>
        </div>
        <div class="flex justify-between text-xs text-gray-500 mt-2"><span>12h ago</span><span>Now</span></div>
      </div>
    </div>

    <!-- System Resources -->
    <div class="grid grid-cols-3 gap-4 mb-8">
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5 text-center">
        <div class="text-sm text-gray-400 mb-2">CPU Usage</div>
        <div class="relative w-20 h-20 mx-auto">
          <svg class="w-20 h-20 -rotate-90" viewBox="0 0 36 36">
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#1f2937" stroke-width="3"/>
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#10b981" stroke-width="3" stroke-dasharray="34, 100"/>
          </svg>
          <div class="absolute inset-0 flex items-center justify-center text-lg font-bold">34%</div>
        </div>
        <div class="text-xs text-gray-500 mt-2">4 cores / 8 threads</div>
      </div>
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5 text-center">
        <div class="text-sm text-gray-400 mb-2">Memory</div>
        <div class="relative w-20 h-20 mx-auto">
          <svg class="w-20 h-20 -rotate-90" viewBox="0 0 36 36">
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#1f2937" stroke-width="3"/>
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#f59e0b" stroke-width="3" stroke-dasharray="67, 100"/>
          </svg>
          <div class="absolute inset-0 flex items-center justify-center text-lg font-bold">67%</div>
        </div>
        <div class="text-xs text-gray-500 mt-2">10.7 / 16 GB</div>
      </div>
      <div class="bg-gray-900 border border-gray-800 rounded-xl p-5 text-center">
        <div class="text-sm text-gray-400 mb-2">Disk</div>
        <div class="relative w-20 h-20 mx-auto">
          <svg class="w-20 h-20 -rotate-90" viewBox="0 0 36 36">
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#1f2937" stroke-width="3"/>
            <path d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="#10b981" stroke-width="3" stroke-dasharray="52, 100"/>
          </svg>
          <div class="absolute inset-0 flex items-center justify-center text-lg font-bold">52%</div>
        </div>
        <div class="text-xs text-gray-500 mt-2">260 / 500 GB</div>
      </div>
    </div>

    <!-- Recent Alerts -->
    <div class="bg-gray-900 border border-gray-800 rounded-xl overflow-hidden">
      <div class="p-4 border-b border-gray-800 flex items-center justify-between">
        <h2 class="font-semibold">Recent Alerts</h2>
        <span class="text-xs text-gray-500">Last 24 hours</span>
      </div>
      <div class="divide-y divide-gray-800">
        <div class="px-4 py-3 flex items-center gap-4">
          <span class="px-2 py-0.5 bg-yellow-900/50 text-yellow-400 text-xs font-bold rounded">WARN</span>
          <span class="flex-1 text-sm">Queue latency exceeded 500ms threshold</span>
          <span class="text-xs text-gray-500">2 min ago</span>
        </div>
        <div class="px-4 py-3 flex items-center gap-4">
          <span class="px-2 py-0.5 bg-green-900/50 text-green-400 text-xs font-bold rounded">OK</span>
          <span class="flex-1 text-sm">API Server response time normalized</span>
          <span class="text-xs text-gray-500">15 min ago</span>
        </div>
        <div class="px-4 py-3 flex items-center gap-4">
          <span class="px-2 py-0.5 bg-red-900/50 text-red-400 text-xs font-bold rounded">CRIT</span>
          <span class="flex-1 text-sm">Database connection pool exhausted (48/100 connections)</span>
          <span class="text-xs text-gray-500">1 hour ago</span>
        </div>
        <div class="px-4 py-3 flex items-center gap-4">
          <span class="px-2 py-0.5 bg-green-900/50 text-green-400 text-xs font-bold rounded">OK</span>
          <span class="flex-1 text-sm">CDN cache purge completed successfully</span>
          <span class="text-xs text-gray-500">3 hours ago</span>
        </div>
        <div class="px-4 py-3 flex items-center gap-4">
          <span class="px-2 py-0.5 bg-blue-900/50 text-blue-400 text-xs font-bold rounded">INFO</span>
          <span class="flex-1 text-sm">Deployment v2.4.1 rolled out to production</span>
          <span class="text-xs text-gray-500">6 hours ago</span>
        </div>
      </div>
    </div>
  </div>

</body>
</html>
```

## Customization Guide
- **Status colors**: Green = healthy, Yellow = degraded, Red = down. Change the pulse animation class accordingly
- **Circular gauges**: Adjust `stroke-dasharray` value (first number = percentage, out of 100)
- **Bar charts**: Replace static `<div>` bars with Chart.js or D3 for interactive charts
- **Alerts**: Connect to your alerting system (PagerDuty, Opsgenie) via WebSocket
- **Auto-refresh**: Add `setInterval(() => fetchStatus(), 5000)` for live polling
- **Thresholds**: Color-code metrics based on thresholds (green < 70%, yellow < 90%, red >= 90%)

## 2026 Trend Notes
- Pulsing status dots provide immediate visual health indication
- SVG circular progress gauges are pure CSS (no library needed)
- Dark theme is standard for DevOps monitoring dashboards
- Alert severity levels (CRIT/WARN/OK/INFO) follow industry standards
- Bar chart built with pure CSS flex for lightweight initial load
