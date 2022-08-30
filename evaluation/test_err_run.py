import os
import argparse
import subprocess

parser = argparse.ArgumentParser(description="Find and clean failed experiment.")
parser.add_argument(
        "--delete",
        action="store_true",
        help="delete the failed experiment folders."
    )
args = parser.parse_args()

folders = "dumped"
cnt = 0
model_folders = os.listdir(folders)
for model_folder in model_folders:
    full_model_folder = os.path.join(folders, model_folder)
    for exp in os.listdir(full_model_folder):
        full_exp_path = os.path.join(full_model_folder, exp)
        res_file = os.path.join(full_exp_path, "results.json")
        if not os.path.exists(res_file):
            print(full_exp_path)
            cmd = "rm -rf {}".format(full_exp_path)
            cnt += 1
            if args.delete:
                subprocess.check_output(cmd, shell=True)


print(cnt)
