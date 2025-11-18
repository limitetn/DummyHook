// DOM Elements
const introScreen = document.getElementById('intro-screen');
const mainWebsite = document.getElementById('main-website');
const enterBtn = document.getElementById('enter-btn');

// Intro Animation Sequence
function playIntroAnimation() {
    // Hide intro screen
    introScreen.classList.add('hidden');
    
    // Show main website after a short delay
    setTimeout(() => {
        mainWebsite.classList.remove('hidden');
        mainWebsite.classList.add('visible');
        
        // Initialize animations for main content
        initMainAnimations();
    }, 1000);
}

// Initialize animations for main website content
function initMainAnimations() {
    // Animate hero content
    const heroContent = document.querySelector('.hero-content');
    if (heroContent) {
        setTimeout(() => {
            heroContent.classList.add('visible');
        }, 300);
    }
    
    // Animate section titles as they come into view
    const sectionTitles = document.querySelectorAll('.section-title');
    const titleObserver = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
                titleObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    
    sectionTitles.forEach(title => {
        titleObserver.observe(title);
    });
    
    // Animate feature cards
    const featureCards = document.querySelectorAll('.feature-card');
    const featureObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('visible');
                }, index * 100);
                featureObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    
    featureCards.forEach(card => {
        featureObserver.observe(card);
    });
    
    // Animate pricing card
    const pricingCard = document.querySelector('.pricing-card');
    if (pricingCard) {
        const pricingObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    pricingObserver.unobserve(entry.target);
                }
            });
        }, { threshold: 0.1 });
        
        pricingObserver.observe(pricingCard);
    }
    
    // Animate testimonial cards
    const testimonialCards = document.querySelectorAll('.testimonial-card');
    const testimonialObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('visible');
                }, index * 100);
                testimonialObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    
    testimonialCards.forEach(card => {
        testimonialObserver.observe(card);
    });
    
    // Animate FAQ items
    const faqItems = document.querySelectorAll('.faq-item');
    const faqObserver = new IntersectionObserver((entries) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                setTimeout(() => {
                    entry.target.classList.add('visible');
                }, index * 100);
                faqObserver.unobserve(entry.target);
            }
        });
    }, { threshold: 0.1 });
    
    faqItems.forEach(item => {
        faqObserver.observe(item);
    });
}

// FAQ Toggle Functionality
document.addEventListener('DOMContentLoaded', function() {
    const faqItems = document.querySelectorAll('.faq-item');
    
    faqItems.forEach(item => {
        const question = item.querySelector('.faq-question');
        
        question.addEventListener('click', () => {
            // Close all other FAQ items
            faqItems.forEach(otherItem => {
                if (otherItem !== item) {
                    otherItem.classList.remove('active');
                }
            });
            
            // Toggle current item
            item.classList.toggle('active');
        });
    });
    
    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80,
                    behavior: 'smooth'
                });
            }
        });
    });
    
    // Button click effects
    const buttons = document.querySelectorAll('.btn-primary');
    
    buttons.forEach(button => {
        button.addEventListener('click', function() {
            // Add animation class
            this.classList.add('clicked');
            
            // Remove after animation completes
            setTimeout(() => {
                this.classList.remove('clicked');
            }, 300);
            
            // Show purchase message
            if (this.textContent.includes('Purchase') || this.textContent.includes('Get Access')) {
                alert('🎉 Thank you for your interest in DummyHook!\n\nThis is a demonstration website. In a real implementation, this would redirect to a payment processor for the $10 purchase.\n\nAfter payment, you would receive:\n- Immediate download access\n- Lifetime updates\n- 24/7 support\n- Secure delivery');
            }
        });
    });
    
    // Add event listener to enter button
    if (enterBtn) {
        enterBtn.addEventListener('click', playIntroAnimation);
    }
});