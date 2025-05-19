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

def fetch_latest_versions(package_url, limit=10):
    response = requests.get(package_url)
    response.raise_for_status()
    soup = BeautifulSoup(response.text, "html.parser")
    versions = []
    for release in soup.select("a.card.release__card"):
        version = release.find("p", class_="release__version").text.strip()
        versions.append(version)
    return versions[:limit]

# Fetch first 10 most recent versions at import time
VERSIONS_TO_TEST = fetch_latest_versions("https://pypi.org/project/qiskit-connector/#history", 10)

def make_install_test(version, idx):
    def test_func():
        os_type = platform.system()
        print(f"Running installation test {idx} on: {os_type} for qiskit-connector=={version}")
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
    test_func.__name__ = f"test_install_qiskit_connector_on_os_t{idx}"
    return test_func

# Dynamically create and register 10 tests
for idx, version in enumerate(VERSIONS_TO_TEST, 1):
    globals()[f"test_install_qiskit_connector_on_os_t{idx}"] = make_install_test(version, idx)

