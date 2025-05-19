# @Author: Dr. Jeffrey Chijioke-Uche
# @Purpose: Test qiskit-connector versions from matrix

import os
import subprocess
import sys
import platform
import pytest

# Get version from GitHub Actions matrix environment
QISKIT_VERSION = os.getenv("QISKIT_CONNECTOR_VERSION", "").strip()

@pytest.mark.skipif(QISKIT_VERSION == "", reason="No QISKIT_CONNECTOR_VERSION provided.")
def test_qiskit_connector_version_installation():
    os_type = platform.system()
    print(f"🧪 Running installation test on {os_type} for version {QISKIT_VERSION}")

    try:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", f"qiskit-connector=={QISKIT_VERSION}"],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print(result.stdout.decode())
        assert result.returncode == 0, f"Installation failed on {os_type}"
    except subprocess.CalledProcessError as e:
        print(e.stderr.decode())
        assert False, f"Installation test failed on {os_type}: {e}"
