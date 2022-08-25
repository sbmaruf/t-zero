DATASET_NAME="xnli"
DATASET_CONFIG_NAME="en"
for MODEL_SIGNATURE in "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmixlossseq" "tr13f-6b3-ml-t0-lmtoks341b-t0toks13b-xp3capmix" ; do
    MODEL_NAME_OR_PATH="bigscience/$MODEL_SIGNATURE"
    mkdir -p $MODEL_NAME_OR_PATH
    for TEMPLATE_NAME in "take the following as truth" "does this imply" "GPT-3 style" "does it follow that" "based on the previous passage" "guaranteed true" "should assume" "must be true" "can we infer" "justified in saying" "claim true/false/inconclusive" "consider always/sometimes/never" "always/sometimes/never" "guaranteed/possible/impossible" "MNLI crowdsource" ; 
        do
        TASK_FLAG=${TASK_NAME//[\/]/_}
        OUTPUT_DIR=$MODEL_SIGNATURE/$TASK_FLAG"_"$DATASET_CONFIG_NAME"_"$TEMPLATE_NAME
        if [ ! -d $OUTPUT_DIR ] 
            then
            mkdir -p $OUTPUT_DIR
            python run_eval.py \
            --dataset_name $DATASET_NAME \
            --dataset_config_name $DATASET_CONFIG_NAME \
            --template_name $TEMPLATE_NAME \
            --model_name_or_path $MODEL_NAME_OR_PATH \
            --output_dir $OUTPUT_DIR
        fi
    done
done
