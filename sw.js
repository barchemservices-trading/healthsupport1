/**
 * VITALIS HEALTH SUPPORT - Service Worker
 * Enables offline functionality, asset caching, and PWA installation
 */

const CACHE_NAME = 'vitalis-v2-cache-v1';

const STATIC_ASSETS = [
  './',
  './index.html',
  './style.css',
  './app.js',
  './manifest.webmanifest',
  './icon.svg',
  './icon-192.png',
  './icon-512.png',
  './icon-maskable.png',
  './apple-touch-icon.png'
];

// Install Event: Pre-cache local assets
self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log('[Vitalis SW] Caching app shell assets');
      return cache.addAll(STATIC_ASSETS);
    }).then(() => self.skipWaiting())
  );
});

// Activate Event: Clean up legacy caches & take immediate control
self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((name) => {
          if (name !== CACHE_NAME) {
            console.log('[Vitalis SW] Clearing outdated cache:', name);
            return caches.delete(name);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// Fetch Event: Cache-First / Stale-While-Revalidate with full offline fallback
self.addEventListener('fetch', (event) => {
  const req = event.request;
  const url = new URL(req.url);

  // Skip non-GET requests
  if (req.method !== 'GET') return;

  // Handle local same-origin assets
  if (url.origin === self.location.origin) {
    event.respondWith(
      caches.match(req).then((cachedResponse) => {
        // Fetch from network to update cache in background
        const fetchPromise = fetch(req).then((networkResponse) => {
          if (networkResponse && networkResponse.status === 200) {
            const clone = networkResponse.clone();
            caches.open(CACHE_NAME).then((cache) => cache.put(req, clone));
          }
          return networkResponse;
        }).catch(() => {
          // If offline and request is HTML navigation, fallback to index.html
          if (req.mode === 'navigate') {
            return caches.match('./index.html');
          }
        });

        // Return cached version immediately if available, otherwise wait for network
        return cachedResponse || fetchPromise;
      })
    );
    return;
  }

  // Handle external assets like Google Fonts
  if (url.hostname.includes('googleapis.com') || url.hostname.includes('gstatic.com')) {
    event.respondWith(
      caches.match(req).then((cachedResponse) => {
        if (cachedResponse) return cachedResponse;
        return fetch(req).then((networkResponse) => {
          if (networkResponse && networkResponse.status === 200) {
            const clone = networkResponse.clone();
            caches.open(CACHE_NAME).then((cache) => cache.put(req, clone));
          }
          return networkResponse;
        }).catch(() => cachedResponse);
      })
    );
  }
});
