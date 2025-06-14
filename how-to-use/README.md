
# Qiskit Connector

##### How to Use Qiskit Connector - Sample Codes Guide

---

## Overview

**Qiskit Connector** is a cutting-edge Python library designed to seamlessly bridge quantum algorithm development with real quantum hardware backends. Tailored for production environments and enterprise-grade quantum computing applications, it empowers developers and researchers to rapidly prototype, test, and deploy quantum circuits workloads using the latest IBM Quantum backends with minimal overhead.

This document provides curated sample codes demonstrating how to harness Qiskit Connector for creating entangled quantum circuits, applying noise models, executing jobs on real quantum processors, and efficiently retrieving and visualizing results.

The samples in this directory are in two versions:
- Raw Python sample  [sample.py](https://github.com/QComputingSoftware/pypi-qiskit-connector/blob/main/how-to-use/sample.py)
- Raw Python sample  [sample.ipynb](https://github.com/QComputingSoftware/pypi-qiskit-connector/blob/main/how-to-use/sample.ipynb)

######  Setup
- [Install Qiskit Connector With PyPi](https://pypi.org/project/qiskit-connector)
- [Review The Environment Variables Required](https://github.com/QComputingSoftware/pypi-qiskit-connector?tab=readme-ov-file#%EF%B8%8F-variable-setup)
- [Get your IBM Quantum Plan Information](https://quantum.cloud.ibm.com/instances)

Note: If using Open plan, the OPEN_PLAN_INSTANCE variable must be the full instance CRN.
---

## Key Features

- **Seamless Integration with IBM Quantum Backends in realtime**  
  Easily connect and run quantum workloads on IBM's quantum processors with either IBM’s paid and open plans.

- **Advanced Circuit Construction**  
  Create complex, entangled circuits with built-in support for superposition, entanglement, and noise injection through randomized Pauli gates.

- **Optimized Transpilation**  
  Benefit from high-level transpilation strategies tailored to backend-specific constraints and optimization levels.

- **Dynamic Job Management**  
  Robust job submission and monitoring with live queue status, progress spinners, and graceful interruption handling.

- **Versatile Result Processing & Visualization**  
  Aggregate measurement data from multiple circuits and render intuitive histograms both in terminal and Jupyter environments.

---

## Sample Workflow

```python
from qiskit_connector import QConnectorV2 as connector
from qiskit_connector import QPlanV2 as plan
from qiskit import QuantumCircuit, transpile
from qiskit_ibm_runtime import SamplerV2 as Sampler, Session

# Initialize connector and plan
current = plan()
backend = connector()

# Define entangled base circuit with superposition and CNOT entanglement
def base_circuit():
    qc = QuantumCircuit(2, 2)
    for q in range(2):
        qc.h(q)
        qc.rx(0.5, q)
        qc.rz(1.0, q)
        qc.s(q)
        qc.t(q)
        qc.h(q)
    qc.cx(0, 1)
    qc.measure([0, 1], [0, 1])
    return qc

# Create randomized circuits with depolarizing noise model
def randomize_circuit(base_qc, p):
    qc = QuantumCircuit(2, 2)
    # Apply randomized Pauli gates before and after the base circuit
    # ... [pauli gate application code here] ...
    return qc

# Prepare circuits
rand_range = 5
p = 0.1
qc = base_circuit()
circuits = [randomize_circuit(qc, p) for _ in range(rand_range)]

# Transpile and submit jobs
qc_t = [transpile(c, backend=backend, optimization_level=3) for c in circuits[:rand_range]]
if current == "Open Plan":
    sampler = Sampler(mode=backend)
    job = sampler.run(qc_t, shots=1)
elif current == "Paid Plan":
    with Session(backend=backend.name) as session:
        sampler = Sampler(mode=session)
        job = sampler.run(qc_t, shots=1)

# Monitor job and retrieve results, then display histograms
# ...

