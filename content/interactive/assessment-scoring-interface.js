/**
 * AI Development Maturity Assessment - Interactive Scoring Interface
 * PWA-compatible offline assessment tool with progress tracking
 */

class AIMaturityAssessment {
  constructor() {
    this.responses = {};
    this.currentQuestion = 1;
    this.totalQuestions = 15;
    this.isOffline = !navigator.onLine;
    this.startTime = new Date();
    
    this.initializeAssessment();
    this.setupEventListeners();
    this.loadSavedProgress();
  }

  initializeAssessment() {
    this.assessmentData = {
      contextMastery: { questions: [1, 2, 3], score: 0 },
      dynamicPlanning: { questions: [4, 5, 6], score: 0 },
      codeEvolution: { questions: [7, 8, 9], score: 0 },
      strategicTesting: { questions: [10, 11, 12], score: 0 },
      intelligentReview: { questions: [13, 14, 15], score: 0 }
    };

    this.maturityLevels = [
      { min: 65, max: 75, level: 'AI Elite Practitioner', emoji: '🏆', description: 'Complete AI partnership mastery with compound effects' },
      { min: 52, max: 64, level: 'AI-Optimized Developer', emoji: '⭐', description: 'Strong systematic AI integration across most areas' },
      { min: 39, max: 51, level: 'AI-Enhanced Developer', emoji: '📈', description: 'Good AI integration with systematic improvement needed' },
      { min: 26, max: 38, level: 'AI-Aware Developer', emoji: '🌱', description: 'Basic capabilities with significant growth opportunity' },
      { min: 15, max: 25, level: 'Traditional Developer', emoji: '🚀', description: 'Beginning of AI development journey' }
    ];
  }

  setupEventListeners() {
    // Online/offline status monitoring
    window.addEventListener('online', () => {
      this.isOffline = false;
      this.syncProgress();
      this.updateConnectionStatus();
    });

    window.addEventListener('offline', () => {
      this.isOffline = true;
      this.updateConnectionStatus();
    });

    // Auto-save on response changes
    document.addEventListener('change', (e) => {
      if (e.target.matches('input[name^="q"]')) {
        this.saveResponse(e.target);
        this.autoSaveProgress();
      }
    });

    // Navigation controls
    document.addEventListener('click', (e) => {
      if (e.target.matches('.next-question')) {
        this.nextQuestion();
      }
      if (e.target.matches('.prev-question')) {
        this.previousQuestion();
      }
      if (e.target.matches('.complete-assessment')) {
        this.completeAssessment();
      }
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', (e) => {
      if (e.altKey && e.key === 'n') {
        e.preventDefault();
        this.nextQuestion();
      }
      if (e.altKey && e.key === 'p') {
        e.preventDefault();
        this.previousQuestion();
      }
      if (e.altKey && e.key === 's') {
        e.preventDefault();
        this.autoSaveProgress();
      }
    });
  }

  saveResponse(input) {
    const questionNumber = parseInt(input.name.replace('q', ''));
    const value = parseInt(input.value);
    
    this.responses[questionNumber] = {
      value: value,
      timestamp: new Date(),
      question: questionNumber
    };

    this.updateProgress();
    this.updateNavigationState();
  }

  updateProgress() {
    const completedQuestions = Object.keys(this.responses).length;
    const progressPercentage = (completedQuestions / this.totalQuestions) * 100;
    
    // Update progress bar
    const progressBar = document.querySelector('.progress-bar-fill');
    if (progressBar) {
      progressBar.style.width = `${progressPercentage}%`;
    }

    // Update progress text
    const progressText = document.querySelector('.progress-text');
    if (progressText) {
      progressText.textContent = `${completedQuestions} of ${this.totalQuestions} questions completed`;
    }

    // Update estimated time remaining
    this.updateTimeEstimate();
  }

