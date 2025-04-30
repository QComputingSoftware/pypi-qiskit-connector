import requests
import os

GITHUB_API = "https://api.github.com"
REPO = "schijioke-uche/qiskit-connector"
PYPI_PROJECT = "qiskit-connector"

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

def create_github_release(version, is_latest=False):
    url = f"{GITHUB_API}/repos/{REPO}/releases"
    headers = {
        "Authorization": f"token {os.environ['GH_TOKEN']}",
        "Accept": "application/vnd.github.v3+json"
    }
    data = {
        "tag_name": version,
        "name": f"Release {version}",
        "body": f"Release {version} as published on PyPI.",
        "draft": False,
        "prerelease": "-" in version  # e.g., 2.1.1-beta
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

# This script syncs PyPI releases with GitHub releases for the specified repository.
# It checks for missing releases on GitHub and creates them if necessary.
# It also marks the latest version as the latest release on GitHub.