// Beyond the AI Plateau PWA Service Worker
// Version 1.0 - Comprehensive offline functionality for content and templates

const CACHE_NAME = 'beyond-ai-plateau-v1';
const CONTENT_CACHE = 'content-v1';
const TEMPLATE_CACHE = 'templates-v1';
const ASSETS_CACHE = 'assets-v1';

// Critical resources for offline functionality
const CRITICAL_RESOURCES = [
  '/',
  '/manifest.json',
  '/css/main.css',
  '/css/pwa-styles.css',
  '/js/main.js',
  '/js/pwa-app.js',
  '/js/offline-sync.js',
  '/assets/fonts/inter-variable.woff2',
  '/assets/fonts/fira-code-variable.woff2'
];

// Critical content for offline access
const CRITICAL_CONTENT = [
  '/content/principles/ch01-ai-betrayal/chapter-01-the-great-ai-betrayal.md',
  '/content/principles/ch02-framework/chapter-02-five-elite-principles-framework.md',
  '/content/principles/ch03-context-mastery/chapter-03-context-mastery.md',
  '/content/case-studies/foundation/tommy-complete-transformation.md'
];

// Critical templates for offline access
const CRITICAL_TEMPLATES = [
  '/content/templates/context-mastery/foundation/repository-context-creation.md',
  '/content/templates/dynamic-planning/foundation/basic-project-initialization.md',
  '/content/templates/code-evolution/foundation/basic-code-cleanup.md',
  '/content/templates/cross-principle-integration/complete-feature-development-workflow.md'
];

self.addEventListener('install', event => {
  console.log('PWA Service Worker installing...');
  event.waitUntil(
    Promise.all([
      caches.open(CACHE_NAME).then(cache => cache.addAll(CRITICAL_RESOURCES)),
      caches.open(CONTENT_CACHE).then(cache => cache.addAll(CRITICAL_CONTENT)),
      caches.open(TEMPLATE_CACHE).then(cache => cache.addAll(CRITICAL_TEMPLATES)),
      setupOfflineDatabase()
    ]).then(() => {
      console.log('PWA Service Worker installed successfully');
      self.skipWaiting();
    })
  );
});

self.addEventListener('activate', event => {
  console.log('PWA Service Worker activating...');
  event.waitUntil(
    Promise.all([
      cleanupOldCaches(),
      self.clients.claim()
    ]).then(() => {
      console.log('PWA Service Worker activated');
    })
  );
});

self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  
  // Handle different types of requests
  if (url.pathname.startsWith('/content/')) {
    event.respondWith(handleContentRequest(event.request));
  } else if (url.pathname.startsWith('/assets/')) {
    event.respondWith(handleAssetRequest(event.request));
  } else if (url.pathname.includes('api')) {
    event.respondWith(handleApiRequest(event.request));
  } else {
    event.respondWith(handleGenericRequest(event.request));
  }
});

// Content request handling with offline fallback
async function handleContentRequest(request) {
  const url = new URL(request.url);
  const cacheName = url.pathname.includes('/templates/') ? TEMPLATE_CACHE : CONTENT_CACHE;
  
  try {
    // Try cache first for content
    const cachedResponse = await caches.match(request, { cacheName });
    if (cachedResponse) {
      // Update in background if online
      if (navigator.onLine) {
        updateCacheInBackground(request, cacheName);
      }
      return cachedResponse;
    }
    
    // Try network if cache miss
    const networkResponse = await fetch(request);
    if (networkResponse.ok) {
      const cache = await caches.open(cacheName);
      cache.put(request, networkResponse.clone());
      return networkResponse;
    }
    
    throw new Error(`Network response not ok: ${networkResponse.status}`);
    
  } catch (error) {
    console.error('Content request failed:', error);
    return createOfflineContentFallback(url.pathname);
  }
}

// Asset request handling
async function handleAssetRequest(request) {
  try {
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }
    
    const networkResponse = await fetch(request);
    if (networkResponse.ok) {
      const cache = await caches.open(ASSETS_CACHE);
      cache.put(request, networkResponse.clone());
      return networkResponse;
    }
    
    return networkResponse;
    
  } catch (error) {
    console.error('Asset request failed:', error);
    return createAssetFallback(request);
  }
}

