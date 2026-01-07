# @Author: Dr. Jeffrey Chijioke-Uche
# @Date: 2023-10-01     
# @Last Modified by:   Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2023-10-01
# @Description: This module contains tests for the Qiskit Connector package.
# @License: Apache License
# @Copyright (c) 2023 Dr. Jeffrey Chijioke-Uche
#____________________________________________________________________________

import platform
import subprocess
import sys

os_types = ["ubuntu-latest", "ubuntu-24.04", "ubuntu-22.04", "macos-latest", "macos-14", "macos-15", "windows-latest", "windows-2022", "windows-2019"]

# Test 1:
def test_install_qiskit_connector_on_os_consume_v1():
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

# Test 2:
def test_install_qiskit_connector_on_os_consume_v2():
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

# Test 3:
def test_install_qiskit_connector_on_os_consume_v3():
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

# Test 4:
def test_install_qiskit_connector_on_os_consume_v4():
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

# Test 5:
def test_install_qiskit_connector_on_os_consume_v5():
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