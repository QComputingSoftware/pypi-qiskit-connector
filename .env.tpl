# @author: Dr. Jeffrey Chijioke-Uche, IBM Quantum Ambassador & Researcher
# This file is used to store environment variables for the Qiskit installation wizard: Update it.
# The "ibm_quantum" channel option is deprecated and will be sunset on 1 July 2025. 
# After this date, ibm_cloud will be the only valid channel. 
# For information on migrating to the new IBM Quantum Platform on the "ibm_cloud" channel, 
# review the migration guide https://quantum.cloud.ibm.com/docs/migration-guides/classic-iqp-to-cloud-iqp .


# GENERAL PURPOSE
#--------------------------------------------
IQP_API_TOKEN="<PROVIDE_YOUR_API_TOKEN>"  # Your IBM Quantum API token. You can get it from https://quantum-computing.ibm.com/account/api-token


# Channels:
#------------------------------------------
OPEN_PLAN_CHANNEL="<PROVIDE_YOUR_CHANNEL>"  # The channel for the Open Plan. Use "ibm_cloud" for free plans.
PAID_PLAN_CHANNEL="<PROVIDE PAID PLAN CHANNEL>"  # After July 1, 2025, use ibm_cloud for Paid Plans.


# API Access:
#-------------------------------------
IQP_API_URL=<PROVIDE_YOUR_API_URL>  # The API URL. Defaults to https://quantum-computing.ibm.com/api (ibm_cloud) or https://quantum-computing.ibm.com/runtime/api (ibm_quantum)
IQP_RUNTIME_API_URL=<PROVIDE_YOUR_RUNTIME_API_URL>  # The API URL for runtime. Defaults to https://quantum-computing.ibm.com/runtime/api (ibm_cloud) or https://quantum-computing.ibm.com/runtime/api (ibm_quantum)


# Quantum Url:
#-------------------------------------
CLOUD_API_URL=<PROVIDE_YOUR_CLOUD_API_URL>  # The API URL. Defaults to https://cloud.ibm.com (ibm_cloud) or https://auth.quantum.ibm.com/api (ibm_quantum)"
QUANTUM_API_URL="<PROVIDE_YOUR_QUANTUM_API_URL>"  # The API URL. Defaults to https://quantum-computing.ibm.com/api (ibm_cloud) or https://quantum-computing.ibm.com/runtime/api (ibm_quantum)


# Instance:
#-------------------------------------
OPEN_PLAN_INSTANCE="<PROVIDE_YOUR_OPEN_PLAN_INSTANCE>"  # The instance for the Open Plan. Use "ibm-quantum-lear/ambassadors/2024-june-class" for free plans.
PAID_PLAN_INSTANCE="<PROVIDE_YOUR_PAID_PLAN_INSTANCE>"  # The instance for the Paid Plan. Use "ibm-quantum-lear/ambassadors/2024-june-class" for paid plans.


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
OPEN_PLAN="on"       # [Default & switched on] This plan is free - Signup :  https://quantum.cloud.ibm.com 
STANDARD_PLAN="off"   # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   
PREMIUM_PLAN="off"     # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   
DEDICATED_PLAN="off"  # This plan is paid. Switched "Off" by default - Turn it "on" after purchase.   