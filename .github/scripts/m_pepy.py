# @Author: Dr. Jeffrey Chijioke-Uche
# @Date: 2025-03-23 16:00:00
# @Last Modified by: Dr. Jeffrey Chijioke-Uche
#=============================================

import os
import pathlib
import requests
from datetime import datetime

def safe_join(base, *paths):
    """
    Safely join one or more path components to the base directory,
    raising ValueError if the final path escapes the base.
    """
    base = pathlib.Path(base).resolve()
    final = base.joinpath(*paths).resolve()
    if not str(final).startswith(str(base)):
        raise ValueError("Unsafe path detected! Refusing to write.")
    return final

def get_qiskit_connector_td_pro_api_v3():

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

def iCal_Monthly():
    """
    Calculates the average monthly app downloads using Unix epoch timestamps.
    """
    # --- Input Data from pepy API ---
    initial_release_date_str = "April 24, 2025"
    now_date_obj = datetime.today()
    from_date_obj = datetime.strptime(initial_release_date_str, "%B %d, %Y")
    epoch_from = from_date_obj.timestamp()
    epoch_now = now_date_obj.timestamp()

    print(f"Qiskit Connector Initial Release Date: {initial_release_date_str}  -> epoch_from: {int(epoch_from)}")
    print(f"As of Date:   {now_date_obj.strftime('%B %d, %Y')}  -> epoch_now:  {int(epoch_now)}\n")

    duration_seconds = epoch_now - epoch_from
    if duration_seconds <= 0:
        return 0  

    rate_per_second = td / duration_seconds

    seconds_in_avg_month = 30.44 * 24 * 60 * 60

    monthly_downloads = rate_per_second * seconds_in_avg_month

    return monthly_downloads

try:
    if td is not None:
        print(f"✅ Monthly downloads successfully retrieved!")
        # md = round(td * 0.4998)
        iCal_md = iCal_Monthly()
        md = round(iCal_md)  # Monthly downloads
        wd = md // 4         # Weekly downloads
        dd = md // 30        # Daily downloads

        mv = f"{md:,}"
        wv = f"{wd:,}"
        dv = f"{dd:,}"
        if md >= 1000:
            mv = f"{md // 1000}k"
        if wd >= 1000:
            wv = f"{wd // 1000}k"
        if dd >= 1000:
            dv = f"{dd // 1000}k"

        # Write: safely
        safe_path = os.environ.get("GITHUB_OUTPUT")
        try:
            if safe_path:
                with open(safe_path, "a") as f:
                    f.write(f"md={mv}/month\n")

            else:
                raise ValueError("GITHUB_OUTPUT environment variable is not set in this parent base path or is empty.")
        except ValueError as e:
            safe_path = "Unknown"
            print(f"Unsafe path detected! Refusing to write. Safe path: {safe_path}")
            print(e)
    else:
        print("❌ Failed to retrieve data.")
except ValueError as e:
    print(f"Td error: {e}")