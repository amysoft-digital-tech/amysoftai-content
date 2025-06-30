// Beyond the AI Plateau - Service Worker
// Version 1.0 - Comprehensive PWA Integration

const CACHE_NAME = 'ai-plateau-v1';
const STATIC_CACHE = 'ai-plateau-static-v1';
const DYNAMIC_CACHE = 'ai-plateau-dynamic-v1';
const TEMPLATE_CACHE = 'ai-plateau-templates-v1';
const ASSETS_CACHE = 'ai-plateau-assets-v1';

// Critical resources for offline functionality
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/manifest.json',
  '/assets/css/main.css',
  '/assets/js/app.js',
  '/assets/js/offline.js',
  '/assets/fonts/inter-var.woff2',
  '/assets/icons/icon-192x192.png',
  '/assets/icons/icon-512x512.png'
];

// Template library resources
const TEMPLATE_ASSETS = [
  '/templates/',
  '/templates/index.html',
  '/templates/context-mastery/',
  '/templates/dynamic-planning/',
  '/templates/code-evolution/',
  '/templates/strategic-testing/',
  '/templates/intelligent-review/',
  '/templates/cross-principle-integration/'
];

// Content chapter resources
const CONTENT_ASSETS = [
  '/content/',
  '/content/principles/',
  '/content/principles/ch01-ai-betrayal/',
  '/content/principles/ch02-framework/',
  '/content/principles/ch03-context-mastery/',
  '/content/principles/ch04-dynamic-planning/',
  '/content/principles/ch05-code-evolution/',
  '/content/principles/ch06-strategic-testing/',
  '/content/principles/ch07-intelligent-review/',
  '/content/principles/ch08-compound-effects/',
  '/content/principles/ch09-transformation-roadmap/'
];

// Visual diagram resources
const VISUAL_ASSETS = [
  '/assets/diagrams/',
  '/assets/diagrams/context-mastery/',
  '/assets/diagrams/dynamic-planning/',
  '/assets/diagrams/code-evolution/',
  '/assets/diagrams/strategic-testing/',
  '/assets/diagrams/intelligent-review/',
  '/assets/diagrams/integration/'
];

// Installation event - cache static resources
self.addEventListener('install', event => {
  console.log('Service Worker: Installing...');
  
  event.waitUntil(
    Promise.all([
      // Cache static assets
      caches.open(STATIC_CACHE).then(cache => {
        console.log('Service Worker: Caching static assets');
        return cache.addAll(STATIC_ASSETS);
      }),
      
      // Cache template library
      caches.open(TEMPLATE_CACHE).then(cache => {
        console.log('Service Worker: Caching template library');
        return cache.addAll(TEMPLATE_ASSETS);
      }),
      
      // Cache essential content
      caches.open(DYNAMIC_CACHE).then(cache => {
        console.log('Service Worker: Caching essential content');
        return cache.addAll(CONTENT_ASSETS.slice(0, 5)); // Cache first 5 for performance
      })
    ]).then(() => {
      console.log('Service Worker: Installation complete');
      return self.skipWaiting();
    }).catch(error => {
      console.error('Service Worker: Installation failed', error);
    })
  );
});