  updateTimeEstimate() {
    const completedQuestions = Object.keys(this.responses).length;
    if (completedQuestions === 0) return;

    const elapsedTime = (new Date() - this.startTime) / 1000 / 60; // minutes
    const averageTimePerQuestion = elapsedTime / completedQuestions;
    const remainingQuestions = this.totalQuestions - completedQuestions;
    const estimatedTimeRemaining = Math.ceil(averageTimePerQuestion * remainingQuestions);

    const timeEstimate = document.querySelector('.time-estimate');
    if (timeEstimate && estimatedTimeRemaining > 0) {
      timeEstimate.textContent = `Estimated time remaining: ${estimatedTimeRemaining} minute${estimatedTimeRemaining !== 1 ? 's' : ''}`;
    }
  }

  calculateScores() {
    const scores = {
      contextMastery: 0,
      dynamicPlanning: 0,
      codeEvolution: 0,
      strategicTesting: 0,
      intelligentReview: 0,
      totalScore: 0
    };

    // Calculate principle-specific scores
    Object.entries(this.assessmentData).forEach(([principle, data]) => {
      data.questions.forEach(questionNum => {
        if (this.responses[questionNum]) {
          scores[principle] += this.responses[questionNum].value;
        }
      });
    });

    // Calculate total score
    scores.totalScore = Object.values(scores).reduce((sum, score) => {
      return sum + (typeof score === 'number' ? score : 0);
    }, 0);

    return scores;
  }

  determineMaturityLevel(totalScore) {
    return this.maturityLevels.find(level => 
      totalScore >= level.min && totalScore <= level.max
    ) || this.maturityLevels[this.maturityLevels.length - 1];
  }

  generateResults() {
    const scores = this.calculateScores();
    const maturityLevel = this.determineMaturityLevel(scores.totalScore);
    const completionTime = Math.round((new Date() - this.startTime) / 1000 / 60);

    const results = {
      scores: scores,
      maturityLevel: maturityLevel,
      completionTime: completionTime,
      completedAt: new Date(),
      strengths: this.identifyStrengths(scores),
      improvementAreas: this.identifyImprovementAreas(scores),
      recommendations: this.generateRecommendations(scores, maturityLevel),
      nextSteps: this.generateNextSteps(maturityLevel)
    };

    return results;
  }

  identifyStrengths(scores) {
    const principleScores = [
      { name: 'Context Mastery', score: scores.contextMastery, max: 15 },
      { name: 'Dynamic Planning', score: scores.dynamicPlanning, max: 15 },
      { name: 'Code Evolution', score: scores.codeEvolution, max: 15 },
      { name: 'Strategic Testing', score: scores.strategicTesting, max: 15 },
      { name: 'Intelligent Review', score: scores.intelligentReview, max: 15 }
    ];

    return principleScores
      .map(p => ({ ...p, percentage: (p.score / p.max) * 100 }))
      .filter(p => p.percentage >= 70)
      .sort((a, b) => b.percentage - a.percentage)
      .slice(0, 3);
  }

  identifyImprovementAreas(scores) {
    const principleScores = [
      { name: 'Context Mastery', score: scores.contextMastery, max: 15 },
      { name: 'Dynamic Planning', score: scores.dynamicPlanning, max: 15 },
      { name: 'Code Evolution', score: scores.codeEvolution, max: 15 },
      { name: 'Strategic Testing', score: scores.strategicTesting, max: 15 },
      { name: 'Intelligent Review', score: scores.intelligentReview, max: 15 }
    ];

    return principleScores
      .map(p => ({ ...p, percentage: (p.score / p.max) * 100 }))
      .filter(p => p.percentage < 70)
      .sort((a, b) => a.percentage - b.percentage)
      .slice(0, 3);
  }

