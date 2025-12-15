// Service Worker for Tutorx Course Application
// Provides advanced caching and offline capabilities

const CACHE_NAME = 'tutorx-course-v1';
const STATIC_CACHE_NAME = 'tutorx-static-v1';
const DYNAMIC_CACHE_NAME = 'tutorx-dynamic-v1';

// Files to cache for offline use
const STATIC_ASSETS = [
  '/',
  '/login',
  '/signup',
  '/about',
  'https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap',
  'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css',
  'https://unpkg.com/aos@2.3.1/dist/aos.css',
  'https://unpkg.com/aos@2.3.1/dist/aos.js'
];

// Install event - cache static assets
self.addEventListener('install', event => {
  console.log('Service Worker: Installing...');
  
  event.waitUntil(
    caches.open(STATIC_CACHE_NAME)
      .then(cache => {
        console.log('Service Worker: Caching static assets');
        return cache.addAll(STATIC_ASSETS);
      })
      .then(() => {
        console.log('Service Worker: Installation complete');
        return self.skipWaiting();
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
  console.log('Service Worker: Activating...');
  
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName !== STATIC_CACHE_NAME && 
                cacheName !== DYNAMIC_CACHE_NAME && 
                cacheName !== CACHE_NAME) {
              console.log('Service Worker: Deleting old cache:', cacheName);
              return caches.delete(cacheName);
            }
          })
        );
      })
      .then(() => {
        console.log('Service Worker: Activation complete');
        return self.clients.claim();
      })
  );
});

// Fetch event - serve from cache when offline
self.addEventListener('fetch', event => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Skip external requests (except for allowed CDNs)
  if (url.origin !== location.origin && 
      !url.origin.includes('fonts.googleapis.com') && 
      !url.origin.includes('cdnjs.cloudflare.com') && 
      !url.origin.includes('unpkg.com')) {
    return;
  }

  event.respondWith(
    caches.match(request)
      .then(response => {
        // Return cached version if available
        if (response) {
          return response;
        }

        // Otherwise, fetch from network
        return fetch(request)
          .then(response => {
            // Don't cache non-successful responses
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }

            // Clone the response for caching
            const responseToCache = response.clone();

            // Cache dynamic content
            if (shouldCacheDynamic(request)) {
              caches.open(DYNAMIC_CACHE_NAME)
                .then(cache => {
                  cache.put(request, responseToCache);
                });
            }

            return response;
          })
          .catch(() => {
            // Fallback for offline scenarios
            return getOfflineFallback(request);
          });
      })
  );
});

// Determine if request should be cached dynamically
function shouldCacheDynamic(request) {
  const url = new URL(request.url);
  
  // Cache API responses
  if (url.pathname.startsWith('/api/')) {
    return true;
  }
  
  // Cache pages
  if (request.headers.get('accept').includes('text/html')) {
    return true;
  }
  
  // Cache images
  if (request.headers.get('accept').includes('image/')) {
    return true;
  }
  
  return false;
}

// Provide offline fallbacks
function getOfflineFallback(request) {
  const url = new URL(request.url);
  
  // Fallback for HTML pages
  if (request.headers.get('accept').includes('text/html')) {
    return caches.match('/');
  }
  
  // Fallback for images
  if (request.headers.get('accept').includes('image/')) {
    return new Response('Offline - Image not available', {
      status: 404,
      statusText: 'Offline'
    });
  }
  
  // Default fallback
  return new Response('Offline - Content not available', {
    status: 503,
    statusText: 'Service Unavailable'
  });
}

// Background sync for offline actions
self.addEventListener('sync', event => {
  if (event.tag === 'background-sync') {
    console.log('Service Worker: Background sync triggered');
    event.waitUntil(doBackgroundSync());
  }
});

// Background sync implementation
function doBackgroundSync() {
  // Sync any queued requests when back online
  return self.registration.showNotification('Tutorx Course', {
    body: 'Your data has been synced!',
    icon: '/favicon.ico'
  });
}

// Push notification handling
self.addEventListener('push', event => {
  const data = event.data.json();
  
  const options = {
    body: data.body,
    icon: '/favicon.ico',
    badge: '/favicon.ico',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      {
        action: 'explore',
        title: 'Explore',
        icon: '/favicon.ico'
      },
      {
        action: 'close',
        title: 'Close',
        icon: '/favicon.ico'
      }
    ]
  };

  event.waitUntil(
    self.registration.showNotification(data.title, options)
  );
});

// Notification click handling
self.addEventListener('notificationclick', event => {
  event.notification.close();

  if (event.action === 'explore') {
    event.waitUntil(
      clients.openWindow('/')
    );
  }
});

// Message handling from main thread
self.addEventListener('message', event => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});

// Cache cleanup on storage quota
self.addEventListener('quotaexceeded', event => {
  console.log('Service Worker: Storage quota exceeded');
  
  event.waitUntil(
    caches.keys()
      .then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => {
            if (cacheName === DYNAMIC_CACHE_NAME) {
              return caches.open(cacheName)
                .then(cache => {
                  return cache.keys()
                    .then(keys => {
                      // Delete oldest entries
                      if (keys.length > 50) {
                        return Promise.all(
                          keys.slice(0, 10).map(key => cache.delete(key))
                        );
                      }
                    });
                });
            }
          })
        );
      })
  );
});
