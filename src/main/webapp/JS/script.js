// Sample job data
const jobsData = [
    {
        id: 1,
        title: "Senior Frontend Developer",
        company: "TechCorp Solutions",
        location: "San Francisco, CA",
        type: "Full-time",
        salary: "$120,000 - $150,000",
        experience: "Senior Level",
        remote: "Remote",
        tags: ["React", "JavaScript", "TypeScript", "UI/UX"],
        logo: "/api/placeholder/60/60", // Using placeholder image
        date: "2 days ago",
        description: "We are looking for a Senior Frontend Developer to join our dynamic team. The ideal candidate will have strong experience with modern JavaScript frameworks and a passion for creating exceptional user experiences.",
        responsibilities: [
            "Develop and maintain front-end web applications using React, Redux, and TypeScript",
            "Collaborate with UX/UI designers to implement responsive and intuitive interfaces",
            "Write clean, maintainable, and efficient code",
            "Optimize applications for maximum speed and scalability",
            "Stay up-to-date with emerging trends and best practices in frontend development"
        ],
        requirements: [
            "5+ years of experience in frontend development",
            "Strong proficiency in JavaScript, React, and TypeScript",
            "Experience with state management libraries (Redux, MobX, etc.)",
            "Excellent understanding of responsive design principles",
            "Familiarity with RESTful APIs and GraphQL",
            "Bachelor's degree in Computer Science or related field (or equivalent experience)"
        ],
        benefits: [
            "Competitive salary and equity options",
            "Health, dental, and vision insurance",
            "Flexible work schedule and remote work options",
            "Generous PTO policy",
            "Professional development budget",
            "Home office stipend"
        ]
    },
    {
        id: 2,
        title: "Marketing Manager",
        company: "Growth Innovators",
        location: "New York, NY",
        type: "Full-time",
        salary: "$90,000 - $110,000",
        experience: "Mid Level",
        remote: "Hybrid",
        tags: ["Digital Marketing", "SEO", "Social Media", "Content Strategy"],
        logo: "/api/placeholder/60/60",
        date: "1 day ago",
        description: "We're seeking a talented Marketing Manager to lead our digital marketing efforts. The right candidate will have a strong background in digital marketing strategies and a data-driven approach.",
        responsibilities: [
            "Develop and implement comprehensive marketing strategies to increase brand awareness",
            "Manage social media presence and content calendar",
            "Oversee SEO/SEM campaigns and analyze performance metrics",
            "Collaborate with content creators, designers, and external agencies",
            "Generate regular reports on marketing performance and ROI"
        ],
        requirements: [
            "3+ years of experience in digital marketing roles",
            "Proven success in developing and executing marketing campaigns",
            "Strong analytical skills and experience with marketing analytics tools",
            "Excellent project management and communication skills",
            "Bachelor's degree in Marketing, Communications, or related field"
        ],
        benefits: [
            "Competitive salary and performance bonuses",
            "Comprehensive health benefits",
            "401(k) matching program",
            "Hybrid work environment",
            "Professional development opportunities",
            "Team building events and social activities"
        ]
    },
    {
        id: 3,
        title: "Data Scientist",
        company: "DataMinds Analytics",
        location: "Boston, MA",
        type: "Full-time",
        salary: "$115,000 - $140,000",
        experience: "Mid-Senior Level",
        remote: "On-site",
        tags: ["Python", "Machine Learning", "SQL", "Data Analysis"],
        logo: "/api/placeholder/60/60",
        date: "3 days ago",
        description: "DataMinds Analytics is looking for a skilled Data Scientist to join our growing team. You'll work on challenging problems using cutting-edge techniques in machine learning and data analysis.",
        responsibilities: [
            "Design and implement machine learning models to solve complex business problems",
            "Collect, process, and analyze large datasets to extract valuable insights",
            "Collaborate with cross-functional teams to translate business requirements into data solutions",
            "Present findings and recommendations to stakeholders",
            "Stay current with the latest developments in the field of data science"
        ],
        requirements: [
            "4+ years of experience in data science or related field",
            "Strong programming skills in Python and SQL",
            "Experience with machine learning frameworks (TensorFlow, PyTorch, scikit-learn)",
            "Solid understanding of statistical analysis and modeling techniques",
            "Advanced degree in Computer Science, Statistics, or related field"
        ],
        benefits: [
            "Competitive salary and annual bonus",
            "Comprehensive benefits package",
            "Continuing education allowance",
            "Regular team outings and events",
            "Modern office in prime location",
            "Flexible working hours"
        ]
    },
    {
        id: 4,
        title: "UX/UI Designer",
        company: "Creative Interfaces",
        location: "Austin, TX",
        type: "Full-time",
        salary: "$85,000 - $105,000",
        experience: "Mid Level",
        remote: "Remote",
        tags: ["Figma", "User Research", "Prototyping", "Adobe Creative Suite"],
        logo: "/api/placeholder/60/60",
        date: "1 week ago",
        description: "Creative Interfaces is seeking a talented UX/UI Designer to create beautiful, functional designs for web and mobile applications. The ideal candidate has a strong portfolio showcasing user-centered design solutions.",
        responsibilities: [
            "Create wireframes, user flows, prototypes and high-fidelity mockups",
            "Conduct user research and usability testing",
            "Collaborate with product managers and developers throughout the design process",
            "Design intuitive interfaces that meet business requirements and user needs",
            "Maintain and evolve our design system"
        ],
        requirements: [
            "3+ years of experience in UX/UI design",
            "Proficiency with design tools like Figma, Sketch, and Adobe Creative Suite",
            "Experience conducting user research and usability testing",
            "Strong understanding of design principles and interaction patterns",
            "Excellent communication and collaboration skills",
            "Bachelor's degree in Design, HCI, or related field"
        ],
        benefits: [
            "Competitive salary",
            "Health, dental, and vision insurance",
            "Remote work with flexible hours",
            "Design conference allowance",
            "Creative team environment",
            "Professional development opportunities"
        ]
    },
    {
        id: 5,
        title: "DevOps Engineer",
        company: "CloudScale Technologies",
        location: "Seattle, WA",
        type: "Full-time",
        salary: "$125,000 - $145,000",
        experience: "Senior Level",
        remote: "Hybrid",
        tags: ["AWS", "Docker", "Kubernetes", "CI/CD", "Infrastructure as Code"],
        logo: "/api/placeholder/60/60",
        date: "5 days ago",
        description: "CloudScale Technologies is looking for an experienced DevOps Engineer to help us build and maintain our cloud infrastructure. The ideal candidate will have a strong background in cloud technologies and automation.",
        responsibilities: [
            "Design, implement, and maintain AWS cloud infrastructure",
            "Build and improve CI/CD pipelines",
            "Manage container orchestration using Kubernetes",
            "Implement infrastructure as code using Terraform or CloudFormation",
            "Collaborate with development teams to improve deployment processes",
            "Monitor system performance and troubleshoot issues"
        ],
        requirements: [
            "5+ years of experience in DevOps or SRE roles",
            "Strong knowledge of AWS services and architecture",
            "Experience with containerization (Docker) and orchestration (Kubernetes)",
            "Familiarity with CI/CD tools (Jenkins, GitHub Actions, etc.)",
            "Scripting skills in Python, Bash, or similar",
            "Knowledge of infrastructure as code tools (Terraform, CloudFormation)"
        ],
        benefits: [
            "Competitive salary and stock options",
            "Comprehensive health benefits",
            "Flexible work arrangements",
            "Continuous learning opportunities",
            "Regular team building activities",
            "Modern office with catered lunches"
        ]
    }
];

