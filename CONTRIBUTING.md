# Contributing to Qiskit Connector®

Thank you for your interest in contributing to Qiskit Connector®!  
We welcome all contributions that help improve, document, or test this open-source extension for seamless IBM Quantum backend integration.

## How to Contribute

### 1. Open an Issue

If you find a bug, have a question, or wish to propose an enhancement, please [open a GitHub issue](https://github.com/QComputingSoftware/pypi-qiskit-connector/issues).  
Be sure to include as much context as possible (steps to reproduce, error messages, environment, etc.).

### 2. Fork and Clone

- Fork the [main repository](https://github.com/QComputingSoftware/pypi-qiskit-connector)
- Clone your fork:

  ```bash
  git clone https://github.com/your-username/pypi-qiskit-connector.git
  cd pypi-qiskit-connector
  ```

- Set up the upstream remote:

  ```bash
  git remote add upstream https://github.com/QComputingSoftware/pypi-qiskit-connector.git
  ```

### 3. Set Up Your Development Environment

- Ensure you have Python 3.9+ installed.
- (Recommended) Use a virtual environment:

[Use Qiskit Tool Setup Wizard ](https://github.com/schijioke-uche/quantum-computing-qiskit-tool-wizard)
Takes 5mins

- For contributors working on core quantum features, ensure Qiskit and required quantum SDKs are up to date.

### 4. Making a Pull Request

- Create a new branch for your fix or feature:
  ```bash
  git checkout -b my-feature-branch
  ```
- Make your changes.  
- Include clear commit messages.
- Add or update tests as needed (`tests/` folder).
- Ensure all tests pass:
  ```bash
  pytest
  ```
- Commit and push to your fork:
  ```bash
  git push origin my-feature-branch
  ```
- Open a Pull Request on GitHub against the `main` branch.  
  Clearly describe your change, reference any relevant issues, and ensure CI tests complete successfully.

### 5. Code Style

- Follow [PEP8](https://www.python.org/dev/peps/pep-0008/) conventions.
- Write docstrings for all public functions and classes.
- Use [Google style docstrings](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html) if possible.
- Ensure code is linted (`flake8 .`) and formatted (`black .`).

### 6. Security

- Please do not disclose security vulnerabilities publicly.
- [Report security issues privately](https://github.com/QComputingSoftware/pypi-qiskit-connector/security/policy) or via email: `security@qcomputingsoftware.com`.
- See [SECURITY.md](./SECURITY.md) for our full security policy.

### 7. Community Standards

- Be respectful and constructive in all interactions.
- See our [Code of Conduct](./CODE_OF_CONDUCT.md).

### 8. Release Process

- Releases are handled by maintainers and automated CI/CD workflows.
- To propose a release, tag a maintainer or open an issue.
- All PRs must pass automated checks before merging.

---

## Useful Links

- [Repository on GitHub](https://github.com/QComputingSoftware/pypi-qiskit-connector)
- [PyPI Project Page](https://pypi.org/project/qiskit-connector/)
- [Qiskit Documentation](https://docs.quantum.ibm.com/)
- [Open an Issue](https://github.com/QComputingSoftware/pypi-qiskit-connector/issues)
- [Submit a Pull Request](https://github.com/QComputingSoftware/pypi-qiskit-connector/pulls)
- [Security Policy](./SECURITY.md)

---

Thank you for helping improve Qiskit Connector®!  
Happy quantum coding! 🚀
