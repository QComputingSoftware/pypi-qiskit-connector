# qiskit-connector

**⚛️Qiskit Connector for IBM Quantum Backends in Realtime**

A Quantum helper package which streamlines authentication, plan detection, and backend selection for Qiskit RuntimeService. This connector prevents repeated writing of runtimeservice instead allows you to directly use the `backend` object all over your quantum application code in realtime. This package performs the following:
- Loads environment variables from config file (e.g. `.env`) to configure your IBM Quantum account plan and make the `backend` object available within your quantum application code for reuse in real-time.
- Detects your active plan (Open, Standard, Premium, Dedicated) and sets up the correct channel/instance.
- It has functions to save your account using its (`qiskit_smart`), to verify QPU resources using (`qpu_verify`, `is_verified`), and retrieve a ready-to-use backend using (`connector()`). Presents you with the least-busy backend to run your quantum application code in realtime instead of you using simulators.

###### 🐍 Package built and maintained by Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador & Research Scientist.
---

## 📋 Features & API

All of the following functions are available after you import the module:

```python
from qiskit_connector import (
    connector,
    plan_type
)
```

- **`qiskit_smart(plan_type: str)`**  
  Saves your IBM Quantum account into QiskitRuntimeService using the environment variables for the given plan (`"open"`, `"standard"`, `"premium"`, or `"dedicated"`).

- **`qpu_verify()`**  
  Lists available QPUs for your plan by querying `QiskitRuntimeService.backends()` or falling back to `paid_plans()` for paid plans.

- **`is_verified()`**  
  Verifies real‐time least-busy QPU for the active plan and prints details (name, qubit count, online date).

- **`connector() -> IBMBackend`**  
  **Main entry point**: Loads your saved account, picks the least busy QPU (or first available for open or paid plans), prints diagnostics, and returns an `IBMBackend` instance ready for circuit execution.

- **`plan_type() -> str`**  
  Returns either **"Open Plan"** or **"Paid Plan"** depending on your `.env` toggles.

---

## 🔧 Installation

```bash
pip install qiskit-connector
```

This will also pull in functionalities powered by:
- `qiskit>=2.0.0`  
  

and any other Qiskit dependencies. (Qiskit 1.x is not supported).

---

## 🗂️ Environment Variable Setup
🔐 Security Practice: Do not check-in `.env` or any environment variable files into version control. Add it to your .gitignore. During development, create a file named `.env` at your project root. The connector will automatically load it.Use the template below as the content of your .env file or variable config file.

```dotenv

# @author: Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador & Researcher
# This file is used to store environment variables for the Qiskit installation wizard: Update it.
# The "ibm_quantum" channel option is deprecated and will be sunset on 1 July 2025. 
# After this date, ibm_cloud will be the only valid channel. 
# For information on migrating to the new IBM Quantum Platform on the "ibm_cloud" channel, 
# review the migration guide https://quantum.cloud.ibm.com/docs/migration-guides/classic-iqp-to-cloud-iqp .


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
CLOUD_API_URL=<PROVIDE_YOUR_CLOUD_API_URL>  
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


# Switch "on" one plan: Use one or the other at a time. You cannot switch both on at the same time.
#--------------------------------------------------------------------------------------------------
OPEN_PLAN="on"        # [Default & switched on] This plan is free - Signup
STANDARD_PLAN="off"   # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   
PREMIUM_PLAN="off"    # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   
DEDICATED_PLAN="off"  # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   
```

> **⚠️ Only one** of `OPEN_PLAN`, `STANDARD_PLAN`, `PREMIUM_PLAN`, or `DEDICATED_PLAN` may be set to **"on"** at a time.

---

## 📖 Usage

### Open Plan (default free tier) and Paid Plan

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


## Sample Output
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


---
## Authors and Citation

Qiskit Connector was inspired, authored and brought about by the research carried out by Dr. Jeffrey Chijioke-Uche(IBM Quantum Ambassador & Research Scientist). This software is expected to continues to grow with the help and work of existing research at different levels in the Information Technology industry. If you use Qiskit for Quantum, please cite as per the provided BibTeX file.

---

## 📜 Software Publisher
Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador & Research Scientist (All Rights Reserved) 

---

## 📜 License

This project uses the MIT License