  generateRecommendations(scores, maturityLevel) {
    const recommendations = {
      immediate: [],
      shortTerm: [],
      longTerm: []
    };

    // Level-specific recommendations
    switch (maturityLevel.level) {
      case 'Traditional Developer':
        recommendations.immediate.push('Start with Context Mastery fundamentals - create your first CLAUDE.md file');
        recommendations.immediate.push('Complete the Context Mastery templates in Chapter 3');
        recommendations.shortTerm.push('Establish consistent AI tool usage patterns');
        recommendations.longTerm.push('Build systematic AI integration across all development activities');
        break;

      case 'AI-Aware Developer':
        recommendations.immediate.push('Focus on systematic Context Mastery implementation');
        recommendations.immediate.push('Begin Dynamic Planning integration for current projects');
        recommendations.shortTerm.push('Develop consistent AI workflow patterns');
        recommendations.longTerm.push('Achieve measurable productivity improvements across all principles');
        break;

      case 'AI-Enhanced Developer':
        recommendations.immediate.push('Identify and address principle gaps from assessment results');
        recommendations.immediate.push('Begin exploring compound effects between principles');
        recommendations.shortTerm.push('Systematize successful practices across all development');
        recommendations.longTerm.push('Achieve AI-Optimized Developer level through consistent application');
        break;

      case 'AI-Optimized Developer':
        recommendations.immediate.push('Focus on achieving compound effects between principles');
        recommendations.immediate.push('Begin mentoring others in AI development practices');
        recommendations.shortTerm.push('Optimize team collaboration through AI-enhanced workflows');
        recommendations.longTerm.push('Develop elite-level AI partnership and innovation capabilities');
        break;

      case 'AI Elite Practitioner':
        recommendations.immediate.push('Lead organizational AI transformation initiatives');
        recommendations.immediate.push('Contribute to AI development best practices');
        recommendations.shortTerm.push('Explore cutting-edge AI capabilities and techniques');
        recommendations.longTerm.push('Develop and share advanced AI partnership methodologies');
        break;
    }

    return recommendations;
  }

  generateNextSteps(maturityLevel) {
    const nextSteps = [
      'Review your detailed assessment results and principle-specific scores',
      'Download your personalized 12-week transformation roadmap',
      'Begin with the highest-impact quick wins identified for your level',
      'Schedule weekly progress check-ins and mini-assessments',
      'Start reading the chapter most relevant to your primary improvement area'
    ];

    return nextSteps;
  }

  displayResults(results) {
    const resultsContainer = document.getElementById('assessment-results');
    if (!resultsContainer) return;

    resultsContainer.innerHTML = this.generateResultsHTML(results);
    
    // Initialize result visualizations
    this.createRadarChart(results.scores);
    this.createProgressBars(results.scores);
    
    // Show results section
    resultsContainer.style.display = 'block';
    resultsContainer.scrollIntoView({ behavior: 'smooth' });
  }

  generateResultsHTML(results) {
    return `
      <div class="assessment-results-container">
        <div class="results-header">
          <h2>${results.maturityLevel.emoji} Your AI Development Maturity Level</h2>
          <div class="maturity-level">
            <h3>${results.maturityLevel.level}</h3>
            <p>${results.maturityLevel.description}</p>
            <div class="score-summary">
              <span class="total-score">${results.scores.totalScore}/75 points</span>
              <span class="completion-time">Completed in ${results.completionTime} minutes</span>
            </div>
          </div>
        </div>

        <div class="results-visualization">
          <div class="radar-chart-container">
            <h4>Principle Strengths Overview</h4>
            <canvas id="radar-chart"></canvas>
          </div>
          
          <div class="progress-bars-container">
            <h4>Detailed Principle Scores</h4>
            <div id="principle-progress-bars"></div>
          </div>
        </div>

        <div class="results-analysis">
          <div class="strengths-section">
            <h4>🎯 Your Strengths</h4>
            <ul>
              ${results.strengths.map(strength => 
                `<li><strong>${strength.name}</strong>: ${strength.score}/15 (${Math.round(strength.percentage)}%)</li>`
              ).join('')}
            </ul>
          </div>

          <div class="improvement-areas-section">
            <h4>📈 Growth Opportunities</h4>
            <ul>
              ${results.improvementAreas.map(area => 
                `<li><strong>${area.name}</strong>: ${area.score}/15 (${Math.round(area.percentage)}%) - Focus area</li>`
              ).join('')}
            </ul>
          </div>
        </div>

        <div class="recommendations-section">
          <h4>🚀 Personalized Recommendations</h4>
          
          <div class="recommendation-timeframe">
            <h5>Immediate Actions (Week 1-2)</h5>
            <ul>
              ${results.recommendations.immediate.map(rec => `<li>${rec}</li>`).join('')}
            </ul>
          </div>

          <div class="recommendation-timeframe">
            <h5>Short-term Focus (Month 1-2)</h5>
            <ul>
              ${results.recommendations.shortTerm.map(rec => `<li>${rec}</li>`).join('')}
            </ul>
          </div>

          <div class="recommendation-timeframe">
            <h5>Long-term Development (Month 3-6)</h5>
            <ul>
              ${results.recommendations.longTerm.map(rec => `<li>${rec}</li>`).join('')}
            </ul>
          </div>
        </div>

        <div class="next-steps-section">
          <h4>✅ Your Next Steps</h4>
          <ol>
            ${results.nextSteps.map(step => `<li>${step}</li>`).join('')}
          </ol>
        </div>

        <div class="results-actions">
          <button class="download-action-plan" onclick="aiAssessment.downloadActionPlan()">
            📄 Download Your Personal Action Plan
          </button>
          <button class="save-results" onclick="aiAssessment.saveResults()">
            💾 Save Results for Future Reference
          </button>
          <button class="share-results" onclick="aiAssessment.shareResults()">
            📤 Share Results with Team
          </button>
        </div>
      </div>
    `;
  }