// API request handling with offline queue
async function handleApiRequest(request) {
  try {
    if (!navigator.onLine) {
      // Queue API requests for when online
      await queueApiRequest(request);
      return createOfflineApiResponse();
    }
    
    const response = await fetch(request);
    
    // Cache successful GET requests
    if (request.method === 'GET' && response.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, response.clone());
    }
    
    return response;
    
  } catch (error) {
    console.error('API request failed:', error);
    
    // Try cached response for GET requests
    if (request.method === 'GET') {
      const cachedResponse = await caches.match(request);
      if (cachedResponse) {
        return cachedResponse;
      }
    }
    
    return createOfflineApiResponse();
  }
}

// Generic request handling
async function handleGenericRequest(request) {
  try {
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
      return cachedResponse;
    }
    
    const networkResponse = await fetch(request);
    if (networkResponse.ok) {
      const cache = await caches.open(CACHE_NAME);
      cache.put(request, networkResponse.clone());
    }
    
    return networkResponse;
    
  } catch (error) {
    console.error('Generic request failed:', error);
    return createOfflineFallback();
  }
}

// Background cache update
async function updateCacheInBackground(request, cacheName) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      const cache = await caches.open(cacheName);
      cache.put(request, response);
    }
  } catch (error) {
    console.error('Background cache update failed:', error);
  }
}

// Offline content fallback
function createOfflineContentFallback(pathname) {
  const isTemplate = pathname.includes('/templates/');
  const contentType = isTemplate ? 'Template' : 'Content';
  const fileName = pathname.split('/').pop().replace('.md', '');
  
  const fallbackContent = `
# Offline Mode - ${contentType} Not Available

This ${contentType.toLowerCase()} is not available offline. 

**File**: ${fileName}
**Status**: Will be available when you're connected to the internet

## What you can do now:
- Browse cached content and templates
- Use offline features like bookmarks and notes
- Access previously viewed content
- Review your progress and achievements

## When you're back online:
- Content will automatically sync
- All offline changes will be saved
- You'll have access to the complete library

*Beyond the AI Plateau PWA - Designed for offline learning*
  `;
  
  return new Response(fallbackContent, {
    headers: {
      'Content-Type': 'text/markdown',
      'Cache-Control': 'no-cache',
      'X-Offline-Fallback': 'true'
    }
  });
}

// Asset fallback for missing images/diagrams
function createAssetFallback(request) {
  const url = new URL(request.url);
  
  if (url.pathname.includes('.svg')) {
    // SVG fallback for diagrams
    const fallbackSVG = `
      <svg viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg">
        <rect width="400" height="300" fill="#f3f4f6" stroke="#d1d5db" stroke-width="2"/>
        <text x="200" y="140" text-anchor="middle" font-family="sans-serif" font-size="14" fill="#6b7280">
          Diagram unavailable offline
        </text>
        <text x="200" y="170" text-anchor="middle" font-family="sans-serif" font-size="12" fill="#9ca3af">
          Will load when connected
        </text>
      </svg>
    `;
    
    return new Response(fallbackSVG, {
      headers: { 'Content-Type': 'image/svg+xml' }
    });
  }
  
  return new Response('Asset unavailable offline', { status: 503 });
}

// Offline API response
function createOfflineApiResponse() {
  return new Response(JSON.stringify({
    error: 'Offline mode',
    message: 'This action will be completed when you\'re back online',
    offline: true,
    timestamp: new Date().toISOString()
  }), {
    headers: { 'Content-Type': 'application/json' },
    status: 503
  });
}

// Generic offline fallback
function createOfflineFallback() {
  const fallbackHTML = `
    <!DOCTYPE html>
    <html>
    <head>
      <title>Offline - Beyond the AI Plateau</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
        body { font-family: system-ui, sans-serif; max-width: 600px; margin: 2rem auto; padding: 1rem; }
        .offline-message { text-align: center; padding: 2rem; background: #f3f4f6; border-radius: 8px; }
        .features { margin-top: 2rem; }
        .feature { margin-bottom: 1rem; }
      </style>
    </head>
    <body>
      <div class="offline-message">
        <h1>📱 You're Offline</h1>
        <p>Beyond the AI Plateau PWA is designed to work offline!</p>
        
        <div class="features">
          <div class="feature">✅ Access cached content and templates</div>
          <div class="feature">✅ Use bookmarks and note-taking features</div>
          <div class="feature">✅ Track your learning progress</div>
          <div class="feature">✅ Browse previously viewed material</div>
        </div>
        
        <p><small>Content will sync automatically when you're back online.</small></p>
      </div>
    </body>
    </html>
  `;
  
  return new Response(fallbackHTML, {
    headers: { 'Content-Type': 'text/html' }
  });
}

