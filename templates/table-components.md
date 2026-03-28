# Table Components
> Table patterns: sortable, filterable, paginated, responsive, and expandable row tables
> 테이블 패턴: 정렬, 필터링, 페이지네이션, 반응형, 확장 가능한 행 테이블

**Category**: Components | **Tags**: table, data, sortable, pagination, responsive, tailwind | **Difficulty**: Intermediate

## Preview
```
+--- Sortable Table --------------------------------+
| Name ^   | Email       | Role   | Status | Action |
|----------|-------------|--------|--------|--------|
| Alice    | a@corp.com  | Admin  | Active |  ...   |
| Bob      | b@corp.com  | User   | Paused |  ...   |
+---------------------------------------------------+
| Showing 1-10 of 248    [< 1 2 3 ... 25 >]        |
+---------------------------------------------------+
```

## Quick Start
```bash
# 1. Copy the table variant you need
# 2. Sort and filter use vanilla JS (no dependencies)
# 3. Replace static rows with data from your API using JS template literals
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Table Components</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 dark:bg-gray-900 p-8 min-h-screen">
  <div class="max-w-6xl mx-auto space-y-12">

    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Table Components</h1>

    <!-- Full-Featured Table with Sort, Filter, Pagination -->
    <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 overflow-hidden shadow-sm">
      <!-- Toolbar -->
      <div class="p-4 border-b border-gray-200 dark:border-gray-700 flex flex-col sm:flex-row gap-3 items-start sm:items-center justify-between">
        <div class="flex items-center gap-3">
          <h2 class="font-semibold text-gray-900 dark:text-white">Users</h2>
          <span class="text-xs px-2 py-0.5 bg-gray-100 dark:bg-gray-700 rounded-full text-gray-500">248 total</span>
        </div>
        <div class="flex gap-2">
          <input id="tableSearch" type="text" placeholder="Search..." oninput="filterTable()" class="px-3 py-1.5 bg-gray-50 dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 w-48">
          <select class="px-3 py-1.5 bg-gray-50 dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-lg text-sm">
            <option>All Roles</option><option>Admin</option><option>Editor</option><option>Viewer</option>
          </select>
          <button class="px-3 py-1.5 bg-indigo-600 text-white text-sm rounded-lg hover:bg-indigo-700 transition">Export</button>
        </div>
      </div>

      <!-- Table -->
      <div class="overflow-x-auto">
        <table id="dataTable" class="w-full text-sm">
          <thead class="bg-gray-50 dark:bg-gray-700/50">
            <tr>
              <th class="text-left px-4 py-3 font-medium text-gray-500"><input type="checkbox" class="rounded"></th>
              <th class="text-left px-4 py-3 font-medium text-gray-500 cursor-pointer hover:text-gray-900 dark:hover:text-white select-none" onclick="sortTable(1)">Name <span class="text-xs">&#8645;</span></th>
              <th class="text-left px-4 py-3 font-medium text-gray-500 cursor-pointer hover:text-gray-900 dark:hover:text-white select-none" onclick="sortTable(2)">Email <span class="text-xs">&#8645;</span></th>
              <th class="text-left px-4 py-3 font-medium text-gray-500">Role</th>
              <th class="text-left px-4 py-3 font-medium text-gray-500 cursor-pointer hover:text-gray-900 dark:hover:text-white select-none" onclick="sortTable(4)">Status <span class="text-xs">&#8645;</span></th>
              <th class="text-left px-4 py-3 font-medium text-gray-500">Joined</th>
              <th class="text-right px-4 py-3 font-medium text-gray-500">Actions</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">
              <td class="px-4 py-3"><input type="checkbox" class="rounded"></td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white flex items-center gap-3"><div class="w-8 h-8 bg-indigo-500 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0">AK</div>Alice Kim</td>
              <td class="px-4 py-3 text-gray-500">alice@company.com</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-purple-100 text-purple-700 text-xs rounded-full font-medium">Admin</span></td>
              <td class="px-4 py-3"><span class="flex items-center gap-1.5"><span class="w-2 h-2 bg-green-500 rounded-full"></span><span class="text-green-600 text-xs font-medium">Active</span></span></td>
              <td class="px-4 py-3 text-gray-400 text-xs">Mar 15, 2026</td>
              <td class="px-4 py-3 text-right"><button class="text-gray-400 hover:text-gray-600 text-sm">Edit</button> <button class="text-red-400 hover:text-red-600 text-sm ml-2">Delete</button></td>
            </tr>
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">
              <td class="px-4 py-3"><input type="checkbox" class="rounded"></td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white flex items-center gap-3"><div class="w-8 h-8 bg-emerald-500 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0">BW</div>Bob Wilson</td>
              <td class="px-4 py-3 text-gray-500">bob@company.com</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-blue-100 text-blue-700 text-xs rounded-full font-medium">Editor</span></td>
              <td class="px-4 py-3"><span class="flex items-center gap-1.5"><span class="w-2 h-2 bg-green-500 rounded-full"></span><span class="text-green-600 text-xs font-medium">Active</span></span></td>
              <td class="px-4 py-3 text-gray-400 text-xs">Feb 28, 2026</td>
              <td class="px-4 py-3 text-right"><button class="text-gray-400 hover:text-gray-600 text-sm">Edit</button> <button class="text-red-400 hover:text-red-600 text-sm ml-2">Delete</button></td>
            </tr>
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">
              <td class="px-4 py-3"><input type="checkbox" class="rounded"></td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white flex items-center gap-3"><div class="w-8 h-8 bg-rose-500 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0">CJ</div>Carol Jones</td>
              <td class="px-4 py-3 text-gray-500">carol@company.com</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-gray-100 text-gray-700 text-xs rounded-full font-medium">Viewer</span></td>
              <td class="px-4 py-3"><span class="flex items-center gap-1.5"><span class="w-2 h-2 bg-yellow-500 rounded-full"></span><span class="text-yellow-600 text-xs font-medium">Pending</span></span></td>
              <td class="px-4 py-3 text-gray-400 text-xs">Mar 10, 2026</td>
              <td class="px-4 py-3 text-right"><button class="text-gray-400 hover:text-gray-600 text-sm">Edit</button> <button class="text-red-400 hover:text-red-600 text-sm ml-2">Delete</button></td>
            </tr>
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 transition">
              <td class="px-4 py-3"><input type="checkbox" class="rounded"></td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white flex items-center gap-3"><div class="w-8 h-8 bg-amber-500 rounded-full flex items-center justify-center text-white text-xs font-bold flex-shrink-0">DL</div>David Lee</td>
              <td class="px-4 py-3 text-gray-500">david@company.com</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-blue-100 text-blue-700 text-xs rounded-full font-medium">Editor</span></td>
              <td class="px-4 py-3"><span class="flex items-center gap-1.5"><span class="w-2 h-2 bg-red-500 rounded-full"></span><span class="text-red-600 text-xs font-medium">Inactive</span></span></td>
              <td class="px-4 py-3 text-gray-400 text-xs">Jan 05, 2026</td>
              <td class="px-4 py-3 text-right"><button class="text-gray-400 hover:text-gray-600 text-sm">Edit</button> <button class="text-red-400 hover:text-red-600 text-sm ml-2">Delete</button></td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="p-4 border-t border-gray-200 dark:border-gray-700 flex flex-col sm:flex-row items-center justify-between gap-3 text-sm text-gray-500">
        <span>Showing <b class="text-gray-900 dark:text-white">1-10</b> of <b class="text-gray-900 dark:text-white">248</b> results</span>
        <div class="flex items-center gap-1">
          <button class="px-3 py-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition disabled:opacity-40" disabled>&laquo;</button>
          <button class="px-3 py-1.5 bg-indigo-600 text-white rounded-lg font-medium">1</button>
          <button class="px-3 py-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">2</button>
          <button class="px-3 py-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">3</button>
          <span class="px-2">...</span>
          <button class="px-3 py-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">25</button>
          <button class="px-3 py-1.5 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition">&raquo;</button>
        </div>
      </div>
    </div>

    <!-- Expandable Row Table -->
    <div>
      <h2 class="text-lg font-semibold text-gray-900 dark:text-white mb-3">Expandable Rows</h2>
      <div class="bg-white dark:bg-gray-800 rounded-2xl border border-gray-200 dark:border-gray-700 overflow-hidden">
        <table class="w-full text-sm">
          <thead class="bg-gray-50 dark:bg-gray-700/50"><tr>
            <th class="w-10 px-4 py-3"></th>
            <th class="text-left px-4 py-3 font-medium text-gray-500">Order</th>
            <th class="text-left px-4 py-3 font-medium text-gray-500">Customer</th>
            <th class="text-right px-4 py-3 font-medium text-gray-500">Total</th>
            <th class="text-left px-4 py-3 font-medium text-gray-500">Status</th>
          </tr></thead>
          <tbody class="divide-y divide-gray-200 dark:divide-gray-700">
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 cursor-pointer" onclick="this.nextElementSibling.classList.toggle('hidden')">
              <td class="px-4 py-3 text-gray-400">&#9654;</td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white">#ORD-001</td>
              <td class="px-4 py-3 text-gray-500">Alice Kim</td>
              <td class="px-4 py-3 text-right font-medium text-gray-900 dark:text-white">$249.00</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-green-100 text-green-700 text-xs rounded-full">Shipped</span></td>
            </tr>
            <tr class="hidden bg-gray-50 dark:bg-gray-700/20">
              <td colspan="5" class="px-4 py-4">
                <div class="ml-10 grid grid-cols-3 gap-4 text-xs">
                  <div><span class="text-gray-400 block">Product</span><span class="text-gray-900 dark:text-white">Widget Pro X2</span></div>
                  <div><span class="text-gray-400 block">Quantity</span><span class="text-gray-900 dark:text-white">2</span></div>
                  <div><span class="text-gray-400 block">Tracking</span><a href="#" class="text-indigo-600 hover:underline">UPS-1Z999AA10</a></div>
                </div>
              </td>
            </tr>
            <tr class="hover:bg-gray-50 dark:hover:bg-gray-700/30 cursor-pointer" onclick="this.nextElementSibling.classList.toggle('hidden')">
              <td class="px-4 py-3 text-gray-400">&#9654;</td>
              <td class="px-4 py-3 font-medium text-gray-900 dark:text-white">#ORD-002</td>
              <td class="px-4 py-3 text-gray-500">Bob Wilson</td>
              <td class="px-4 py-3 text-right font-medium text-gray-900 dark:text-white">$89.00</td>
              <td class="px-4 py-3"><span class="px-2 py-0.5 bg-yellow-100 text-yellow-700 text-xs rounded-full">Processing</span></td>
            </tr>
            <tr class="hidden bg-gray-50 dark:bg-gray-700/20">
              <td colspan="5" class="px-4 py-4">
                <div class="ml-10 grid grid-cols-3 gap-4 text-xs">
                  <div><span class="text-gray-400 block">Product</span><span class="text-gray-900 dark:text-white">Widget Mini</span></div>
                  <div><span class="text-gray-400 block">Quantity</span><span class="text-gray-900 dark:text-white">1</span></div>
                  <div><span class="text-gray-400 block">ETA</span><span class="text-gray-900 dark:text-white">Mar 30, 2026</span></div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>

  </div>

  <script>
    let sortDir = {};
    function sortTable(colIdx) {
      const table = document.getElementById('dataTable');
      const tbody = table.querySelector('tbody');
      const rows = Array.from(tbody.querySelectorAll('tr'));
      sortDir[colIdx] = !sortDir[colIdx];
      rows.sort((a, b) => {
        const aText = a.cells[colIdx]?.textContent.trim() || '';
        const bText = b.cells[colIdx]?.textContent.trim() || '';
        return sortDir[colIdx] ? aText.localeCompare(bText) : bText.localeCompare(aText);
      });
      rows.forEach(r => tbody.appendChild(r));
    }
    function filterTable() {
      const query = document.getElementById('tableSearch').value.toLowerCase();
      const rows = document.querySelectorAll('#dataTable tbody tr');
      rows.forEach(r => { r.style.display = r.textContent.toLowerCase().includes(query) ? '' : 'none'; });
    }
  </script>

</body>
</html>
```

## Customization Guide
- **Columns**: Add or remove `<th>` and corresponding `<td>` elements
- **Sorting**: The `sortTable()` function works on any text column; for numeric sorting add `parseFloat()`
- **Pagination**: Wire up page buttons to slice your data array or call paginated API
- **Bulk actions**: Use the checkboxes to collect selected row IDs for bulk operations
- **Responsive**: On mobile, wrap table in `overflow-x-auto` for horizontal scroll
- **Expandable rows**: The toggle `onclick` uses `nextElementSibling` - ensure detail row is immediately after

## 2026 Trend Notes
- Toolbar with search + filter + export above the table is the standard data table pattern
- Status badges with colored dots provide instant visual feedback
- Checkbox column enables bulk operations (delete, export, assign)
- Expandable rows eliminate the need for separate detail pages
- Vanilla JS sort/filter keeps the template framework-agnostic
