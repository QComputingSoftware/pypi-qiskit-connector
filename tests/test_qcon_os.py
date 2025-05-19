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
import requests
from bs4 import BeautifulSoup

# Test 1:
def test_fetch_latest_versions_0(package_url, limit=10):
    response = requests.get(package_url)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, "html.parser")
    versions = []
    for release in soup.select("a.card.release__card"):
        version = release.find("p", class_="release__version").text.strip()
        versions.append(version)
    return versions[:limit]

# Test 2:
def test_make_install_test_0(version, idx):
    def test_func():
        os_type = platform.system()
        print(f"Running installation test {idx} on: {os_type}")
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
    test_func.__name__ = f"test_install_qiskit_connector_on_os_t0{idx}"
    return test_func

# ------------------------
# PYTEST UNIT TESTS BELOW:
# ------------------------

# Test 1:
def test_fetch_latest_versions_0():
    url = "https://pypi.org/project/qiskit-connector/#history"
    versions = test_fetch_latest_versions_0(url, 5)
    print("Fetched versions:", versions)
    # Check we have at least 1 version and they look like version strings
    assert len(versions) > 0
    assert all(isinstance(v, str) and "." in v for v in versions)

def test_make_install_test():
    url = "https://pypi.org/project/qiskit-connector/#history"
    versions = test_fetch_latest_versions_0(url, 1)
    assert versions, "No versions found"
    version = versions[0]
    idx = 1
    fn = test_make_install_test_0(version, idx)
    assert callable(fn)
    assert fn.__name__ == "test_install_qiskit_connector_on_os_t1"


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

# Test 6:
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

# Test 7:
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

# Test 8:
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