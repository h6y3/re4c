# Security Policy

## Supported Versions

We provide security updates for the following versions of re4c:

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x   | ✅ Active support  |
| < 1.0   | ❌ No longer supported |

## Security Considerations

re4c is a development workflow system that:
- Executes shell commands and scripts
- Modifies files in your development environment
- Integrates with external services (GitHub, APIs)
- May handle sensitive project data

### Potential Security Areas

1. **Command Execution**: Commands may execute shell scripts and modify system files
2. **File System Access**: Commands read and write files throughout your project
3. **External Integrations**: Some commands integrate with external services
4. **Environment Variables**: Commands may use environment variables for configuration
5. **Network Requests**: Commands may make HTTP requests to external services

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

To report a security vulnerability:

1. **Open a GitHub Security Advisory** at https://github.com/user/re4c/security/advisories/new
2. **Or create a private issue** by emailing security details (if repository private)

### What to Include

Please provide:
- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact assessment
- Any suggested fixes (optional)
- Your contact information for follow-up

### Response Timeline

- **Initial Response**: Within 48 hours
- **Vulnerability Assessment**: Within 1 week  
- **Fix Development**: Timeline depends on severity
- **Patch Release**: As soon as fix is validated

## Security Best Practices

When using re4c:

### For Users
- **Review Commands**: Understand what each command does before running
- **Secure Credentials**: Never commit API keys or secrets to repositories
- **Environment Isolation**: Run re4c in appropriate development environments
- **Regular Updates**: Keep re4c updated to latest stable version

### For Contributors
- **Input Validation**: Validate all user inputs and file paths
- **Secure Defaults**: Use secure defaults for all configurations
- **Error Handling**: Avoid exposing sensitive information in error messages
- **Code Review**: All changes undergo security-focused review

## Vulnerability Disclosure Policy

### Coordinated Disclosure
We follow coordinated disclosure principles:
- Work with reporters to understand and fix issues
- Provide credit to security researchers
- Coordinate public disclosure timing
- Maintain transparency about security issues

### Public Disclosure
After fixes are available:
- Security advisories will be published
- Release notes will include security fixes
- CVE numbers will be assigned if applicable
- Community will be notified through appropriate channels

## Security Features

re4c includes several security-conscious design decisions:

### Command Validation
- All commands undergo structural validation
- File path validation prevents directory traversal
- Input sanitization for user-provided data

### File System Safety
- Backup creation before file modifications
- Validation of file permissions and ownership
- Controlled file system access patterns

### Integration Security
- Secure handling of API credentials
- Validation of external service responses
- Rate limiting and error handling for network requests

## Known Limitations

Current security limitations to be aware of:

1. **Shell Command Execution**: Commands may execute arbitrary shell commands
2. **File System Access**: Full file system access within project directory
3. **Network Requests**: Some commands make external network requests
4. **Environment Variables**: Access to system environment variables

## Reporting Non-Security Issues

For non-security bugs and issues:
- Use standard GitHub Issues
- Follow bug report template
- Provide reproduction steps
- Include system and version information

## Contact

For security-related questions or concerns:
- Security advisories: GitHub Security tab
- General questions: GitHub Issues (for non-sensitive topics)

Thank you for helping keep re4c and the Claude Code community secure! 🔒