// Queue API requests for later sync
async function queueApiRequest(request) {
  try {
    const requestData = {
      url: request.url,
      method: request.method,
      headers: Object.fromEntries(request.headers.entries()),
      body: request.method !== 'GET' ? await request.text() : null,
      timestamp: Date.now()
    };
    
    // Store in IndexedDB for persistence
    const db = await openOfflineDB();
    const transaction = db.transaction(['sync_queue'], 'readwrite');
    const store = transaction.objectStore('sync_queue');
    store.add(requestData);
    
  } catch (error) {
    console.error('Failed to queue API request:', error);
  }
}

// Setup offline database
async function setupOfflineDatabase() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('OfflinePWADB', 1);
    
    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);
    
    request.onupgradeneeded = (event) => {
      const db = event.target.result;
      
      // Create sync queue for offline API requests
      if (!db.objectStoreNames.contains('sync_queue')) {
        const syncStore = db.createObjectStore('sync_queue', { keyPath: 'id', autoIncrement: true });
        syncStore.createIndex('timestamp', 'timestamp', { unique: false });
      }
      
      // Create user data store
      if (!db.objectStoreNames.contains('user_data')) {
        const userStore = db.createObjectStore('user_data', { keyPath: 'key' });
      }
      
      // Create content progress store
      if (!db.objectStoreNames.contains('progress')) {
        const progressStore = db.createObjectStore('progress', { keyPath: 'content_id' });
        progressStore.createIndex('last_updated', 'last_updated', { unique: false });
      }
    };
  });
}

// Open offline database
function openOfflineDB() {
  return new Promise((resolve, reject) => {
    const request = indexedDB.open('OfflinePWADB', 1);
    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);
  });
}

// Cleanup old caches
async function cleanupOldCaches() {
  const cacheNames = await caches.keys();
  const oldCaches = cacheNames.filter(name => 
    name.startsWith('beyond-ai-plateau-') && name !== CACHE_NAME
  );
  
  return Promise.all(oldCaches.map(name => caches.delete(name)));
}

// Background sync for queued requests
self.addEventListener('sync', event => {
  if (event.tag === 'api-sync') {
    event.waitUntil(syncQueuedApiRequests());
  }
});

// Sync queued API requests when back online
async function syncQueuedApiRequests() {
  try {
    const db = await openOfflineDB();
    const transaction = db.transaction(['sync_queue'], 'readwrite');
    const store = transaction.objectStore('sync_queue');
    const requests = await getAllFromStore(store);
    
    for (const requestData of requests) {
      try {
        const response = await fetch(requestData.url, {
          method: requestData.method,
          headers: requestData.headers,
          body: requestData.body
        });
        
        if (response.ok) {
          // Remove successful request from queue
          store.delete(requestData.id);
        }
      } catch (error) {
        console.error('Failed to sync request:', error);
      }
    }
  } catch (error) {
    console.error('Failed to sync queued requests:', error);
  }
}

// Helper to get all items from IndexedDB store
function getAllFromStore(store) {
  return new Promise((resolve, reject) => {
    const request = store.getAll();
    request.onerror = () => reject(request.error);
    request.onsuccess = () => resolve(request.result);
  });
}

// Push notification handling
self.addEventListener('push', event => {
  if (event.data) {
    const notification = event.data.json();
    const options = {
      body: notification.body,
      icon: '/assets/icons/icon-192x192.png',
      badge: '/assets/icons/badge-72x72.png',
      tag: notification.tag || 'default',
      data: notification.data,
      actions: notification.actions || []
    };
    
    event.waitUntil(
      self.registration.showNotification(notification.title, options)
    );
  }
});

// Notification click handling
self.addEventListener('notificationclick', event => {
  event.notification.close();
  
  const url = event.notification.data?.url || '/';
  
  event.waitUntil(
    self.clients.matchAll({ type: 'window' }).then(clients => {
      const client = clients.find(c => c.url === url && 'focus' in c);
      
      if (client) {
        return client.focus();
      } else {
        return self.clients.openWindow(url);
      }
    })
  );
});

console.log('Beyond the AI Plateau Service Worker loaded successfully');