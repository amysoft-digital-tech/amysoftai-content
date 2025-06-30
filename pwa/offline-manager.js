// Beyond the AI Plateau - Offline Manager
// Comprehensive offline functionality for all content and templates

class OfflineManager {
  constructor() {
    this.isOnline = navigator.onLine;
    this.db = null;
    this.syncQueue = [];
    this.cacheVersion = 'v1';
    
    this.initialize();
  }
  
  async initialize() {
    try {
      await this.setupIndexedDB();
      await this.setupEventListeners();
      await this.initializeContentCache();
      await this.setupPeriodicSync();
      
      console.log('Offline Manager initialized successfully');
    } catch (error) {
      console.error('Failed to initialize Offline Manager:', error);
    }
  }
  
  // IndexedDB setup for offline storage
  async setupIndexedDB() {
    return new Promise((resolve, reject) => {
      const request = indexedDB.open('AIPlateauOffline', 3);
      
      request.onerror = () => reject(request.error);
      request.onsuccess = () => {
        this.db = request.result;
        resolve(this.db);
      };
      
      request.onupgradeneeded = (event) => {
        const db = event.target.result;
        
        // Content storage
        if (!db.objectStoreNames.contains('content')) {
          const contentStore = db.createObjectStore('content', { keyPath: 'id' });
          contentStore.createIndex('type', 'type', { unique: false });
          contentStore.createIndex('tier', 'tier', { unique: false });
          contentStore.createIndex('lastAccessed', 'lastAccessed', { unique: false });
          contentStore.createIndex('offline', 'offline', { unique: false });
        }
        
        // Template storage
        if (!db.objectStoreNames.contains('templates')) {
          const templateStore = db.createObjectStore('templates', { keyPath: 'id' });
          templateStore.createIndex('category', 'category', { unique: false });
          templateStore.createIndex('tier', 'tier', { unique: false });
          templateStore.createIndex('effectiveness', 'effectiveness', { unique: false });
        }
        
        // User progress storage
        if (!db.objectStoreNames.contains('progress')) {
          const progressStore = db.createObjectStore('progress', { keyPath: 'contentId' });
          progressStore.createIndex('userId', 'userId', { unique: false });
          progressStore.createIndex('lastUpdated', 'lastUpdated', { unique: false });
        }
        
        // Assessment data storage
        if (!db.objectStoreNames.contains('assessments')) {
          const assessmentStore = db.createObjectStore('assessments', { keyPath: 'id' });
          assessmentStore.createIndex('type', 'type', { unique: false });
          assessmentStore.createIndex('completed', 'completed', { unique: false });
        }
        
        // Analytics queue
        if (!db.objectStoreNames.contains('analytics')) {
          const analyticsStore = db.createObjectStore('analytics', { 
            keyPath: 'id', 
            autoIncrement: true 
          });
          analyticsStore.createIndex('timestamp', 'timestamp', { unique: false });
          analyticsStore.createIndex('synced', 'synced', { unique: false });
        }
        
        // User preferences
        if (!db.objectStoreNames.contains('preferences')) {
          const prefsStore = db.createObjectStore('preferences', { keyPath: 'key' });
        }
      };
    });
  }
  
  // Event listeners for online/offline state
  setupEventListeners() {
    window.addEventListener('online', () => {
      this.isOnline = true;
      this.onOnline();
    });
    
    window.addEventListener('offline', () => {
      this.isOnline = false;
      this.onOffline();
    });
    
    // Page visibility for sync opportunities
    document.addEventListener('visibilitychange', () => {
      if (!document.hidden && this.isOnline) {
        this.syncPendingData();
      }
    });
  }
  
  // Initialize content cache with critical resources
  async initializeContentCache() {
    const criticalContent = [
      // Foundation content
      { id: 'ch02-framework', type: 'chapter', tier: 'foundation', priority: 'critical' },
      { id: 'ch03-context-mastery', type: 'chapter', tier: 'foundation', priority: 'high' },
      { id: 'ch04-dynamic-planning', type: 'chapter', tier: 'foundation', priority: 'high' },
      
      // Essential templates
      { id: 'CM-001', type: 'template', category: 'context-mastery', priority: 'critical' },
      { id: 'DP-F-002', type: 'template', category: 'dynamic-planning', priority: 'high' },
      { id: 'CE-F-001', type: 'template', category: 'code-evolution', priority: 'high' }
    ];
    
    for (const content of criticalContent) {
      await this.cacheContentItem(content);
    }
  }
  
