# Modal Components
> Modal patterns: confirm dialog, form modal, image gallery, notification toast, and bottom sheet
> 모달 패턴: 확인 다이얼로그, 폼 모달, 이미지 갤러리, 알림 토스트, 바텀 시트

**Category**: Components | **Tags**: modal, dialog, toast, popup, tailwind | **Difficulty**: Intermediate

## Preview
```
+-------- Confirm Dialog ---------+
|  Are you sure?                  |
|  This action cannot be undone.  |
|      [Cancel]  [Delete]         |
+---------------------------------+

+--- Toast Notifications ---+
| [OK] File saved           |
| [WARN] Low storage        |
| [ERR] Upload failed       |
+---------------------------+
```

## Quick Start
```bash
# 1. Copy any modal component you need
# 2. Modals use vanilla JS (onclick toggle) - no framework required
# 3. Use data-modal-target for multiple modals on one page
```

## Full Code

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modal Components</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    .modal-backdrop { transition: opacity 0.2s; }
    .modal-panel { transition: transform 0.2s, opacity 0.2s; }
    .toast-enter { animation: slideInRight 0.3s ease; }
    @keyframes slideInRight { from { transform: translateX(100%); opacity:0; } to { transform: translateX(0); opacity:1; } }
    .sheet-enter { animation: slideUp 0.3s ease; }
    @keyframes slideUp { from { transform: translateY(100%); } to { transform: translateY(0); } }
  </style>