// Activation event - clean up old caches
self.addEventListener('activate', event => {
  console.log('Service Worker: Activating...');
  
  event.waitUntil(
    caches.keys().then(cacheNames => {
      const validCaches = [STATIC_CACHE, DYNAMIC_CACHE, TEMPLATE_CACHE, ASSETS_CACHE];
      
      return Promise.all(
        cacheNames.map(cacheName => {
          if (!validCaches.includes(cacheName)) {
            console.log('Service Worker: Deleting old cache', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => {
      console.log('Service Worker: Activation complete');
      return self.clients.claim();
    })
  );
});

// Fetch event - serve cached content with fallback strategies
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);
  
  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }
  
  // Skip external requests
  if (!url.origin.includes(self.location.origin)) {
    return;
  }
  
  event.respondWith(
    handleRequest(request)
  );
});

// Request handling strategy based on resource type
async function handleRequest(request) {
  const url = new URL(request.url);
  const pathname = url.pathname;
  
  try {
    // Static assets - cache first
    if (isStaticAsset(pathname)) {
      return await cacheFirst(request, STATIC_CACHE);
    }
    
    // Templates - cache first with network fallback
    if (isTemplateResource(pathname)) {
      return await cacheFirst(request, TEMPLATE_CACHE);
    }
    
    // Content chapters - stale while revalidate
    if (isContentResource(pathname)) {
      return await staleWhileRevalidate(request, DYNAMIC_CACHE);
    }
    
    // Visual diagrams - cache first
    if (isVisualAsset(pathname)) {
      return await cacheFirst(request, ASSETS_CACHE);
    }
    
    // API requests - network first
    if (isApiRequest(pathname)) {
      return await networkFirst(request, DYNAMIC_CACHE);
    }
    
    // Default - network first with cache fallback
    return await networkFirst(request, DYNAMIC_CACHE);
    
  } catch (error) {
    console.error('Service Worker: Request handling failed', error);
    return await handleOfflineFallback(request);
  }
}

// Caching strategies
async function cacheFirst(request, cacheName) {
  const cache = await caches.open(cacheName);
  const cached = await cache.match(request);
  
  if (cached) {
    // Optionally update cache in background
    updateCacheInBackground(request, cache);
    return cached;
  }
  
  const response = await fetch(request);
  if (response.ok) {
    cache.put(request, response.clone());
  }
  return response;
}

async function networkFirst(request, cacheName) {
  const cache = await caches.open(cacheName);
  
  try {
    const response = await fetch(request);
    if (response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  } catch (error) {
    const cached = await cache.match(request);
    if (cached) {
      return cached;
    }
    throw error;
  }
}

async function staleWhileRevalidate(request, cacheName) {
  const cache = await caches.open(cacheName);
  const cached = await cache.match(request);
  
  const networkPromise = fetch(request).then(response => {
    if (response.ok) {
      cache.put(request, response.clone());
    }
    return response;
  }).catch(() => {
    // Network failed, return cached version
    return cached;
  });
  
  // Return cached version immediately if available
  if (cached) {
    return cached;
  }
  
  // Wait for network if no cached version
  return networkPromise;
}

async function updateCacheInBackground(request, cache) {
  try {
    const response = await fetch(request);
    if (response.ok) {
      await cache.put(request, response);
    }
  } catch (error) {
    // Silent fail for background updates
    console.log('Background cache update failed:', error);
  }
}

// Resource type detection
function isStaticAsset(pathname) {
  return pathname.match(/\.(css|js|woff2?|png|jpg|jpeg|svg|ico)$/) ||
         pathname === '/' ||
         pathname === '/index.html' ||
         pathname === '/manifest.json';
}

function isTemplateResource(pathname) {
  return pathname.startsWith('/templates/') ||
         pathname.includes('template') ||
         pathname.includes('.md');
}

function isContentResource(pathname) {
  return pathname.startsWith('/content/') ||
         pathname.startsWith('/principles/') ||
         pathname.includes('/ch0');
}

function isVisualAsset(pathname) {
  return pathname.startsWith('/assets/diagrams/') ||
         pathname.startsWith('/assets/images/') ||
         pathname.includes('/svg/');
}

function isApiRequest(pathname) {
  return pathname.startsWith('/api/') ||
         pathname.includes('/search') ||
         pathname.includes('/analytics');
}

// Offline fallback handling
async function handleOfflineFallback(request) {
  const url = new URL(request.url);
  const pathname = url.pathname;
  
  // Return appropriate offline pages
  if (request.headers.get('accept').includes('text/html')) {
    if (isTemplateResource(pathname)) {
      return await caches.match('/templates/offline.html') || 
             await caches.match('/offline.html');
    }
    
    if (isContentResource(pathname)) {
      return await caches.match('/content/offline.html') || 
             await caches.match('/offline.html');
    }
    
    return await caches.match('/offline.html');
  }
  
  // Return offline indicators for other resources
  if (pathname.endsWith('.json')) {
    return new Response('{"offline": true, "message": "Content available offline"}', {
      headers: { 'Content-Type': 'application/json' }
    });
  }
  
  return new Response('Offline', { status: 503 });
}

// Background sync for analytics and progress tracking
self.addEventListener('sync', event => {
  console.log('Service Worker: Background sync triggered', event.tag);
  
  if (event.tag === 'template-usage') {
    event.waitUntil(syncTemplateUsage());
  }
  
  if (event.tag === 'progress-tracking') {
    event.waitUntil(syncProgressData());
  }
  
  if (event.tag === 'content-analytics') {
    event.waitUntil(syncContentAnalytics());
  }
});

async function syncTemplateUsage() {
  try {
    const usageData = await getStoredUsageData();
    if (usageData.length > 0) {
      await fetch('/api/analytics/template-usage', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(usageData)
      });
      await clearStoredUsageData();
    }
  } catch (error) {
    console.error('Failed to sync template usage:', error);
  }
}

async function syncProgressData() {
  try {
    const progressData = await getStoredProgressData();
    if (progressData) {
      await fetch('/api/user/progress', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(progressData)
      });
      await clearStoredProgressData();
    }
  } catch (error) {
    console.error('Failed to sync progress data:', error);
  }
}

async function syncContentAnalytics() {
  try {
    const analyticsData = await getStoredAnalyticsData();
    if (analyticsData.length > 0) {
      await fetch('/api/analytics/content', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(analyticsData)
      });
      await clearStoredAnalyticsData();
    }
  } catch (error) {
    console.error('Failed to sync analytics data:', error);
  }
}

