#!/usr/bin/env python3

import json
import sys
from pathlib import Path

def modify_src_dst_by_name(name: str):
    """Modify the source and dest data dict by name."""
    for d in source_data["Profiles"]:
        if d["Name"] == name:
            src_d = d

    for i, d in enumerate(dest_data["Profiles"]):
        if d["Name"] == name:
            index = i

    # Delete old profile
    del dest_data["Profiles"][index]

    # Add new profile
    dest_data["Profiles"].append(src_d)
    # dest_data["Profiles"][-1]["Tags"]

def check_file_exists(filename: Path):
    if not filename.exists():
        print(f"{filename} does not exist.")
        sys.exit(1)


if __name__ == "__main__":
    input_file = "Profiles.json"
    dest_file = "Bart.json"
    try:
        i = sys.argv[1]
    except IndexError:
        print("Using default input file: Profiles.json")
    else:
        input_file = i

    path_input_file = Path(input_file)
    path_dest_file = Path(dest_file)

    check_file_exists(path_input_file)
    check_file_exists(path_dest_file)

    print("Start modifying iterm2 profile, based on new export.")
    print(f"Source: {path_input_file}, Destination: {path_dest_file}.")
    source_data = json.load(path_input_file.open("r"))
    dest_data = json.load(path_dest_file.open("r"))
    modify_src_dst_by_name("Bart")
    modify_src_dst_by_name("Hotkey Window")

    print(f"writing to file: {dest_file}")
    path_dest_file.write_text(json.dumps(dest_data, indent=2))
    print("Done")