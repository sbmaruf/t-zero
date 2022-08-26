import os
import subprocess

folders = "dumped"
model_folders = os.listdirs(folders)
for model_folder in model_folders:
    full_model_folder = os.path.join(folders, model_folder)
    for exp in os.listdir(full_model_folder):
        full_exp_path = os.path.join(folders, model_folder)
        res_file = os.path.join(full_exp_path, "results.json")
        if not os.path.exists(res_file):
            print(full_exp_path)
            cmd = "rm -rf {}".format(full_exp_path)
            # subprocess.check_output(cmd, shell=True)