  createRadarChart(scores) {
    // Simplified radar chart implementation for PWA compatibility
    const canvas = document.getElementById('radar-chart');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    const centerX = canvas.width / 2;
    const centerY = canvas.height / 2;
    const radius = Math.min(centerX, centerY) - 20;

    const principles = [
      { name: 'Context\nMastery', score: scores.contextMastery, max: 15 },
      { name: 'Dynamic\nPlanning', score: scores.dynamicPlanning, max: 15 },
      { name: 'Code\nEvolution', score: scores.codeEvolution, max: 15 },
      { name: 'Strategic\nTesting', score: scores.strategicTesting, max: 15 },
      { name: 'Intelligent\nReview', score: scores.intelligentReview, max: 15 }
    ];

    // Clear canvas
    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Draw background grid
    ctx.strokeStyle = '#e0e0e0';
    ctx.lineWidth = 1;
    for (let i = 1; i <= 5; i++) {
      ctx.beginPath();
      ctx.arc(centerX, centerY, (radius * i) / 5, 0, 2 * Math.PI);
      ctx.stroke();
    }

    // Draw principle axes
    principles.forEach((_, index) => {
      const angle = (index * 2 * Math.PI) / 5 - Math.PI / 2;
      ctx.beginPath();
      ctx.moveTo(centerX, centerY);
      ctx.lineTo(
        centerX + radius * Math.cos(angle),
        centerY + radius * Math.sin(angle)
      );
      ctx.stroke();
    });

    // Draw score polygon
    ctx.beginPath();
    ctx.strokeStyle = '#2563eb';
    ctx.fillStyle = 'rgba(37, 99, 235, 0.2)';
    ctx.lineWidth = 2;

    principles.forEach((principle, index) => {
      const angle = (index * 2 * Math.PI) / 5 - Math.PI / 2;
      const scoreRadius = (radius * principle.score) / principle.max;
      const x = centerX + scoreRadius * Math.cos(angle);
      const y = centerY + scoreRadius * Math.sin(angle);

      if (index === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    });

    ctx.closePath();
    ctx.fill();
    ctx.stroke();

    // Draw principle labels
    ctx.fillStyle = '#374151';
    ctx.font = '12px Arial';
    ctx.textAlign = 'center';

    principles.forEach((principle, index) => {
      const angle = (index * 2 * Math.PI) / 5 - Math.PI / 2;
      const labelRadius = radius + 30;
      const x = centerX + labelRadius * Math.cos(angle);
      const y = centerY + labelRadius * Math.sin(angle);

      const lines = principle.name.split('\n');
      lines.forEach((line, lineIndex) => {
        ctx.fillText(line, x, y + lineIndex * 14);
      });
    });
  }

  createProgressBars(scores) {
    const container = document.getElementById('principle-progress-bars');
    if (!container) return;

    const principles = [
      { name: 'Context Mastery', score: scores.contextMastery, max: 15, color: '#ef4444' },
      { name: 'Dynamic Planning', score: scores.dynamicPlanning, max: 15, color: '#f97316' },
      { name: 'Code Evolution', score: scores.codeEvolution, max: 15, color: '#eab308' },
      { name: 'Strategic Testing', score: scores.strategicTesting, max: 15, color: '#22c55e' },
      { name: 'Intelligent Review', score: scores.intelligentReview, max: 15, color: '#3b82f6' }
    ];

    container.innerHTML = principles.map(principle => {
      const percentage = (principle.score / principle.max) * 100;
      return `
        <div class="progress-item">
          <div class="progress-label">
            <span class="principle-name">${principle.name}</span>
            <span class="principle-score">${principle.score}/${principle.max} (${Math.round(percentage)}%)</span>
          </div>
          <div class="progress-bar">
            <div class="progress-fill" style="width: ${percentage}%; background-color: ${principle.color}"></div>
          </div>
        </div>
      `;
    }).join('');
  }

  autoSaveProgress() {
    const progressData = {
      responses: this.responses,
      currentQuestion: this.currentQuestion,
      startTime: this.startTime,
      lastSaved: new Date()
    };

    localStorage.setItem('ai_assessment_progress', JSON.stringify(progressData));
    
    if (!this.isOffline) {
      this.syncProgress();
    }
  }

  loadSavedProgress() {
    const saved = localStorage.getItem('ai_assessment_progress');
    if (saved) {
      try {
        const data = JSON.parse(saved);
        this.responses = data.responses || {};
        this.currentQuestion = data.currentQuestion || 1;
        this.startTime = new Date(data.startTime) || new Date();
        
        this.restoreFormState();
        this.updateProgress();
      } catch (error) {
        console.error('Error loading saved progress:', error);
      }
    }
  }

  restoreFormState() {
    Object.entries(this.responses).forEach(([questionNum, response]) => {
      const input = document.querySelector(`input[name="q${questionNum}"][value="${response.value}"]`);
      if (input) {
        input.checked = true;
      }
    });
  }

  async syncProgress() {
    if (this.isOffline) return;

    try {
      const progressData = {
        responses: this.responses,
        timestamp: new Date(),
        userId: await this.getUserId()
      };

      // This would sync with your backend API
      // For now, we'll just store it locally
      localStorage.setItem('ai_assessment_synced', JSON.stringify(progressData));
    } catch (error) {
      console.error('Error syncing progress:', error);
    }
  }

  async getUserId() {
    // Get or generate anonymous user ID for progress tracking
    let userId = localStorage.getItem('assessment_user_id');
    if (!userId) {
      userId = 'user_' + Math.random().toString(36).substr(2, 9);
      localStorage.setItem('assessment_user_id', userId);
    }
    return userId;
  }

  nextQuestion() {
    if (this.currentQuestion < this.totalQuestions) {
      this.currentQuestion++;
      this.updateNavigationState();
    }
  }

  previousQuestion() {
    if (this.currentQuestion > 1) {
      this.currentQuestion--;
      this.updateNavigationState();
    }
  }

  updateNavigationState() {
    const completedQuestions = Object.keys(this.responses).length;
    const isComplete = completedQuestions === this.totalQuestions;

    // Enable/disable navigation buttons
    const nextBtn = document.querySelector('.next-question');
    const prevBtn = document.querySelector('.prev-question');
    const completeBtn = document.querySelector('.complete-assessment');

    if (nextBtn) nextBtn.disabled = this.currentQuestion >= this.totalQuestions;
    if (prevBtn) prevBtn.disabled = this.currentQuestion <= 1;
    if (completeBtn) {
      completeBtn.disabled = !isComplete;
      completeBtn.style.display = isComplete ? 'block' : 'none';
    }
  }

  updateConnectionStatus() {
    const statusElement = document.querySelector('.connection-status');
    if (statusElement) {
      statusElement.textContent = this.isOffline ? 'Offline - Progress saved locally' : 'Online - Progress synchronized';
      statusElement.className = `connection-status ${this.isOffline ? 'offline' : 'online'}`;
    }
  }

  completeAssessment() {
    const completedQuestions = Object.keys(this.responses).length;
    if (completedQuestions < this.totalQuestions) {
      alert(`Please complete all ${this.totalQuestions} questions before finishing the assessment.`);
      return;
    }

    const results = this.generateResults();
    this.displayResults(results);
    this.saveCompletedAssessment(results);
  }

  saveCompletedAssessment(results) {
    const assessmentRecord = {
      results: results,
      responses: this.responses,
      completedAt: new Date(),
      version: '1.0'
    };

    localStorage.setItem('ai_assessment_completed', JSON.stringify(assessmentRecord));
    
    if (!this.isOffline) {
      this.syncCompletedAssessment(assessmentRecord);
    }
  }

  async syncCompletedAssessment(assessmentRecord) {
    try {
      // This would sync with your backend API
      console.log('Assessment completed and ready for sync:', assessmentRecord);
    } catch (error) {
      console.error('Error syncing completed assessment:', error);
    }
  }

  downloadActionPlan() {
    const results = this.generateResults();
    const actionPlan = this.generateActionPlanDocument(results);
    
    const blob = new Blob([actionPlan], { type: 'text/markdown' });
    const url = URL.createObjectURL(blob);
    
    const a = document.createElement('a');
    a.href = url;
    a.download = `AI_Development_Action_Plan_${new Date().toISOString().split('T')[0]}.md`;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    
    URL.revokeObjectURL(url);
  }

  generateActionPlanDocument(results) {
    return `# AI Development Maturity Action Plan

## Assessment Results Summary
- **Maturity Level**: ${results.maturityLevel.level}
- **Total Score**: ${results.scores.totalScore}/75 points
- **Assessment Date**: ${results.completedAt.toLocaleDateString()}

## Principle Scores
- **Context Mastery**: ${results.scores.contextMastery}/15
- **Dynamic Planning**: ${results.scores.dynamicPlanning}/15
- **Code Evolution**: ${results.scores.codeEvolution}/15
- **Strategic Testing**: ${results.scores.strategicTesting}/15
- **Intelligent Review**: ${results.scores.intelligentReview}/15

## Your Strengths
${results.strengths.map(s => `- **${s.name}**: ${s.score}/15 (${Math.round(s.percentage)}%)`).join('\n')}

## Growth Opportunities
${results.improvementAreas.map(a => `- **${a.name}**: ${a.score}/15 (${Math.round(a.percentage)}%)`).join('\n')}

## Immediate Actions (Week 1-2)
${results.recommendations.immediate.map(r => `- ${r}`).join('\n')}

## Short-term Focus (Month 1-2)
${results.recommendations.shortTerm.map(r => `- ${r}`).join('\n')}

## Long-term Development (Month 3-6)
${results.recommendations.longTerm.map(r => `- ${r}`).join('\n')}

## Next Steps
${results.nextSteps.map((step, index) => `${index + 1}. ${step}`).join('\n')}

---
Generated by Beyond the AI Plateau Assessment Tool
Visit the full content for detailed implementation guidance.
`;
  }

  saveResults() {
    const results = this.generateResults();
    localStorage.setItem('ai_assessment_results_backup', JSON.stringify(results));
    alert('Results saved successfully! You can access them anytime from your browser.');
  }

  shareResults() {
    const results = this.generateResults();
    const shareText = `I just completed the AI Development Maturity Assessment and scored ${results.scores.totalScore}/75 points, achieving ${results.maturityLevel.level} level! 🚀`;
    
    if (navigator.share) {
      navigator.share({
        title: 'AI Development Maturity Assessment Results',
        text: shareText,
        url: window.location.href
      });
    } else {
      // Fallback to clipboard
      navigator.clipboard.writeText(shareText + '\n\n' + window.location.href);
      alert('Results copied to clipboard!');
    }
  }
}

// Initialize assessment when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  window.aiAssessment = new AIMaturityAssessment();
});

// Export for module systems
if (typeof module !== 'undefined' && module.exports) {
  module.exports = AIMaturityAssessment;
}