#############################
## Snakefile for multiDUMP ##
#############################

from typing import List
import pathlib
import re
import numpy
import os
import pandas as pd
from itertools import combinations

### Function to handle the values for the wilcards
def constraint_to(values: List[str]) -> str:
    """
    From a list, return a regular expression allowing each
    value and not other.
    ex: ["a", "b", "v"] -> (a|b|v)
    """
    if isinstance(values, str):
            raise ValueError("constraint_to(): Expected a list, got str instead")
    return "({})".format("|".join(values))

### working diirectory
home_dir = os.path.join(config["OUTDIR"],"")
shell('mkdir -p {home_dir}')
workdir: home_dir

### read List
file_table = pd.read_csv(str(config["TABLE"]),  sep='\t+', engine='python')
fastq = list(numpy.unique(list(file_table.iloc[:,0])))
new_name = list(numpy.unique(list(file_table.iloc[:,1])))

### generation of global wildcard_constraints
wildcard_constraints:
    NEWNAME = constraint_to(new_name)


# ========================================================================================
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ========================================================================================
# Function to run all funtions
rule AAA_initialization:
    input:
        fastq_R1 = expand(''.join(["{newName}", config["SUFFIX"][0], config["EXTENSION"]]), newName=new_name)
    shell:
        """
        printf '\033[1;36mDownload finished!\\n\033[0m'
        """
# ========================================================================================
# >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# ========================================================================================

# ----------------------------------------------------------------------------------------
if (len(fastq) == len(new_name)):
    rule download_fastq:
        input:
            file_table = config["TABLE"]
        output:
            R1_new = ''.join(["{NEWNAME}", config["SUFFIX"][0], config["EXTENSION"]])
        params:
            rename = "{NEWNAME}",
            R2_new = ''.join(["{NEWNAME}", config["SUFFIX"][1], config["EXTENSION"]])
        threads: 1
        shell:
            """
            printf '\033[1;36mDownloading {params.rename}...\\n\033[0m'

            SRA_ID=$(grep -w {params.rename} {input.file_table} | cut -f1)

            fastq-dump --split-3 --gzip ${{SRA_ID}}

            NUM=$(ls ${{SRA_ID}}* | wc -l)

            if [[ $NUM -eq 1 ]]
            then
                mv ${{SRA_ID}}.fastq.gz {output.R1_new}
            else
                mv ${{SRA_ID}}_1.fastq.gz {output.R1_new}
                mv ${{SRA_ID}}_2.fastq.gz {params.R2_new}
            fi
            """
else:
    shell("printf '\033[1;31mThe ID for the renaming is not unique for each fastq file. Check the second column of your input table!!!\\n\033[0m'")
# ----------------------------------------------------------------------------------------
