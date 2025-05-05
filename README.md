# qiskit-connector

[![Python](https://github.com/schijioke-uche/pypi-qiskit-connector/raw/main/docs/badges/python.svg)](https://github.com/schijioke-uche/pypi-qiskit-connector/releases) [![Qiskit Connector Quality Check](https://github.com/schijioke-uche/pypi-qiskit-connector/actions/workflows/quality.yml/badge.svg)](https://github.com/schijioke-uche/pypi-qiskit-connector) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15304311.svg)](https://doi.org/10.5281/zenodo.15304311) [![Qiskit Connector Code Coverage Analysis](https://github.com/schijioke-uche/pypi-qiskit-connector/raw/main/docs/badges/coverage.svg)](https://github.com/schijioke-uche/pypi-qiskit-connector) [![Qiskit Connector Latest Release](https://github.com/schijioke-uche/pypi-qiskit-connector/raw/main/docs/badges/release.svg)](https://github.com/schijioke-uche/pypi-qiskit-connector/releases) [![PyPI Downloads](https://static.pepy.tech/badge/qiskit-connector)](https://pepy.tech/projects/qiskit-connector) [![License](https://github.com/schijioke-uche/pypi-qiskit-connector/raw/main/docs/badges/license-badge.svg)](https://opensource.org/licenses/Apache-2.0) [![Downloads](https://github.com/schijioke-uche/pypi-qiskit-connector/raw/main/docs/badges/monthly-downloads.svg)](https://pypi.org/project/qiskit-connector)




###### Install from Pypi: [https://pypi.org/project/qiskit-connector](https://pypi.org/project/qiskit-connector)

**⚛️Quantum Computing Qiskit Connector For Quantum Backend Use In Realtime**

The Qiskit Connector transforms how quantum developers connect to IBM Quantum backends by automating every step of the authentication, plan detection, and backend selection process. Instead of writing extensive boilerplate setup code for each project, developers can now seamlessly authenticate, dynamically detect whether they are using an `Open` or `Paid` plan, and instantly access the optimal backend `QPU`resource which is least-busy using a single intuitive keyword: `backend`. The connector intelligently manages quantum computing plan environment variables and Qiskit runtime service configuration for sticky reusability of QPU resources from the backend, allowing quantum developers to streamline connection workflows and immediately focus on building, testing, and scaling quantum applications.
<br><br>
By eliminating manual configurations and connection complexities, Qiskit Connector empowers developers to reduce onboarding time, minimize human error, and accelerate quantum solution delivery. The tool is especially valuable for production-grade quantum development where agility, repeatability, and secure backend access are critical. Whether working in research environments, building enterprise-grade quantum solutions, or designing novel quantum algorithms, developers can now concentrate on high-value tasks without being slowed down by infrastructure setup challenges.
<br><br>
This package performs the following:
- Loads environment variables from config file (e.g. `.env`) to configure your IBM Quantum account plan and make the `backend` object available within your quantum application code for reuse in real-time.
- Detects your active plan (Open, Standard, Premium, Dedicated) and sets up the correct channel/instance.
- It has functions to save your account using its (`qiskit_smart`), to verify QPU resources using (`qpu_verify`, `is_verified`), and retrieve a ready-to-use backend using (`connector()`). Presents you with the least-busy backend to run your quantum application code in realtime instead of you using simulators.

###### 🐍 Software built and maintained by Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador & Research Scientist.
---

#### 📋 Built-in functions

These functions are available after you import the module:

```python
from qiskit_connector import (
    connector,
    plan_type
)
```
- **`connector()`**  
  **Primary Integration Point:** Seamlessly initializes your IBM Quantum account, selects the optimal QPU (or the first available device for open/paid plans), and emits a clear diagnostics summary. It returns a fully configured `backend` object that you can immediately pass to Qiskit’s sampler, estimator, transpiler, or any circuit execution API—so you can focus on your quantum workflows rather than connection boilerplate.

- **`plan_type()`**  
  **Subscription Plan Resolver:** Automatically evaluates your environment configuration (via `.env` or system variables) to identify whether you’re operating under the **Open Plan** or a **Paid Plan**. This guarantees that your code consistently targets the correct IBM Quantum service tier, eliminating manual plan management and minimizing configuration drift.

---

#### 🔧 Installation
###### It is recommended that you use `pip` for installation - a common best practice.
```bash
pip install qiskit-connector
```

This will also pull in functionalities powered by Qiskit SDK:
- `qiskit>=2.0.0`  
  

and any other Qiskit dependencies. (Qiskit 1.x is not supported).

---

#### 🗂️ Variable Setup
🔐 Security Practice: Do not check-in `.env or environment variable config file` or any environment variable file into version control. Add it to your .gitignore. During development, create a file named `.env` at your project root. The connector will automatically load it.Use the template below as the content of your .env file or variable config file.

```dotenv

# GENERAL PURPOSE
#--------------------------------------------
IQP_API_TOKEN="<PROVIDE_YOUR_API_TOKEN>"  


# Channels:
#------------------------------------------
OPEN_PLAN_CHANNEL="<PROVIDE_YOUR_CHANNEL>"  
PAID_PLAN_CHANNEL="<PROVIDE PAID PLAN CHANNEL>"  # After July 1, 2025, use ibm_cloud for Paid Plans.


# API Access:
#-------------------------------------
IQP_API_URL=<PROVIDE_YOUR_API_URL>  
IQP_RUNTIME_API_URL=<PROVIDE_YOUR_RUNTIME_API_URL>  


# Quantum Url:
# The API URL. Defaults to https://cloud.ibm.com (when channel=ibm_cloud) 
# The API URL:Default to:  https://auth.quantum.ibm.com/api (when channel=ibm_quantum)"
#-------------------------------------
CLOUD_API_URL="<PROVIDE_YOUR_CLOUD_API_URL>"  
QUANTUM_API_URL="<PROVIDE_YOUR_QUANTUM_API_URL>"  


# Instance:
#-------------------------------------
OPEN_PLAN_INSTANCE="<PROVIDE_YOUR_OPEN_PLAN_INSTANCE>"  
PAID_PLAN_INSTANCE="<PROVIDE_YOUR_PAID_PLAN_INSTANCE>"  


# Default (Open plan) - free
#----------------------------------------
OPEN_PLAN_NAME="open"


# Optional (Upgrade) - Standard
#-----------------------------------------
STANDARD_PLAN_NAME="standard"


# Optional (Upgrade) - Premium
#-----------------------------------------
PREMIUM_PLAN_NAME="premium"


# Optional (Upgrade) - Dedicated
#-----------------------------------------
DEDICATED_PLAN_NAME="dedicated"


# Switch "on" one plan: 
#--------------------------------------------------------------------------------------------------
OPEN_PLAN="on"        # [Default & switched on]  
STANDARD_PLAN="off"     
PREMIUM_PLAN="off"      
DEDICATED_PLAN="off"    
```
> **⚠️ Only one** of `OPEN_PLAN`, `STANDARD_PLAN`, `PREMIUM_PLAN`, or `DEDICATED_PLAN` may be set to **"on"** at a time.

---

#### 📖 Usage

##### Open Plan and Paid Plan

```python

from qiskit_connector import connector, plan_type
from qiskit_ibm_runtime import SamplerV2 as Sampler, Session

# QPU execution mode by plan: Use of 'backend' object.
current = plan_type()
backend = connector()

if current == "Open Plan":  # session not supported
    sampler = Sampler(mode=backend)
    print("Your Plan",current)
    print("Least Busy QPU:", backend.name)
    if isinstance(backend, IBMBackend):
        print("This is a real & live QPU device")
    else:
        print("This is a simulator")
    print(f"\n")
elif current == "Paid Plan":  # supports session
    with Session(backend=backend.name) as session:
        sampler = Sampler(mode=session)
        print("Your Plan",current)
        print("Least Busy QPU:", backend.name)
        if isinstance(backend, IBMBackend):
            print("This is a real & live QPU device")
        else:
            print("This is a simulator")
        print(f"\n")
else:
    raise ValueError(f"Unknown plan type: {current}")

# --- do other things below with backend, quantum circuit, sampler & transpilation ------
```


#### Output Sample
```python
[✓] Quantum environment variables loaded successfully!

--------------------------------------------------------------------------------
[⚛] Connected [Open Plan] -> Realtime Least Busy QPU: ibm_torino
--------------------------------------------------------------------------------

Available QPUs (Open Plan):
  - ibm_brisbane
  - ibm_sherbrooke
  - ibm_torino

Default QPU:     ibm_torino
Qubit Version:   2
Number Qubits:   133

--------------------------------------------------------------------------------

Your Plan:       Open Plan
Least Busy QPU:  ibm_torino
This is a real & live QPU device

#-------- remaining code below ------
```

![IBM Quantum](media/q1.png)

---
####  📜 Citation

Qiskit Connector software invention was inspired by IBM Research on Quantum Computing Qiskit Software, which led the authoring, design, development of Qiskit Connector based on the persistent research studies and tests carried out by  `Dr. Jeffrey Chijioke-Uche(IBM Quantum Ambassador & Research Scientist)` in the lab. This software is expected to continue to metamorphose with the help and work of existing quantum computing academic scholarly & peer reviewed research at different levels in the Information Technology industry. If you use Qiskit for Quantum computing, please cite this software as per the provided ![BibTeX](https://github.com/schijioke-uche/pypi-qiskit-connector/blob/main/CITATION.bib) file.

---

#### 📜 Software Author
Dr. Jeffrey Chijioke-Uche <br>
IBM Computer Scientist <br>
IBM Quantum Ambassador & Research Scientist <br>
IEEE Senior Member (Computational Intelligence)

---
#### 📜  Copyright
Qiskit Connector is proprietary software developed by Dr. Jeffrey Chijioke-Uche © 2025 for enhancing development, usability,and workflows in IBM Quantum Computing by customers and global users. This software is protected under copyright laws and applicable intellectual property statutes. Unauthorized reproduction, distribution, or derivative use of the software in part or whole is strictly prohibited without express written permission from the author. This software may be used under the terms outlined in the accompanying license file (Apache 2.0 or as otherwise specified). Use of this software signifies your agreement to comply with the license terms and to attribute the original author when incorporating the package into your work or systems. For other question(s), please contact the maintainer directly through the official project repository or email channel provided on PyPI. All Rights Reserved.
 
---

#### 📜 Acknowledgment
The development of the Qiskit Connector has been made possible through the support, inspiration, and technical contributions of several leading institutions and communities. The author would like to express deep gratitude to [IBM Research & IBM Quantum Ambassadors Group](https://research.ibm.com/quantum-computing) for their pioneering efforts in democratizing quantum computing and providing the infrastructure and collaborative ecosystem that fostered the development of this tool. Their continued support has significantly accelerated progress in real-world quantum application development.
<br><br>
Additional appreciation is extended to the [IEEE Computational Intelligence](https://cis.ieee.org) Society for their thought leadership in intelligent systems, and to the  [Harvard Program for Research in Science and Engineering](https://www.harvard.edu/) for its role in shaping early research directions. The author also acknowledges [Walden University Research](https://academicguides.waldenu.edu/research-center) for providing a strong academic and methodological foundation throughout the software development lifecycle. These institutions have collectively influenced the innovation and rigor reflected in this project.

---

#### 📜 License

This project uses the Open-source [License](https://github.com/schijioke-uche/pypi-qiskit-connector/blob/main/LICENSE)
