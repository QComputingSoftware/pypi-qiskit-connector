# @Author: Dr. Jeffrey Chijioke-Uche, Computer Scientist, Quantum Computing
# @Date: 2023-10-01
# @Last Modified by: Dr. Jeffrey Chijioke-Uche
# @Last Modified time: 2025-05-22
# @Description: This script syncs PyPI releases with GitHub releases for the Qiskit Connector project.
# @Copyright ©2025 Qiskit Connector. All rights reserved.
#-------------------------------------------------------------------------------------

import requests
import os
import re
import sys
from datetime import datetime

GITHUB_API = "https://api.github.com"
REPO = "QComputingSoftware/pypi-qiskit-connector"
PYPI_PROJECT = "qiskit-connector"
NOTE_FILE = os.path.join(os.path.dirname(__file__), "DESCRIPTOR.s")
with open(NOTE_FILE, encoding="utf-8") as qcon:
    QCON_NOTE = qcon.read()

def get_pypi_versions():
    url = f"https://pypi.org/pypi/{PYPI_PROJECT}/json"
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()
    return sorted(data["releases"].keys(), reverse=True)

def get_github_releases():
    url = f"{GITHUB_API}/repos/{REPO}/releases"
    headers = {"Authorization": f"token {os.environ['GH_TOKEN']}"}
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return [release["tag_name"] for release in response.json()]

prohibited_tag_list = ["main", "master", "stable", "dev", "test", "bug", "qa", "pypi", "lab", "prod"]
def check_prohibited_tag(version):
    for bad in prohibited_tag_list:
        if bad.lower() in version.lower():
            print(f"🚫 Version '{version}' violates prohibited tag list ('{bad}').")
            print(f"🚫 Version '{version}' is not eligible!")
            sys.exit(1)
    print(f"✅ Version '{version}' is eligible!")

def create_github_release(version, is_latest=False):
    check_prohibited_tag(version)
    url = f"{GITHUB_API}/repos/{REPO}/releases"
    headers = {
        "Authorization": f"token {os.environ['GH_TOKEN']}",
        "Accept": "application/vnd.github.v3+json"
    }

    changelog_date = datetime.utcnow().strftime("%Y-%m-%d")
    body_html = QCON_NOTE.format(version=version, changelog_date=changelog_date)
    body_header = f"Quantum Computing Qiskit Connector® - Real-Time Connector for IBM Quantum Computing QPU.\n\n"
    prerelease = bool(re.search(r"-(rc|beta|alpha)[0-9]*$", version))

    data = {
        "tag_name": version,
        "name": f"Qiskit Connector {version}",
        "body": f"{body_header}{body_html}",
        "draft": False,
        "generate_release_notes": True,
        "prerelease": prerelease
    }

    response = requests.post(url, headers=headers, json=data)
    if response.status_code == 201:
        print(f"✅ Created GitHub release for version {version}")
        if is_latest:
            print(f"🏷️  Marked version {version} as the latest.")
    elif response.status_code == 422:
        print(f"⚠️ Release {version} already exists. Skipping...")
    else:
        print(f"❌ Unexpected error creating release {version}: {response.status_code}")
        print(response.json())
        response.raise_for_status()


def main():
    pypi_versions = get_pypi_versions()
    github_releases = get_github_releases()
    latest_version = pypi_versions[0]

    missing_versions = [v for v in pypi_versions if v not in github_releases]

    if not missing_versions:
        print("✅ All PyPI releases already exist on GitHub.")
    else:
        for version in missing_versions:
            is_latest = version == latest_version
            create_github_release(version, is_latest=is_latest)

if __name__ == "__main__":
    main()
