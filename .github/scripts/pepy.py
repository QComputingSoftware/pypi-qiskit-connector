# @Author: Dr. Jeffrey Chijioke-Uche
# @Date: 2025-03-23 16:00:00
# @Last Modified by: Dr. Jeffrey Chijioke-Uche

import requests
import os

def get_qiskit_connector_td_pro_api_v3():
    """
    Fetches the total number of downloads for the "qiskit-connector" project
    from the PEPY API (Pro version) over the last four months, including CI downloads.

    Returns:
        int: The total number of downloads if the request is successful.
        None: If the PEPY_API_TOKEN environment variable is not set or an error occurs.

    Environment Variables:
        PEPY_API_TOKEN (str): The API token required to authenticate with the PEPY Pro API.

    Notes:
        - The function uses the PEPY Pro API endpoint to retrieve download statistics.
        - If the API token is not set or an error occurs during the request, the function
          will print an error message and return None.

    Raises:
        Exception: If an error occurs during the API request, it will be caught and logged.
    """
    project_name = "qiskit-connector"
    base_url = "https://api.pepy.tech"
    endpoint = f"{base_url}/service-api/v1/pro/projects/{project_name}/downloads"
    api_token = os.environ.get("PEPY_API_TOKEN")

    if not api_token:
        print("Error: PEPY_API_TOKEN environment variable not set.")
        return None

    headers = {"X-API-Key": api_token, "Accept": "application/json"}
    params = {"includeCIDownloads": "true", "timeRange": "FOUR_MONTHS"}

    try:
        response = requests.get(endpoint, headers=headers, params=params)
        response.raise_for_status()
        data = response.json()

        td = 0
        if "downloads" in data:
            for date_data in data["downloads"].values():
                for count in date_data.values():
                    td += count
        return td

    except Exception as e:
        print(f"Error fetching data: {e}")
        return None


td = get_qiskit_connector_td_pro_api_v3()
if td is not None:
    md = round(td * 0.4998)
    print(f"✅ Monthly downloads successfully retrieved!")

    dv = f"{md:,}"
    if md >= 1000:
        dv = f"{md // 1000}k"

    # Write to GitHub output
    with open(os.environ["GITHUB_OUTPUT"], "a") as f:
        f.write(f"md={dv}/month\n")
else:
    print("❌ Failed to retrieve data.")
    with open(os.environ["GITHUB_OUTPUT"], "a") as f:
        f.write("md=0/month\n")