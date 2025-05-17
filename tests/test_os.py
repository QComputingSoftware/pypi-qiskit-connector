
import platform
import subprocess
import sys

def test_install_qiskit_connector_on_os():
    os_type = platform.system()
    print(f"Running installation test on: {os_type}")

    try:
        # Attempt pip installation simulation
        result = subprocess.run([sys.executable, "-m", "pip", "install", "qiskit-connector"], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(result.stdout.decode())
        assert result.returncode == 0, f"Installation failed on {os_type}"
    except subprocess.CalledProcessError as e:
        print(e.stderr.decode())
        assert False, f"Installation test failed on {os_type}: {e}"
