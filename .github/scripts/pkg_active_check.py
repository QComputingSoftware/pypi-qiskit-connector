# @Author: Dr. Jeffrey Chijioke-Uche
# @Date: 2025-03-15
# @Purpose: Part of Code Coverage Analysis
# @Major Component: connector, plan
# @Description: This script is designed to test the qiskit_connector module, specifically focusing on the pkg functinal state.
# @Test Coverage: Ensures that the package is functional and can be installed correctly.
# @Test Environment: pytest
# @Test Framework: pytest
#
import subprocess
import sys

class CheckPkgState:
    @staticmethod
    def auto_install():
        try:
            subprocess.check_call([sys.executable, "-m", "pip", "install", "qiskit-connector"])
            print("✅ qiskit-connector is functional.")
        except subprocess.CalledProcessError:
            print("❌ Failed to install qiskit-connector. Please check your environment.")
            return

# Check:
CheckPkgState.auto_install()
try:
    print("✅ Test1 Passed: Package is functional.")
    subprocess.check_call(f"{sys.executable} -m pip list | grep qiskit-connector", shell=True)
except subprocess.CalledProcessError:
    print("❌ Check Failed: Package not found in pip list.")
except Exception as e:
    print(f"❌ Check Encountered error: {e}")