  // Cache individual content items
  async cacheContentItem(contentMeta) {
    try {
      // Construct URL based on content type
      let url;
      if (contentMeta.type === 'chapter') {
        url = `/content/principles/${contentMeta.id}/index.md`;
      } else if (contentMeta.type === 'template') {
        url = `/templates/${contentMeta.category}/${contentMeta.id}.md`;
      }
      
      // Check if already cached
      const existing = await this.getOfflineContent(contentMeta.id);
      if (existing && this.isCacheValid(existing)) {
        return existing;
      }
      
      // Fetch content
      const response = await fetch(url);
      if (!response.ok) throw new Error(`Failed to fetch ${url}`);
      
      const content = await response.text();
      
      // Store in IndexedDB
      const contentData = {
        id: contentMeta.id,
        type: contentMeta.type,
        tier: contentMeta.tier,
        category: contentMeta.category,
        content: content,
        metadata: contentMeta,
        cachedAt: new Date(),
        lastAccessed: new Date(),
        offline: true,
        version: this.cacheVersion
      };
      
      await this.storeContent(contentData);
      return contentData;
      
    } catch (error) {
      console.error(`Failed to cache content ${contentMeta.id}:`, error);
      return null;
    }
  }
  
  // Store content in IndexedDB
  async storeContent(contentData) {
    const transaction = this.db.transaction(['content'], 'readwrite');
    const store = transaction.objectStore('content');
    await store.put(contentData);
  }
  
  // Retrieve offline content
  async getOfflineContent(contentId) {
    const transaction = this.db.transaction(['content'], 'readonly');
    const store = transaction.objectStore('content');
    
    return new Promise((resolve, reject) => {
      const request = store.get(contentId);
      request.onsuccess = () => {
        const result = request.result;
        if (result) {
          // Update last accessed
          result.lastAccessed = new Date();
          this.storeContent(result);
        }
        resolve(result);
      };
      request.onerror = () => reject(request.error);
    });
  }
  
  // Check if cached content is still valid
  isCacheValid(cachedContent) {
    const cacheAge = Date.now() - new Date(cachedContent.cachedAt).getTime();
    const maxAge = 24 * 60 * 60 * 1000; // 24 hours
    
    return cacheAge < maxAge && cachedContent.version === this.cacheVersion;
  }
  
  // Template-specific offline functionality
  async cacheTemplate(templateId, templateData) {
    const template = {
      id: templateId,
      category: templateData.category,
      tier: templateData.tier,
      title: templateData.title,
      content: templateData.content,
      metadata: templateData.metadata,
      effectiveness: templateData.effectiveness || {},
      cachedAt: new Date(),
      offline: true
    };
    
    const transaction = this.db.transaction(['templates'], 'readwrite');
    const store = transaction.objectStore('templates');
    await store.put(template);
  }
  
