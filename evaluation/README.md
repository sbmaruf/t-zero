# Reproducing evaluation

To reproduce the main numbers (Figure 4) we reported in the paper using PyTorch and 🤗 Transformers, you can use `run_eval.py`. The script works:
- on CPU (even though it will likely be very slow)
- on a single GPU (single process)
- on multiple GPUs in a distributed environment (multiple processes)
- on multiple GPUs with model parallelism (single process)

The results will be saved in a json file in the `output_dir` folder.

Here's the command to launch the evaluation on a single process:

```bash
python run_eval.py \
    --dataset_name super_glue \
    --dataset_config_name rte \
    --template_name "must be true" \
    --model_name_or_path bigscience/T0_3B \
    --output_dir ./debug
```

You are expected to modify the `dataset_name`, the `dataset_config_name` and the `template_name`. The list of templates per data(sub)set is available in [this file](template_list.py).

If you evaluate on ANLI (R1, R2 or R3), the `dataset_config_name` should be `dev_r1`, `dev_r2` or `dev_r3`.

To launch the evaluation in a distributed environment (multiple GPUs), you should use the `accelerate` launcher (please refer to [Accelerate](https://github.com/huggingface/accelerate) for installation):

```bash
accelerate run_eval.py \
    --dataset_name super_glue \
    --dataset_config_name rte \
    --template_name "must be true" \
    --model_name_or_path bigscience/T0_3B \
    --output_dir ./debug
```

When the model is too big to fit on a single GPU, you can use model parallelism to split it across multiple GPUs. You should add the flag `--parallelize` when calling the script:

```bash
python run_eval.py \
    --dataset_name super_glue \
    --dataset_config_name rte \
    --template_name "must be true" \
    --model_name_or_path bigscience/T0_3B \
    --output_dir ./debug \
    --parallelize
```

Note that this feature is still an experimental feature under 🤗 Transformers.

## Folder Naming

for all experiments in `dumped_trans` and `dumped` folder, 

```
"dumped_trans"/$MODEL_SIGNATURE/$DATASET_NAME"_"$DATASET_CONFIG_NAME"_"$TEMPLATE_CONFIG_FLAG"_"$TEMPLATE_FLAG
```

- `$MODEL_SIGNATURE` is the hf-model name. 
- `$DATASET_NAME` is the name of the the dataset (i.e., xnli)
- `$DATASET_CONFIG_NAME` is the subset of the hf-dataset (i.e., en)
- `$TEMPLATE_CONFIG_FLAG` is the name of the template directory. (i.e., xnli)
- `$TEMPLATE_FLAG` is the name of the subset directory at promptsource template directory. (i.e., en)

In the experiments we apply english prompt to target language. hence the above format. The translated prompt can be found in https://github.com/sbmaruf/promptsource