// DOM Elements
const jobsList = document.getElementById('jobs-list');
const jobModal = document.getElementById('job-modal');
const modalJobContent = document.getElementById('modal-job-content');
const loginModal = document.getElementById('login-modal');
const closeButtons = document.querySelectorAll('.close');
const salaryRange = document.getElementById('salary-range');
const salaryValue = document.getElementById('salary-value');
const jobSearch = document.getElementById('job-search');
const locationSearch = document.getElementById('location-search');
const searchBtn = document.querySelector('.search-btn');
const loginBtn = document.querySelector('.btn-outline');
const postJobBtn = document.querySelector('.btn-primary');
const sortSelect = document.getElementById('sort-by');

// Initialize the page
document.addEventListener('DOMContentLoaded', function() {
    // Load jobs
    renderJobs(jobsData);
    
    // Set up event listeners
    setupEventListeners();
    
    // Initialize salary range slider
    initRangeSlider();
});

// Render jobs to the jobs list
function renderJobs(jobs) {
    jobsList.innerHTML = '';
    
    if (jobs.length === 0) {
        jobsList.innerHTML = `
            <div class="no-results">
                <h3>No jobs found</h3>
                <p>Try adjusting your search criteria or filters.</p>
            </div>
        `;
        return;
    }
    
    jobs.forEach(job => {
        const jobCard = document.createElement('div');
        jobCard.className = 'job-card';
        jobCard.setAttribute('data-id', job.id);
        
        jobCard.innerHTML = `
            <img src="${job.logo}" alt="${job.company}" class="job-logo">
            
            <div class="job-info">
                <h3>${job.title}</h3>
                <div class="company-name">${job.company}</div>
                <div class="job-meta">
                    <div class="job-meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>${job.location}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-briefcase"></i>
                        <span>${job.type}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-signal"></i>
                        <span>${job.experience}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-laptop-house"></i>
                        <span>${job.remote}</span>
                    </div>
                </div>
                <div class="job-tags">
                    ${job.tags.map(tag => `<span class="job-tag">${tag}</span>`).join('')}
                </div>
            </div>
            
            <div class="job-actions">
                <div class="salary">${job.salary}</div>
                <div class="job-date">${job.date}</div>
                <button class="btn btn-outline btn-sm apply-btn">Apply Now</button>
            </div>
        `;
        
        jobsList.appendChild(jobCard);
    });
}