  async getOfflineTemplate(templateId) {
    const transaction = this.db.transaction(['templates'], 'readonly');
    const store = transaction.objectStore('templates');
    
    return new Promise((resolve, reject) => {
      const request = store.get(templateId);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }
  
  async searchOfflineTemplates(query, filters = {}) {
    const transaction = this.db.transaction(['templates'], 'readonly');
    const store = transaction.objectStore('templates');
    
    return new Promise((resolve, reject) => {
      const request = store.getAll();
      request.onsuccess = () => {
        let templates = request.result;
        
        // Apply text search
        if (query) {
          const queryLower = query.toLowerCase();
          templates = templates.filter(template => 
            template.title.toLowerCase().includes(queryLower) ||
            template.content.toLowerCase().includes(queryLower) ||
            (template.metadata.search_optimization || []).some(tag => 
              tag.toLowerCase().includes(queryLower))
          );
        }
        
        // Apply filters
        if (filters.category) {
          templates = templates.filter(t => t.category === filters.category);
        }
        if (filters.tier) {
          templates = templates.filter(t => t.tier === filters.tier);
        }
        
        resolve(templates);
      };
      request.onerror = () => reject(request.error);
    });
  }
  
  // Progress tracking offline
  async saveProgress(contentId, progressData) {
    const progress = {
      contentId,
      userId: await this.getUserId(),
      percentage: progressData.percentage,
      timeSpent: progressData.timeSpent,
      milestones: progressData.milestones || [],
      lastUpdated: new Date(),
      synced: this.isOnline
    };
    
    const transaction = this.db.transaction(['progress'], 'readwrite');
    const store = transaction.objectStore('progress');
    await store.put(progress);
    
    // Queue for sync if offline
    if (!this.isOnline) {
      this.queueForSync('progress', progress);
    } else {
      await this.syncProgress(progress);
    }
  }
  
  async getProgress(contentId) {
    const transaction = this.db.transaction(['progress'], 'readonly');
    const store = transaction.objectStore('progress');
    
    return new Promise((resolve, reject) => {
      const request = store.get(contentId);
      request.onsuccess = () => resolve(request.result);
      request.onerror = () => reject(request.error);
    });
  }
  
  // Assessment offline functionality
  async saveAssessmentResponse(assessmentId, responseData) {
    const assessment = {
      id: `${assessmentId}-${Date.now()}`,
      assessmentId,
      responses: responseData.responses,
      startedAt: responseData.startedAt,
      completedAt: responseData.completedAt,
      results: responseData.results,
      synced: this.isOnline
    };
    
    const transaction = this.db.transaction(['assessments'], 'readwrite');
    const store = transaction.objectStore('assessments');
    await store.put(assessment);
    
    if (!this.isOnline) {
      this.queueForSync('assessment', assessment);
    } else {
      await this.syncAssessment(assessment);
    }
  }
  
  // Analytics tracking offline
  async trackEvent(eventType, eventData) {
    const analytics = {
      type: eventType,
      data: eventData,
      timestamp: new Date(),
      userAgent: navigator.userAgent,
      url: window.location.href,
      online: this.isOnline,
      synced: false
    };
    
    const transaction = this.db.transaction(['analytics'], 'readwrite');
    const store = transaction.objectStore('analytics');
    await store.add(analytics);
    
    // Queue for sync
    this.queueForSync('analytics', analytics);
  }
  
  // Sync queue management
  queueForSync(type, data) {
    this.syncQueue.push({ type, data, timestamp: new Date() });
  }
  
  // Online event handler
  async onOnline() {
    console.log('Connection restored - syncing data...');
    
    try {
      await this.syncPendingData();
      await this.updateCachedContent();
      this.showSyncNotification('Data synchronized successfully');
    } catch (error) {
      console.error('Sync failed:', error);
      this.showSyncNotification('Sync failed - will retry later', 'error');
    }
  }
  
  // Offline event handler
  onOffline() {
    console.log('Connection lost - enabling offline mode');
    this.showOfflineNotification();
  }
  
  // Sync pending data when online
  async syncPendingData() {
    if (!this.isOnline || this.syncQueue.length === 0) return;
    
    const toSync = [...this.syncQueue];
    this.syncQueue = [];
    
    for (const item of toSync) {
      try {
        await this.syncItem(item);
      } catch (error) {
        console.error('Failed to sync item:', error);
        // Re-queue failed items
        this.syncQueue.push(item);
      }
    }
    
    // Also sync unsynchronized data from IndexedDB
    await this.syncUnsynedAnalytics();
    await this.syncUnsynedProgress();
    await this.syncUnsynedAssessments();
  }
  
  async syncItem(item) {
    switch (item.type) {
      case 'progress':
        return this.syncProgress(item.data);
      case 'assessment':
        return this.syncAssessment(item.data);
      case 'analytics':
        return this.syncAnalytics(item.data);
      default:
        console.warn('Unknown sync item type:', item.type);
    }
  }
  
  async syncProgress(progressData) {
    await fetch('/api/user/progress', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(progressData)
    });
    
    // Mark as synced
    progressData.synced = true;
    const transaction = this.db.transaction(['progress'], 'readwrite');
    const store = transaction.objectStore('progress');
    await store.put(progressData);
  }
  
  async syncAssessment(assessmentData) {
    await fetch('/api/assessments/results', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(assessmentData)
    });
    
    assessmentData.synced = true;
    const transaction = this.db.transaction(['assessments'], 'readwrite');
    const store = transaction.objectStore('assessments');
    await store.put(assessmentData);
  }
  
