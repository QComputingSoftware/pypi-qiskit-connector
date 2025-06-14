# Qiskit Connector

[![Python](https://github.com/QComputingSoftware/pypi-qiskit-connector/raw/main/docs/badges/python.svg)](https://www.python.org/downloads) [![Qiskit Connector Quality Check](https://github.com/QComputingSoftware/pypi-qiskit-connector/actions/workflows/quality.yml/badge.svg)](https://github.com/QComputingSoftware/pypi-qiskit-connector) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15349641.svg)](https://doi.org/10.5281/zenodo.15304310) [![Qiskit Connector Code Coverage Analysis](https://github.com/QComputingSoftware/pypi-qiskit-connector/raw/main/docs/badges/coverage.svg)](https://github.com/QComputingSoftware/pypi-qiskit-connector) [![Qiskit Connector Latest Release](https://github.com/QComputingSoftware/pypi-qiskit-connector/raw/main/docs/badges/release.svg)](https://github.com/QComputingSoftware/pypi-qiskit-connector/releases) [![PyPI Downloads](https://static.pepy.tech/badge/qiskit-connector)](https://pepy.tech/projects/qiskit-connector) [![License](https://github.com/QComputingSoftware/pypi-qiskit-connector/raw/main/docs/badges/license-badge.svg)](https://opensource.org/licenses/Apache-2.0) [![Downloads](https://github.com/QComputingSoftware/pypi-qiskit-connector/raw/main/docs/badges/monthly-downloads.svg)](https://pypi.org/project/qiskit-connector)


###### Install from Pypi: [https://pypi.org/project/qiskit-connector](https://pypi.org/project/qiskit-connector)


**🖥️ Qiskit Connector® - Seamless Real-Time Connector for IBM Quantum Computing QPU**

Qiskit Connector® is quantum computing open-source SDK extension. The Qiskit Connector® transforms how quantum developers connect to IBM Quantum backends by automating every step of the authentication, plan detection, and backend selection process. Instead of writing extensive boilerplate setup code for each project, developers can now seamlessly authenticate, dynamically detect whether they are using an `Open` or `Paid` plan, and instantly access the optimal backend `QPU`resource which is least-busy using a single intuitive keyword: `backend`. The connector intelligently manages quantum computing plan environment variables and Qiskit runtime service configuration for sticky reusability of QPU resources from the backend, allowing quantum developers to streamline connection workflows and immediately focus on building, testing, and scaling quantum applications.
<br><br>
By eliminating manual configurations and connection complexities, Qiskit Connector empowers developers to reduce onboarding time, minimize human error, and accelerate quantum solution delivery. The tool is especially valuable for production-grade quantum development where agility, repeatability, and secure backend access are critical. Whether working in research environments, building enterprise-grade quantum solutions, or designing novel quantum algorithms, developers can now concentrate on high-value tasks without being slowed down by infrastructure setup challenges.
<br><br>
⚛️This package performs the following:
- Loads environment variables from config file (e.g. `.env` if you are local) or load it remotely(depending on detection) to configure your IBM Quantum account plan and make the `backend` object available within your quantum application code for reuse in real-time.
- Detects your active plan (Open, Standard, Premium, Dedicated) and sets up the correct channel/instance.
- It has (`qiskit_smart`) to establish connectivity, then to verify QPU resources using (`qpu_verify`), and retrieve a ready-to-use backend using (`connector()`). Presents you with the least-busy backend QPU to run your quantum application code in realtime.

###### 🧩 Software built by ©2025 Dr. Jeffrey Chijioke-Uche, IBM Computer Scientist & Quantum Ambassador.
---

#### 📋 Built-in classes & functions

These functions are available after you import the module:

```python
from qiskit_connector import QConnectorV2 as connector
from qiskit_connector import QPlanV2 as plan
```
- **`connector()`**  
  **Primary Integration Point:** Seamlessly initializes your IBM Quantum account, selects the optimal QPU (or the first available device for open/paid plans), and emits a clear diagnostics summary. It returns a fully configured `backend` object that you can immediately pass to Qiskit’s sampler, estimator, transpiler, or any circuit execution API—so you can focus on your quantum workflows rather than connection boilerplate.

- **`plan()`**  
  **Subscription Plan Resolver:** Automatically evaluates your environment configuration (via `.env` or system variables) to identify whether you’re operating under the **Open Plan** or a **Paid Plan**. This guarantees that your code consistently targets the correct IBM Quantum service tier, eliminating manual plan management and minimizing configuration drift.

---

#### 📌 Changelog

| Version   | Description                                                                                   | Updated Import Syntax                                                                 |
|-----------|-----------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| <= v2.2.2    | Initial import approach using functional-style interface for all versions equal or below v2.2.2                                      | `from qiskit_connector import connector, plan_type`                                   |
| >= v2.2.3    | Switched to class-based architecture with aliasing for enhanced flexibility and clarity for all versions equal or above 2.2.3      | `from qiskit_connector import QConnectorV2 as connector`<br>`from qiskit_connector import QPlanV2 as plan` |

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
🔐 [Security Practices](https://cloud.ibm.com/docs/security-compliance?topic=security-compliance-best-practices): Do not check-in to version control any `environment variable config file` or any variable setup file. The best security practice is to add it to your `.gitignore` or to accessible `vault`. During local development, create a file named `.env` at your project root and ensure it is named on your `.gitignore`. The connector will automatically load it. Use the template below as the content of your .env file or variable setup config file. Copy and paste it then supply the values.


```dotenv

# General Purpose:                                            (Required)
#--------------------------------------------------------------------------------------
IQP_API_TOKEN="<PROVIDE_YOUR_API_TOKEN>"  


# Channels:                                                   (Required)
#--------------------------------------------------------------------------------------
OPEN_PLAN_CHANNEL="<PROVIDE_YOUR_CHANNEL>"  
PAID_PLAN_CHANNEL="<PROVIDE PAID PLAN CHANNEL>"  


# API Url:                                                    (Optional)
#--------------------------------------------------------------------------------------
IQP_API_URL=<PROVIDE_YOUR_API_URL>  
IQP_RUNTIME_API_URL=<PROVIDE_YOUR_RUNTIME_API_URL>  


# Quantum Url:                                                (Optional)
#---------------------------------------------------------------------------------------
CLOUD_API_URL="<PROVIDE_YOUR_CLOUD_API_URL>" 
QUANTUM_API_URL="<PROVIDE_YOUR_QUANTUM_API_URL>"  


# Instance:                                                   (Required)
#---------------------------------------------------------------------------------------
OPEN_PLAN_INSTANCE="<PROVIDE_YOUR_OPEN_PLAN_INSTANCE>"  
PAID_PLAN_INSTANCE="<PROVIDE_YOUR_PAID_PLAN_INSTANCE>"  


# Default (Open plan) - free                                   
#---------------------------------------------------------------------------------------
OPEN_PLAN_NAME="open"


# Optional (Upgrade) - Pay as you go                             
#----------------------------------------------------------------------------------------
PAYGO_PLAN_NAME="pay-as-you-go"


# Optional (Upgrade) - Flex                              
#----------------------------------------------------------------------------------------
FLEX_PLAN_NAME="flex"


# Optional (Upgrade) - Premium                                
#----------------------------------------------------------------------------------------
PREMIUM_PLAN_NAME="premium"


# Optional (Upgrade) - Dedicated                               
#----------------------------------------------------------------------------------------
DEDICATED_PLAN_NAME="dedicated"


# Switch "on" plan:                                       (Required)
#----------------------------------------------------------------------------------------
OPEN_PLAN="on"        # [Default & switched on] [Free] 
PAYGO_PLAN="off"
FLEX_PLAN="off"      
PREMIUM_PLAN="off"      
DEDICATED_PLAN="off"    
```
> **⚠️ Only one** of the plans can be set to **"on"** at a time.

---




#### 👤 Usage - With Qiskit 2.x Code Sample

###### 📦 For Open or Paid Plans

```python

# After Pip install, Import Qiskit Connector:
from qiskit_connector import QConnectorV2 as connector
from qiskit_connector import QPlanV2 as plan

# Initialize Qiskit Connector::
current = plan()
backend = connector()

# ------------------------------ QISKIT 2.x CODE SAMPLE -------------------------------------------------
#     This code sample is using the Qiskit Connector to run with a real quantum backend.
###############################################################################################
# 🔍 This code sample demonstrates how to create a randomized circuit with depolarizing noise
# ✅ QuantumCircuit(2, 2) — matches 2-qubit base circuit
# ✅ Applies independent random Pauli gates per qubit before and after the base logic
# ✅ Uses remove_final_measurements() to cleanly insert logic into the composed circuit
# ✅ Re-applies measurements after twirling to preserve expected output
################################################################################################
import random
import numpy as np
from qiskit import QuantumCircuit, transpile
from qiskit_ibm_runtime import SamplerV2 as Sampler, Session
from datetime import datetime
import time
from collections import Counter
from qiskit.visualization import circuit_drawer
from IPython.display import display, Markdown
from PIL import Image

# Pauli gates
paulis = ['I', 'X', 'Y', 'Z']
pauli_gates = {
    'I': lambda qc, q: None,
    'X': lambda qc, q: qc.x(q),
    'Y': lambda qc, q: qc.y(q),
    'Z': lambda qc, q: qc.z(q)
}

# Check if running on Jupyter Notebook
def in_jupyter():
    try:
        from IPython import get_ipython
        shell = get_ipython().__class__.__name__
        return shell in ('ZMQInteractiveShell',)  
    except Exception:
        return False
       
# 2-qubit base circuit
def base_circuit_entangled():
    """
    Creates a 2-qubit quantum circuit with entanglement.
    Applies gates H, RX, RZ, S, T, H on each qubit,
    and inserts a CNOT gate to entangle qubits 0 and 1.
    Measures each qubit into its corresponding classical bit.
    """
    qc = QuantumCircuit(2, 2)
    
    # Apply initial Hadamard to qubit 0
    qc.h(0)
    
    # Entangle qubit 0 and qubit 1 with CNOT
    qc.cx(0, 1)
    
    # Continue gates on both qubits
    for q in range(2):
        qc.rx(0.5, q)
        qc.rz(1.0, q)
        qc.s(q)
        qc.t(q)
        qc.h(q)
    
    # Measurement:
    for q in range(2):
        qc.measure(q, q)
    
    return qc


#[C] Define randomized Pauli-wrapped circuit for depolarizing:
def randomize_circuit(base_qc, p):
    qc = QuantumCircuit(2, 2)

    for q in range(2):
        # [1] Random Pauli before::
        pauli_before = random.choice(paulis[1:]) if np.random.rand() < p else 'I'
        pauli_gates[pauli_before](qc, q)

    # [2] Append core logic (excluding original measurement)
    qc.compose(base_qc.remove_final_measurements(inplace=False), inplace=True)

    for q in range(2):
        # [3] Random Pauli after::
        pauli_after = random.choice(paulis[1:]) if np.random.rand() < p else 'I'
        pauli_gates[pauli_after](qc, q)

        # [4] Final measurement
        qc.measure(q, q)

    return qc

##################################
# Shots & Probability settings::  
###################################
shots = 1024  
p = 0.1 
qc = base_circuit_entangled()  ######
circuits = [randomize_circuit(qc, p) for _ in range(shots)]

# # Randomized circuit:
render = "\n🔧 Randomized Circuit with Depolarizing Noise"
def platform():
    if in_jupyter():
        cir = circuits[0].draw(output="mpl")
        display(Markdown(render))
        display(cir)
    else:
        title = render
        circ = circuits[0].draw(output="text")
        print(f"\n{title}\n")
        print(circ)

##########################################################################
# This is a single job execution with Qiskit Connector initialized objects
##########################################################################
if current == "Open Plan":
    platform()
    sampler = Sampler(mode=backend)  # Session not allowed in Open Plan
    # Transpile::
    circuits_t = [transpile(circ, backend=backend, optimization_level=3) for circ in circuits]
    job = sampler.run(circuits_t, shots=1)  # single run per-shot.
elif current == "Paid Plan":
    with Session(backend=backend.name) as session:
        platform()
        sampler = Sampler(mode=session)  # Session is allowed in Paid Plan
        # Transpile::
        circuits_t = [transpile(circ, backend=backend, optimization_level=3) for circ in circuits]
        job = sampler.run(circuits_t, shots=1)  # single run per-shot.
else:
    raise ValueError(f"Unknown plan type: {current}")

# Submit the job::
elapsed = 0
print()
try:
    print(f"-- REAL BACKEND JOB INFORMATION --")
    print(f"Assigned Backend QPU: {backend.name}")
    print(f"Number of circuits submitted to backend job: {len(circuits)}")
    print(f"Backend Job ID: {job.job_id()}")
    while not job.done():
        print(f"\r⏳ Job running... {elapsed} sec", end="", flush=True)
        time.sleep(1)
        elapsed += 1
except KeyboardInterrupt:
    print("\n⛔ Interrupted while waiting.")
    exit(0)
print("\r", end="", flush=True)

# Measurement:::
result = job.result()
counts_total = Counter()
for pub0 in result:
    counts = pub0.data.c.get_counts()
    counts_total.update(counts)
print("______________________________________________________________________________")
print(f"✅ Job Result:")
print(dict(counts_total))
```


#### Output Sample

<div align="center">
<img src="https://github.com/QComputingSoftware/pypi-qiskit-connector/blob/main/media/sample-output-0.png" alt="Qiskit Connector Sample Output 0"/><img src="https://github.com/QComputingSoftware/pypi-qiskit-connector/blob/main/media/sample-output-00.png" alt="Qiskit Connector Sample Output 00"/>
</div>



---
####  📜 Citation

Qiskit Connector software invention was inspired by IBM Research on Quantum Computing Qiskit Software, which led the authoring, design, development of Qiskit Connector based on the persistent research studies and tests carried out by  `Dr. Jeffrey Chijioke-Uche(IBM Quantum Ambassador & Research Scientist)` in the lab. This software is expected to continue to metamorphose with the help and work of existing quantum computing academic scholarly & peer reviewed research at different levels in the Information Technology industry. If you use Qiskit for Quantum computing, please cite this software as per the provided [BibTeX](https://github.com/QComputingSoftware/pypi-qiskit-connector/blob/main/CITATION.bib) file. Also, citation is available in the following formats: [Harvard](https://zenodo.org/records/15330579#citation), [APA](https://zenodo.org/records/15330579#citation), [MLA](https://zenodo.org/records/15330579#citation), [IEEE](https://zenodo.org/records/15330579#citation), [Chicago](https://zenodo.org/records/15330579#citation), & [Vancouver](https://zenodo.org/records/15330579#citation)

---

#### 📜 Software Author
Dr. Jeffrey Chijioke-Uche <br>
IBM Computer Scientist <br>
IBM Quantum Ambassador & Research Scientist <br>
IEEE Senior Member (Computational Intelligence)

---
#### 📜  Rights
The Quantum Computing Qiskit Connector is copyrighted and it is a proprietary software developed by Dr. Jeffrey Chijioke-Uche ©2025 - All Rights Reserved. The software is for enhancing development, usability, and workflows in IBM Quantum Computing systems by global users. This software is protected under copyright laws and applicable intellectual property statutes. Unauthorized reproduction, distribution, or derivative use of the software in part or whole is strictly prohibited without express written permission from the author. This software may be used under the terms outlined in the accompanying <b>licenses</b> by ([Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) and [Creative Commons Attribution 4.0 international](https://creativecommons.org/licenses/by/4.0/legalcode)). Use of this software signifies your agreement to comply with the license terms and to attribute the original author when incorporating the package into your work or systems. For other question(s), please contact the maintainer directly through the official project repository or email channel provided on PyPI. All Rights Reserved.
 

---

#### 📜 Acknowledgment
The development of the Qiskit Connector has been made possible through the support, inspiration, and technical contributions of several leading institutions and communities. The software author would like to express deep gratitude to [IBM Research & IBM Quantum Ambassadors Group](https://research.ibm.com/quantum-computing) for the pioneering efforts in quantum computing and providing the infrastructure and ecosystem that fostered the development of this software. Their continued support has significantly accelerated progress in real-world quantum computing and quantum application development for cutting edge technology advancement.
<br><br>
Additional appreciation is extended to the [IEEE Computational Intelligence](https://cis.ieee.org) Society for their thought leadership in intelligent systems, and to the  [Harvard Program for Research in Science and Engineering](https://www.harvard.edu/) for its role in shaping early research directions. The author also acknowledges [Walden University Research](https://academicguides.waldenu.edu/research-center) for providing a strong academic and methodological foundation throughout the software development lifecycle. These institutions have collectively influenced the innovation and rigor reflected in this project.

---

#### 📜 Licenses

This software uses these licenses for distribution:
- [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/legalcode)
