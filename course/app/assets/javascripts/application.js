// Performance optimizations for Tutorx Course Application

// Lazy loading for images
document.addEventListener('DOMContentLoaded', function() {
  // Lazy load images
  const lazyImages = document.querySelectorAll('img[data-src]');
  
  const imageObserver = new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        const img = entry.target;
        img.src = img.dataset.src;
        img.classList.remove('lazy');
        imageObserver.unobserve(img);
      }
    });
  });

  lazyImages.forEach(img => imageObserver.observe(img));

  // Preload critical resources
  preloadCriticalResources();

  // Optimize animations
  optimizeAnimations();

  // Initialize performance monitoring
  initializePerformanceMonitoring();
});

// Preload critical resources
function preloadCriticalResources() {
  const criticalResources = [
    'https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap',
    'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css'
  ];

  criticalResources.forEach(url => {
    const link = document.createElement('link');
    link.rel = 'preload';
    link.as = 'style';
    link.href = url;
    link.onload = function() {
      this.rel = 'stylesheet';
    };
    document.head.appendChild(link);
  });
}

// Optimize animations for better performance
function optimizeAnimations() {
  // Debounce scroll events
  let scrollTimeout;
  window.addEventListener('scroll', function() {
    if (scrollTimeout) {
      window.cancelAnimationFrame(scrollTimeout);
    }
    scrollTimeout = window.requestAnimationFrame(function() {
      handleScroll();
    });
  });

  // Optimize AOS animations
  if (typeof AOS !== 'undefined') {
    AOS.init({
      duration: 600,
      easing: 'ease-in-out',
      once: true,
      offset: 100,
      disable: 'mobile'
    });
  }
}

// Handle scroll events efficiently
function handleScroll() {
  // Add scroll-based optimizations here
  const scrolled = window.pageYOffset;
  
  // Example: Hide/show elements based on scroll
  const header = document.querySelector('header');
  if (header) {
    if (scrolled > 100) {
      header.classList.add('scrolled');
    } else {
      header.classList.remove('scrolled');
    }
  }
}

// Performance monitoring
function initializePerformanceMonitoring() {
  // Monitor page load time
  window.addEventListener('load', function() {
    const loadTime = performance.now();
    console.log(`Page loaded in ${loadTime.toFixed(2)}ms`);
    
    // Send performance data to analytics if needed
    if (typeof gtag !== 'undefined') {
      gtag('event', 'page_load_time', {
        'value': loadTime,
        'event_category': 'performance'
      });
    }
  });

  // Monitor Core Web Vitals
  if ('PerformanceObserver' in window) {
    // Largest Contentful Paint
    const lcpObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      const lastEntry = entries[entries.length - 1];
      console.log('LCP:', lastEntry.renderTime || lastEntry.loadTime);
    });
    lcpObserver.observe({ entryTypes: ['largest-contentful-paint'] });

    // First Input Delay
    const fidObserver = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      entries.forEach(entry => {
        console.log('FID:', entry.processingStart - entry.startTime);
      });
    });
    fidObserver.observe({ entryTypes: ['first-input'] });

    // Cumulative Layout Shift
    let clsValue = 0;
    const clsObserver = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (!entry.hadRecentInput) {
          clsValue += entry.value;
        }
      }
      console.log('CLS:', clsValue);
    });
    clsObserver.observe({ entryTypes: ['layout-shift'] });
  }
}

// Debounce function for performance
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Throttle function for performance
function throttle(func, limit) {
  let inThrottle;
  return function(...args) {
    if (!inThrottle) {
      func.apply(this, args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
}

// Optimized resize handler
const optimizedResize = debounce(function() {
  // Handle resize events
  console.log('Window resized');
}, 250);

window.addEventListener('resize', optimizedResize);

// Service Worker registration for caching (if available)
if ('serviceWorker' in navigator) {
  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/service-worker.js')
      .then(function(registration) {
        console.log('ServiceWorker registration successful');
      })
      .catch(function(error) {
        console.log('ServiceWorker registration failed');
      });
  });
}

// Reduce JavaScript execution time
function optimizeJavaScript() {
  // Use requestIdleCallback for non-critical tasks
  if ('requestIdleCallback' in window) {
    requestIdleCallback(() => {
      // Perform non-critical tasks here
      console.log('Performing non-critical tasks during idle time');
    });
  }
}

// Initialize optimizations
optimizeJavaScript();

// Export functions for global use
window.TutorxPerformance = {
  debounce,
  throttle,
  preloadCriticalResources,
  optimizeAnimations
};