// IndexedDB operations for offline data storage
async function getStoredUsageData() {
  // Implementation for retrieving stored template usage data
  return [];
}

async function clearStoredUsageData() {
  // Implementation for clearing synced usage data
}

async function getStoredProgressData() {
  // Implementation for retrieving stored progress data
  return null;
}

async function clearStoredProgressData() {
  // Implementation for clearing synced progress data
}

async function getStoredAnalyticsData() {
  // Implementation for retrieving stored analytics data
  return [];
}

async function clearStoredAnalyticsData() {
  // Implementation for clearing synced analytics data
}

// Push notification handling
self.addEventListener('push', event => {
  if (!event.data) return;
  
  const data = event.data.json();
  const options = {
    body: data.body,
    icon: '/assets/icons/icon-192x192.png',
    badge: '/assets/icons/badge-72x72.png',
    data: data.data,
    actions: [
      {
        action: 'view',
        title: 'View Content',
        icon: '/assets/icons/view-icon.png'
      },
      {
        action: 'dismiss',
        title: 'Dismiss',
        icon: '/assets/icons/dismiss-icon.png'
      }
    ],
    requireInteraction: true,
    silent: false
  };
  
  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

// Notification click handling
self.addEventListener('notificationclick', event => {
  event.notification.close();
  
  const action = event.action;
  const data = event.notification.data;
  
  if (action === 'view' && data.url) {
    event.waitUntil(
      clients.openWindow(data.url)
    );
  } else if (!action && data.url) {
    event.waitUntil(
      clients.openWindow(data.url)
    );
  }
});

// Message handling for client communication
self.addEventListener('message', event => {
  const { type, payload } = event.data;
  
  switch (type) {
    case 'SKIP_WAITING':
      self.skipWaiting();
      break;
      
    case 'GET_VERSION':
      event.ports[0].postMessage({ version: '1.0' });
      break;
      
    case 'CACHE_CONTENT':
      event.waitUntil(cacheSpecificContent(payload.urls));
      break;
      
    case 'CLEAR_CACHE':
      event.waitUntil(clearSpecificCache(payload.cacheName));
      break;
      
    default:
      console.log('Unknown message type:', type);
  }
});

async function cacheSpecificContent(urls) {
  const cache = await caches.open(DYNAMIC_CACHE);
  try {
    await cache.addAll(urls);
    console.log('Successfully cached specific content');
  } catch (error) {
    console.error('Failed to cache specific content:', error);
  }
}

async function clearSpecificCache(cacheName) {
  try {
    await caches.delete(cacheName);
    console.log('Successfully cleared cache:', cacheName);
  } catch (error) {
    console.error('Failed to clear cache:', error);
  }
}