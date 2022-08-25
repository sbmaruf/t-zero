#!/bin/sh
#SBATCH -o logs/%j.out
#SBATCH -p PA100q
#SBATCH -n 1
#SBATCH --nodelist=node03
#SSSSSSBATCH --gres=gpu:1

module load cuda11.6/toolkit/11.6.0
source ~/anaconda3/bin/activate py3

export CUDA_VISIBLE_DEVICES=4

set -e

mkdir -p dumped
DATASET_NAME="xnli"
TEMPLATE_CONFIG_NAME="xnli/en"
for MODEL_SIGNATURE in "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmix" "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-p31"; do
    DATASET_CONFIG_NAME="en"
    MODEL_NAME_OR_PATH="bigscience/$MODEL_SIGNATURE"
    for TEMPLATE_NAME in "take the following as truth" "does this imply" "GPT-3 style" "does it follow that" "based on the previous passage" "guaranteed true" "should assume" "must be true" "can we infer" "justified in saying" "claim true/false/inconclusive" "consider always/sometimes/never" "always/sometimes/never" "guaranteed/possible/impossible" "MNLI crowdsource" ; 
        do
	TEMPLATE_CONFIG_FLAG=${TEMPLATE_CONFIG_NAME//[\/ ]/_}
	TEMPLATE_FLAG=${TEMPLATE_NAME//[\/ ]/_}
        OUTPUT_DIR="dumped"/$MODEL_SIGNATURE/$DATASET_NAME"_"$DATASET_CONFIG_NAME"_"$TEMPLATE_CONFIG_FLAG"_"$TEMPLATE_FLAG
        if [ ! -d $OUTPUT_DIR ] 
            then
            mkdir -p $OUTPUT_DIR
            python run_eval.py \
            --dataset_name $DATASET_NAME \
            --dataset_config_name $DATASET_CONFIG_NAME \
	    --dataset_split "test" \
            --template_config_name $TEMPLATE_CONFIG_NAME \
            --template_name "$TEMPLATE_NAME" \
            --model_name_or_path $MODEL_NAME_OR_PATH \
            --output_dir $OUTPUT_DIR
        fi
    done
done


for MODEL_SIGNATURE in "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmix" "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-p31"; do
    for DATASET_CONFIG_NAME in "en" "fr" "es" "de" "el"	"bg" "ru" "tr" "ar" "vi" "th" "zh" "hi"	"sw" "ur"; do
        MODEL_NAME_OR_PATH="bigscience/$MODEL_SIGNATURE"
        for TEMPLATE_NAME in "take the following as truth" "does this imply" "GPT-3 style" "does it follow that" "based on the previous passage" "guaranteed true" "should assume" "must be true" "can we infer" "justified in saying" "claim true/false/inconclusive" "consider always/sometimes/never" "always/sometimes/never" "guaranteed/possible/impossible" "MNLI crowdsource" ; 
            do
            TEMPLATE_CONFIG_FLAG=${TEMPLATE_CONFIG_NAME//[\/ ]/_}
            TEMPLATE_FLAG=${TEMPLATE_NAME//[\/ ]/_}
            OUTPUT_DIR="dumped"/$MODEL_SIGNATURE/$DATASET_NAME"_"$DATASET_CONFIG_NAME"_"$TEMPLATE_CONFIG_FLAG"_"$TEMPLATE_FLAG
	    if [ ! -d $OUTPUT_DIR ] 
                then
                mkdir -p $OUTPUT_DIR
                python run_eval.py \
                --dataset_name $DATASET_NAME \
                --dataset_config_name $DATASET_CONFIG_NAME \
		--dataset_split "test" \
                --template_config_name $TEMPLATE_CONFIG_NAME \
                --template_name "$TEMPLATE_NAME" \
                --model_name_or_path $MODEL_NAME_OR_PATH \
                --output_dir $OUTPUT_DIR
            fi
        done
    done
done


sbatch run_eval_pawsx_04.sh