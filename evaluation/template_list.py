import argparse
from promptsource.templates import DatasetTemplates

template_list = {
    ("super_glue", "rte"): [
        "MNLI crowdsource",
        "guaranteed true",
        "can we infer",
        "GPT-3 style",
        "does this imply",
        "should assume",
        "does it follow that",
        "based on the previous passage",
        "justified in saying",
        "must be true",
    ],
    ("super_glue", "cb"): [
        "can we infer",
        "based on the previous passage",
        "claim true/false/inconclusive",
        "does it follow that",
        "justified in saying",
        "always/sometimes/never",
        "GPT-3 style",
        "consider always/sometimes/never",
        "guaranteed true",
        "must be true",
        "guaranteed/possible/impossible",
        "does this imply",
        "MNLI crowdsource",
        "should assume",
        "take the following as truth",
    ],
    ("anli", None): [
        "MNLI crowdsource",
        "should assume",
        "does it follow that",
        "GPT-3 style",
        "based on the previous passage",
        "justified in saying",
        "take the following as truth",
        "must be true",
        "can we infer",
        "guaranteed/possible/impossible",
        "always/sometimes/never",
        "does this imply",
        "consider always/sometimes/never",
        "claim true/false/inconclusive",
        "guaranteed true",
    ],
    ("super_glue", "wsc.fixed"): [
        "does the pronoun refer to",
        "by p they mean",
        "in other words",
        "I think they mean",
        "does p stand for",
        "GPT-3 Style",
        "replaced with",
        "p is/are r",
        "the pronoun refers to",
        "Who or what is/are",
    ],
    ("winogrande", "winogrande_xl"): [
        "does underscore refer to",
        "stand for",
        "underscore refer to",
        "fill in the blank",
        "Replace",
    ],
    ("story_cloze", "2016"): [
        "Answer Given options",
        "Choose Story Ending",
        "Movie What Happens Next",
        "Story Continuation and Options",
        "Novel Correct Ending",
    ],
    ("super_glue", "wic"): [
        "question-context-meaning-with-label",
        "question-context-meaning",
        "grammar_homework",
        "affirmation_true_or_false",
        "GPT-3-prompt",
        "same_sense",
        "question-context",
        "GPT-3-prompt-with-label",
        "polysemous",
        "similar-sense",
    ],
    ("hellaswag", None): [
        "Predict ending with hint",
        "Randomized prompts template",
        "complete_first_then",
        "if_begins_how_continues",
    ],
    ("super_glue", "copa"): [
        "exercise",
        "…What could happen next, C1 or C2?",
        "i_am_hesitating",
        "plausible_alternatives",
        "C1 or C2? premise, so/because…",
        "…As a result, C1 or C2?",
        "best_option",
        "…which may be caused by",
        "more likely",
        "cause_effect",
        "…why? C1 or C2",
        "choose",
    ]
}

def main():

    parser = argparse.ArgumentParser(description="Reproduce main evaluation in T0.")
    parser.add_argument(
        "--prompt_template",
        type=str,
        default=None,
        help="The name of the dataset to use (via the datasets library).",
        required=True,
    )
    args = parser.parse_args()

    prompt_template=args.prompt_template
    prompts = DatasetTemplates(prompt_template)
    prompt_names = list(prompts.name_to_id_mapping.keys())
    cnt = 0
    for prompt_name in prompt_names:
        if prompts[prompt_name].metadata.original_task:
            print("\"", prompt_name, "\"", sep="",  end=" ")
            cnt += 1
    print()
    print(cnt)

if __name__ == "__main__":
    main()