// Set up event listeners
function setupEventListeners() {
    // Job card click
    jobsList.addEventListener('click', function(e) {
        const jobCard = e.target.closest('.job-card');
        if (jobCard) {
            const jobId = parseInt(jobCard.getAttribute('data-id'));
            const job = jobsData.find(job => job.id === jobId);
            if (job) {
                openJobModal(job);
            }
        }
        
        // Apply button click
        if (e.target.classList.contains('apply-btn')) {
            e.stopPropagation();
            alert('Application functionality would go here!');
        }
    });
    
    // Close modals
    closeButtons.forEach(button => {
        button.addEventListener('click', function() {
            jobModal.style.display = 'none';
            loginModal.style.display = 'none';
        });
    });
    
    // Click outside modal to close
    window.addEventListener('click', function(e) {
        if (e.target === jobModal) {
            jobModal.style.display = 'none';
        }
        if (e.target === loginModal) {
            loginModal.style.display = 'none';
        }
    });
    
    // Login button
    loginBtn.addEventListener('click', function() {
        loginModal.style.display = 'block';
    });
    
    // Post job button
    postJobBtn.addEventListener('click', function() {
        if (isLoggedIn()) {
            alert('Post job form would appear here!');
        } else {
            loginModal.style.display = 'block';
        }
    });
    
    // Search button
    searchBtn.addEventListener('click', function() {
        searchJobs();
    });
    
    // Filter checkboxes
    document.querySelectorAll('.checkbox-group input').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            filterJobs();
        });
    });
    
    // Sort select
    sortSelect.addEventListener('change', function() {
        sortJobs();
    });
    
    // Pagination
    document.querySelectorAll('.pagination-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.pagination-btn').forEach(b => b.classList.remove('active'));
            this.classList.add('active');
            // Would fetch page data here in a real application
        });
    });
    
    // Form submission prevention
    document.getElementById('login-form').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Login functionality would be implemented here.');
        loginModal.style.display = 'none';
    });
    
    // Switch to signup
    document.getElementById('switch-to-signup').addEventListener('click', function(e) {
        e.preventDefault();
        alert('Signup form would appear here.');
    });
}

// Initialize salary range slider
function initRangeSlider() {
    salaryRange.addEventListener('input', function() {
        const value = parseInt(this.value).toLocaleString();
        salaryValue.textContent = `$${value}+`;
        filterJobs();
    });
}

// Open job modal with job details
function openJobModal(job) {
    modalJobContent.innerHTML = `
        <div class="job-modal-header">
            <img src="${job.logo}" alt="${job.company}" class="job-modal-logo">
            <div class="job-modal-title">
                <h2>${job.title}</h2>
                <div class="job-modal-company">${job.company}</div>
                <div class="job-meta">
                    <div class="job-meta-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span>${job.location}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-briefcase"></i>
                        <span>${job.type}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-signal"></i>
                        <span>${job.experience}</span>
                    </div>
                    <div class="job-meta-item">
                        <i class="fas fa-laptop-house"></i>
                        <span>${job.remote}</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="job-stats">
            <div class="job-stat-item">
                <h4>Salary Range</h4>
                <p>${job.salary}</p>
            </div>
            <div class="job-stat-item">
                <h4>Job Type</h4>
                <p>${job.type}</p>
            </div>
            <div class="job-stat-item">
                <h4>Experience Level</h4>
                <p>${job.experience}</p>
            </div>
            <div class="job-stat-item">
                <h4>Work Setting</h4>
                <p>${job.remote}</p>
            </div>
        </div>
        
        <div class="job-description">
            <h3>Job Description</h3>
            <p>${job.description}</p>
            
            <h3>Responsibilities</h3>
            <ul>
                ${job.responsibilities.map(item => `<li>${item}</li>`).join('')}
            </ul>
            
            <h3>Requirements</h3>
            <ul>
                ${job.requirements.map(item => `<li>${item}</li>`).join('')}
            </ul>
            
            <h3>Benefits</h3>
            <ul>
                ${job.benefits.map(item => `<li>${item}</li>`).join('')}
            </ul>
        </div>
        
        <div class="job-modal-actions">
            <button class="btn btn-primary btn-lg">Apply Now</button>
            <button class="btn btn-outline">Save Job</button>
            <button class="btn btn-outline">Share</button>
        </div>
    `;
    
    jobModal.style.display = 'block';
}