</head>
<body class="bg-gray-100 dark:bg-gray-900 p-8 min-h-screen">
  <div class="max-w-4xl mx-auto space-y-8">

    <h1 class="text-2xl font-bold text-gray-900 dark:text-white">Modal Components</h1>

    <!-- Trigger Buttons -->
    <div class="flex flex-wrap gap-3">
      <button onclick="document.getElementById('confirm-modal').classList.remove('hidden')" class="px-4 py-2 bg-red-600 text-white rounded-lg text-sm font-medium hover:bg-red-700 transition">Open Confirm</button>
      <button onclick="document.getElementById('form-modal').classList.remove('hidden')" class="px-4 py-2 bg-indigo-600 text-white rounded-lg text-sm font-medium hover:bg-indigo-700 transition">Open Form Modal</button>
      <button onclick="document.getElementById('gallery-modal').classList.remove('hidden')" class="px-4 py-2 bg-purple-600 text-white rounded-lg text-sm font-medium hover:bg-purple-700 transition">Open Gallery</button>
      <button onclick="showToast('success')" class="px-4 py-2 bg-green-600 text-white rounded-lg text-sm font-medium hover:bg-green-700 transition">Show Toast (OK)</button>
      <button onclick="showToast('error')" class="px-4 py-2 bg-red-600 text-white rounded-lg text-sm font-medium hover:bg-red-700 transition">Show Toast (Error)</button>
      <button onclick="document.getElementById('bottom-sheet').classList.remove('hidden')" class="px-4 py-2 bg-gray-700 text-white rounded-lg text-sm font-medium hover:bg-gray-600 transition">Open Bottom Sheet</button>
    </div>

    <!-- 1. Confirm Dialog -->
    <div id="confirm-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4">
      <div class="modal-backdrop absolute inset-0 bg-black/50" onclick="this.parentElement.classList.add('hidden')"></div>
      <div class="modal-panel relative bg-white dark:bg-gray-800 rounded-2xl p-6 w-full max-w-sm shadow-xl border border-gray-200 dark:border-gray-700">
        <div class="w-12 h-12 mx-auto bg-red-100 dark:bg-red-900/30 rounded-full flex items-center justify-center text-red-600 text-xl mb-4">&#9888;</div>
        <h3 class="text-lg font-bold text-center text-gray-900 dark:text-white">Delete Project?</h3>
        <p class="mt-2 text-sm text-gray-500 text-center">This action cannot be undone. All data associated with this project will be permanently removed.</p>
        <div class="mt-6 flex gap-3">
          <button onclick="this.closest('#confirm-modal').classList.add('hidden')" class="flex-1 py-2.5 border border-gray-300 dark:border-gray-600 rounded-xl text-sm font-medium hover:bg-gray-50 dark:hover:bg-gray-700 transition text-gray-700 dark:text-gray-300">Cancel</button>
          <button onclick="this.closest('#confirm-modal').classList.add('hidden')" class="flex-1 py-2.5 bg-red-600 text-white rounded-xl text-sm font-bold hover:bg-red-700 transition">Delete</button>
        </div>
      </div>
    </div>

    <!-- 2. Form Modal -->
    <div id="form-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4">
      <div class="modal-backdrop absolute inset-0 bg-black/50" onclick="this.parentElement.classList.add('hidden')"></div>
      <div class="modal-panel relative bg-white dark:bg-gray-800 rounded-2xl w-full max-w-md shadow-xl border border-gray-200 dark:border-gray-700">
        <div class="p-6 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between">
          <h3 class="text-lg font-bold text-gray-900 dark:text-white">Create New Task</h3>
          <button onclick="this.closest('#form-modal').classList.add('hidden')" class="text-gray-400 hover:text-gray-600 text-xl">&times;</button>
        </div>
        <form class="p-6 space-y-4">
          <div><label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Task Name</label><input type="text" required class="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500" placeholder="Enter task name"></div>
          <div><label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Priority</label><select class="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"><option>Low</option><option>Medium</option><option selected>High</option><option>Urgent</option></select></div>
          <div><label class="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-1">Description</label><textarea rows="3" class="w-full px-4 py-2.5 bg-gray-50 dark:bg-gray-700 border border-gray-200 dark:border-gray-600 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 resize-none" placeholder="Describe the task..."></textarea></div>
        </form>
        <div class="px-6 pb-6 flex gap-3 justify-end">
          <button onclick="this.closest('#form-modal').classList.add('hidden')" class="px-4 py-2 text-sm text-gray-500 hover:text-gray-700 transition">Cancel</button>
          <button onclick="this.closest('#form-modal').classList.add('hidden')" class="px-5 py-2 bg-indigo-600 text-white rounded-xl text-sm font-medium hover:bg-indigo-700 transition">Create Task</button>
        </div>
      </div>
    </div>

    <!-- 3. Gallery / Lightbox Modal -->
    <div id="gallery-modal" class="hidden fixed inset-0 z-50 flex items-center justify-center p-4">
      <div class="modal-backdrop absolute inset-0 bg-black/80" onclick="this.parentElement.classList.add('hidden')"></div>
      <div class="modal-panel relative max-w-3xl w-full">
        <button onclick="this.closest('#gallery-modal').classList.add('hidden')" class="absolute -top-10 right-0 text-white text-2xl hover:text-gray-300">&times;</button>
        <div class="aspect-video bg-gray-800 rounded-2xl overflow-hidden flex items-center justify-center">
          <div class="text-center"><div class="text-6xl mb-4">&#128444;</div><p class="text-gray-400 text-sm">Image preview placeholder</p><p class="text-xs text-gray-500 mt-1">Replace with &lt;img&gt; tag</p></div>
        </div>
        <p class="mt-3 text-center text-white text-sm">Photo 1 of 5 - Mountain Landscape</p>
        <div class="flex justify-center gap-4 mt-4">
          <button class="px-4 py-2 bg-white/10 rounded-lg text-white text-sm hover:bg-white/20 transition">&#8592; Previous</button>
          <button class="px-4 py-2 bg-white/10 rounded-lg text-white text-sm hover:bg-white/20 transition">Next &#8594;</button>
        </div>
      </div>
    </div>

    <!-- 4. Toast Notifications Container -->
    <div id="toast-container" class="fixed top-4 right-4 z-50 space-y-3 pointer-events-none"></div>

    <!-- 5. Bottom Sheet -->
    <div id="bottom-sheet" class="hidden fixed inset-0 z-50 flex items-end">
      <div class="absolute inset-0 bg-black/50" onclick="this.parentElement.classList.add('hidden')"></div>
      <div class="sheet-enter relative w-full bg-white dark:bg-gray-800 rounded-t-3xl max-h-[70vh] overflow-auto border-t border-gray-200 dark:border-gray-700">
        <div class="flex justify-center py-3"><div class="w-10 h-1 bg-gray-300 dark:bg-gray-600 rounded-full"></div></div>
        <div class="px-6 pb-8">
          <h3 class="text-lg font-bold text-gray-900 dark:text-white mb-4">Share this page</h3>
          <div class="grid grid-cols-4 gap-4 text-center">
            <button class="flex flex-col items-center gap-2"><div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center text-blue-600">&#128279;</div><span class="text-xs text-gray-500">Copy Link</span></button>
            <button class="flex flex-col items-center gap-2"><div class="w-12 h-12 bg-sky-100 dark:bg-sky-900/30 rounded-full flex items-center justify-center text-sky-600">&#128172;</div><span class="text-xs text-gray-500">Twitter</span></button>
            <button class="flex flex-col items-center gap-2"><div class="w-12 h-12 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center text-blue-700">&#128101;</div><span class="text-xs text-gray-500">Facebook</span></button>
            <button class="flex flex-col items-center gap-2"><div class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center text-green-600">&#9993;</div><span class="text-xs text-gray-500">Email</span></button>
          </div>
        </div>
      </div>
    </div>

  </div>

  <script>
    function showToast(type) {
      const container = document.getElementById('toast-container');
      const colors = { success: 'bg-green-600', error: 'bg-red-600', warn: 'bg-amber-500' };
      const icons = { success: '&#10003;', error: '&#10007;', warn: '&#9888;' };
      const msgs = { success: 'Operation completed successfully!', error: 'Something went wrong. Please try again.', warn: 'Storage space running low.' };
      const toast = document.createElement('div');
      toast.className = `toast-enter pointer-events-auto flex items-center gap-3 px-4 py-3 ${colors[type]} text-white rounded-xl shadow-lg text-sm min-w-[280px]`;
      toast.innerHTML = `<span class="text-lg">${icons[type]}</span><span class="flex-1">${msgs[type]}</span><button onclick="this.parentElement.remove()" class="text-white/70 hover:text-white">&times;</button>`;
      container.appendChild(toast);
      setTimeout(() => toast.remove(), 4000);
    }
  </script>

</body>
</html>
```

## Customization Guide
- **Confirm modal**: Change icon, title, and button text/colors for different actions (delete, archive, logout)
- **Form modal**: Add more fields; wire form submission to your API with `fetch()`
- **Gallery**: Replace placeholder with `<img>` elements; add prev/next logic with JS array index
- **Toasts**: Adjust position (`top-4 right-4`) to `bottom-4 left-4` or centered
- **Bottom sheet**: Change max-height with `max-h-[70vh]`; add drag-to-dismiss with touch events
- **Animations**: Adjust timing in CSS transitions for faster/slower open/close

## 2026 Trend Notes
- Modals use `fixed inset-0` with flex centering (no absolute positioning math)
- Click-outside-to-close on backdrop is standard UX expectation
- Toast notifications auto-dismiss after 4 seconds with smooth slide-in animation
- Bottom sheets (mobile pattern) are increasingly used on desktop for contextual actions
- Separate header/body/footer in form modals follows dialog best practices
