---
description: Perform comprehensive security scanning with automated remediation suggestions
argument-hint: [scan scope and security requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

Perform comprehensive security scan for: $ARGUMENTS

Security scanning strategy:
1. **Dependency Vulnerability Scanning**: Check for known vulnerabilities
   - Run npm audit for Node.js projects
   - Use pip-audit or safety for Python dependencies
   - Integrate Snyk for comprehensive vulnerability detection
   - Check for outdated packages and security patches
   - Generate SBOM (Software Bill of Materials)

2. **Static Application Security Testing (SAST)**:
   - ESLint with security plugins for JavaScript/TypeScript
   - Bandit for Python security issues
   - Semgrep for multi-language security patterns
   - SonarQube integration for code quality and security
   - Custom security rules for framework-specific issues

3. **Container Security Scanning**:
   - Trivy for container image vulnerability scanning
   - Docker Scout for base image analysis
   - Hadolint for Dockerfile best practices
   - Check for exposed secrets in container layers
   - Verify base image security and updates

4. **Secrets Detection**:
   - GitLeaks for git history secret scanning
   - TruffleHog for comprehensive secret detection
   - Check environment variables and configuration files
   - Validate API key rotation and management
   - Audit database connection strings

5. **API Security Testing**:
   - OWASP ZAP for dynamic security testing
   - Check for SQL injection vulnerabilities
   - Test for XSS and CSRF vulnerabilities
   - Validate authentication and authorization
   - Check for insecure direct object references

Security scan implementation:

```bash
#!/bin/bash

# Comprehensive security scan script

echo "🔍 Starting comprehensive security scan..."

# Dependency vulnerability scanning
echo "📦 Scanning dependencies..."
if [ -f "package.json" ]; then
  npm audit --audit-level moderate
  npx audit-ci --moderate
fi

if [ -f "requirements.txt" ]; then
  pip-audit -r requirements.txt
  safety check -r requirements.txt
fi

# Static analysis
echo "🔎 Running static analysis..."
if [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ]; then
  npx eslint . --ext .js,.jsx,.ts,.tsx --config .eslintrc.security.js
fi

if [ -d "src" ] && [ "$(find src -name "*.py" | wc -l)" -gt 0 ]; then
  bandit -r src/ -f json -o bandit-report.json
fi

# Container scanning
echo "🐳 Scanning containers..."
if [ -f "Dockerfile" ]; then
  hadolint Dockerfile
  docker build -t temp-scan .
  trivy image temp-scan
  docker rmi temp-scan
fi

# Secrets detection
echo "🔐 Detecting secrets..."
truffleHog --json --entropy=False .
gitleaks detect --source . --verbose

# Generate security report
echo "📊 Generating security report..."
```

Automated remediation suggestions:
1. **Dependency Updates**: Automated package updates
   - Generate pull requests for security updates
   - Test compatibility with updated dependencies
   - Document breaking changes and migration paths
   - Schedule regular dependency audits

2. **Code Fix Suggestions**: Security issue remediation
   - SQL injection prevention with parameterized queries
   - XSS prevention with proper output encoding
   - CSRF protection with token validation
   - Input validation and sanitization
   - Secure authentication implementation

3. **Configuration Hardening**: Security best practices
   - HTTP security headers configuration
   - HTTPS enforcement and HSTS setup
   - Content Security Policy (CSP) implementation
   - Secure cookie configuration
   - Rate limiting and DDoS protection

Security report format:

```json
{
  "scan_date": "2025-09-08T10:30:00Z",
  "project": "my-app",
  "vulnerabilities": {
    "critical": 0,
    "high": 2,
    "medium": 5,
    "low": 12
  },
  "findings": [
    {
      "type": "dependency",
      "severity": "high",
      "package": "express",
      "version": "4.17.1",
      "vulnerability": "CVE-2022-24999",
      "fix": "Update to express@4.18.2 or later"
    }
  ],
  "remediation_plan": [
    {
      "priority": "high",
      "action": "Update express package",
      "command": "npm install express@latest",
      "impact": "Fixes prototype pollution vulnerability"
    }
  ]
}
```

CI/CD Integration:
- GitHub Actions workflow for automated scanning
- Quality gates for security vulnerabilities
- Slack/email notifications for security issues
- Integration with security dashboards