// Search jobs based on search inputs
function searchJobs() {
    const searchTerm = jobSearch.value.toLowerCase();
    const locationTerm = locationSearch.value.toLowerCase();
    
    const filteredJobs = jobsData.filter(job => {
        const matchesSearch = 
            job.title.toLowerCase().includes(searchTerm) || 
            job.company.toLowerCase().includes(searchTerm) ||
            job.tags.some(tag => tag.toLowerCase().includes(searchTerm));
            
        const matchesLocation = 
            !locationTerm || 
            job.location.toLowerCase().includes(locationTerm) ||
            (locationTerm === 'remote' && job.remote.toLowerCase() === 'remote');
            
        return matchesSearch && matchesLocation;
    });
    
    renderJobs(filteredJobs);
}

// Filter jobs based on checkboxes and slider
function filterJobs() {
    // Get filter values
    const jobTypes = Array.from(document.querySelectorAll('input[name="job-type"]:checked'))
        .map(checkbox => checkbox.value);
    
    const experiences = Array.from(document.querySelectorAll('input[name="experience"]:checked'))
        .map(checkbox => checkbox.value);
        
    const remoteOptions = Array.from(document.querySelectorAll('input[name="remote"]:checked'))
        .map(checkbox => checkbox.value);
        
    const minSalary = parseInt(salaryRange.value);
    
    // Filter the jobs
    const filteredJobs = jobsData.filter(job => {
        // Job type filter
        const matchesJobType = jobTypes.length === 0 || 
            jobTypes.some(type => job.type.toLowerCase().includes(type));
        
        // Experience filter
        const matchesExperience = experiences.length === 0 || 
            experiences.some(exp => job.experience.toLowerCase().includes(exp));
        
        // Remote filter
        const matchesRemote = remoteOptions.length === 0 || 
            remoteOptions.some(option => job.remote.toLowerCase().includes(option));
        
        // Salary filter - Basic implementation
        const matchesSalary = parseInt(job.salary.replace(/[^0-9]/g, '')) >= minSalary;
        
        return matchesJobType && matchesExperience && matchesRemote && matchesSalary;
    });
    
    renderJobs(filteredJobs);
}

// Sort jobs based on select value
function sortJobs() {
    const sortBy = sortSelect.value;
    let sortedJobs = [...jobsData];
    
    switch(sortBy) {
        case 'recent':
            // Simple sort by date (in a real app, would use actual date objects)
            sortedJobs.sort((a, b) => {
                const aTime = a.date.includes('day') ? parseInt(a.date) : 14;
                const bTime = b.date.includes('day') ? parseInt(b.date) : 14;
                return aTime - bTime;
            });
            break;
        case 'salary-high':
            sortedJobs.sort((a, b) => {
                const aVal = parseInt(a.salary.match(/\d+/g)[1] || a.salary.match(/\d+/g)[0]);
                const bVal = parseInt(b.salary.match(/\d+/g)[1] || b.salary.match(/\d+/g)[0]);
                return bVal - aVal;
            });
            break;
        case 'salary-low':
            sortedJobs.sort((a, b) => {
                const aVal = parseInt(a.salary.match(/\d+/g)[0]);
                const bVal = parseInt(b.salary.match(/\d+/g)[0]);
                return aVal - bVal;
            });
            break;
        default:
            // Default is relevance, which we'll just keep as original order
            break;
    }
    
    renderJobs(sortedJobs);
}

// Mock user authentication check
function isLoggedIn() {
    // In a real app, this would check session/token
    return false;
}

// Function to clear all filters
document.querySelector('.filters-panel .btn-block').addEventListener('click', function() {
    // Reset checkboxes
    document.querySelectorAll('.checkbox-group input').forEach(checkbox => {
        checkbox.checked = false;
    });
    
    // Reset salary slider
    salaryRange.value = salaryRange.min;
    salaryValue.textContent = `$${parseInt(salaryRange.min).toLocaleString()}+`;
    
    // Reset search inputs
    jobSearch.value = '';
    locationSearch.value = '';
    
    // Reset sort
    sortSelect.value = 'relevance';
    
    // Render all jobs
    renderJobs(jobsData);
});