  async syncAnalytics(analyticsData) {
    await fetch('/api/analytics/events', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(analyticsData)
    });
    
    analyticsData.synced = true;
    const transaction = this.db.transaction(['analytics'], 'readwrite');
    const store = transaction.objectStore('analytics');
    await store.put(analyticsData);
  }
  
  // Periodic sync setup
  async setupPeriodicSync() {
    if ('serviceWorker' in navigator && 'sync' in window.ServiceWorkerRegistration.prototype) {
      const registration = await navigator.serviceWorker.ready;
      
      // Register periodic sync
      try {
        await registration.sync.register('periodic-sync');
      } catch (error) {
        console.log('Periodic sync not supported, using fallback');
        this.setupFallbackSync();
      }
    }
  }
  
  setupFallbackSync() {
    // Fallback sync every 5 minutes when online
    setInterval(() => {
      if (this.isOnline && this.syncQueue.length > 0) {
        this.syncPendingData();
      }
    }, 5 * 60 * 1000);
  }
  
  // Utility methods
  async getUserId() {
    // Get or generate user ID for offline tracking
    let userId = localStorage.getItem('offline-user-id');
    if (!userId) {
      userId = 'offline-' + Math.random().toString(36).substr(2, 9);
      localStorage.setItem('offline-user-id', userId);
    }
    return userId;
  }
  
  showOfflineNotification() {
    if ('Notification' in window && Notification.permission === 'granted') {
      new Notification('Offline Mode Active', {
        body: 'You can continue using templates and content offline. Changes will sync when online.',
        icon: '/assets/icons/offline-icon.png'
      });
    }
  }
  
  showSyncNotification(message, type = 'success') {
    if ('Notification' in window && Notification.permission === 'granted') {
      new Notification(type === 'success' ? 'Sync Complete' : 'Sync Failed', {
        body: message,
        icon: `/assets/icons/${type}-icon.png`
      });
    }
  }
  
  // Content management
  async preloadCriticalContent() {
    const criticalContent = await this.getCriticalContentList();
    
    for (const content of criticalContent) {
      await this.cacheContentItem(content);
    }
  }
  
  async getCriticalContentList() {
    // Return list of critical content for offline access
    return [
      { id: 'ch02-framework', type: 'chapter', tier: 'foundation' },
      { id: 'ch03-context-mastery', type: 'chapter', tier: 'foundation' },
      { id: 'CM-001', type: 'template', category: 'context-mastery' },
      { id: 'DP-F-002', type: 'template', category: 'dynamic-planning' }
    ];
  }
  
  // Cleanup old cached content
  async cleanupOldCache() {
    const cutoffDate = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000); // 7 days
    
    const transaction = this.db.transaction(['content'], 'readwrite');
    const store = transaction.objectStore('content');
    const index = store.index('lastAccessed');
    
    const request = index.openCursor(IDBKeyRange.upperBound(cutoffDate));
    
    request.onsuccess = (event) => {
      const cursor = event.target.result;
      if (cursor) {
        const content = cursor.value;
        if (content.metadata.priority !== 'critical') {
          cursor.delete();
        }
        cursor.continue();
      }
    };
  }
  
  // Export/import for backup
  async exportOfflineData() {
    const data = {
      content: await this.getAllStoredContent(),
      templates: await this.getAllStoredTemplates(),
      progress: await this.getAllProgress(),
      preferences: await this.getAllPreferences(),
      exportedAt: new Date()
    };
    
    return JSON.stringify(data);
  }
  
  async importOfflineData(dataString) {
    try {
      const data = JSON.parse(dataString);
      
      // Import each data type
      await this.importContent(data.content);
      await this.importTemplates(data.templates);
      await this.importProgress(data.progress);
      await this.importPreferences(data.preferences);
      
      return true;
    } catch (error) {
      console.error('Failed to import offline data:', error);
      return false;
    }
  }
}

// Initialize offline manager when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  window.offlineManager = new OfflineManager();
});

// Export for module use
if (typeof module !== 'undefined' && module.exports) {
  module.exports = OfflineManager;
}