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
import platform
import subprocess
import sys

def install_and_assert(version):
    os_type = platform.system()
    print(f"Running installation test on: {os_type}")
    print(f"Attempting to install qiskit-connector=={version}")
    try:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", f"qiskit-connector=={version}"],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        print(result.stdout.decode())
        assert result.returncode == 0, f"Installation failed on {os_type} for version {version}"
    except subprocess.CalledProcessError as e:
        print(e.stderr.decode())
        assert False, f"Installation test failed on {os_type} for version {version}: {e}"

#Test 1:
def test_make_install_test_2_2_6():
    install_and_assert("2.2.8")

# Test 2:
def test_make_install_test_2_2_5():
    install_and_assert("2.2.7")

# Test 3:
def test_make_install_test_2_2_4():
    install_and_assert("2.2.6")

# Test 4:
def test_make_install_test_2_2_3():
    install_and_assert("2.2.3")

# Test 5:
def test_make_install_test_2_2_2():
    install_and_assert("2.2.2")

# Test 6:
def test_make_install_test_2_2_1():
    install_and_assert("2.2.1")

# Test 7:
def test_make_install_test_2_2_0():
    install_and_assert("2.2.0")

# Test 8:
def test_make_install_test_2_1_9():
    install_and_assert("2.1.9")

# Test 9:
def test_make_install_test_2_1_8():
    install_and_assert("2.1.8")

# Test 10:
def test_make_install_test_2_1_7():
    install_and_assert("2.1.7")

# Test 11:
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

# Test 12:
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

# Test 13:
def test_install_qiskit_connector_on_os_consume_v6():
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

# Test 14:
def test_install_qiskit_connector_on_os_consume_v7():
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

# Test 15:
def test_install_qiskit_connector_on_os_consume_v8():
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