[![Snakemake](https://img.shields.io/badge/snakemake-≥7.20.0-brightgreen.svg)](https://snakemake.github.io)
![release](https://img.shields.io/github/v/release/sebastian-gregoricchio/multiDUMP)
[![license](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://sebastian-gregoricchio.github.io/multiDUMP/LICENSE.md/LICENSE)
[![forks](https://img.shields.io/github/forks/sebastian-gregoricchio/multiDUMP?style=social)](https://github.com/sebastian-gregoricchio/multiDUMP/fork)
<!-- ![update](https://badges.pufler.dev/updated/sebastian-gregoricchio/multiDUMP)
![visits](https://badges.pufler.dev/visits/sebastian-gregoricchio/multiDUMP)
![downloads](https://img.shields.io/github/downloads/sebastian-gregoricchio/multiDUMP/total.svg)--->

<h1> multiDUMP </h1>

-------------------------

* TOC
{:toc}

--------------------------

## Introduction
`multiDUMP` is simple snakemake based pipeline to parallelize the download of SRA data through `fastq-dump`.


### Citation
If you use this package, please acknowledge `Sebastian Gregoricchio` in your paper.


## Installation an dependencies
To install the pipeline it is required to download this repository and the installation of a conda environment is strongly recommended.
Follow the steps below for the installation:
* place yourself in the directory where the repository should be downloaded by typing `cd </target/folder>`
* download the GitHub repository with `git clone https://github.com/sebastian-gregoricchio/multiDUMP`, or click on *Code > Download ZIP* on the [GitHub page](https://github.com/sebastian-gregoricchio/multiDUMP)
* install the conda environment from the .yaml environment file contained in the repository:<br>
`conda env create -f </target/folder>/multiDUMP/workflow/envs/multiDUMP_env.yaml`
* activate the conda environment: `conda activate multiDUMP` (if the env is not activated the pipeline won't work properly)

Notice that if you are encountering problems in the installation via `conda`, try to use `mamba` instead.

<br/><br/>


## How to run the pipeline
To download a list of SRA numbers what you need is to prepare a sample configuration table with the SRA number and the corresponding name to assign to the corresponding fastq files:

| *SRA_ID*  | *sample_name* |
|:----------|:--------------|
| SRR125346 |    sampleA    |
| SRR578951 |    sampleB    |


Then, upon conda environment activation, run the following commands (one can use the `-n` flag for a dry run):

```shell
snakemake \
-s </target/folder>/multiDUMP/workflow/multiDUMP.snakefile  \
--cores 5 \
--config \
TABLE="/path/to/sample_config_table.txt" \
OUTDIR="/full/path/to/output/directory" \
SUFFIX="['_R1', '_R2']" \
EXTENSION=".fastq.gz"
```

Where the config flags correspond to:

* **TABLE**: the full path to the sample configuration table
* **OUTDIR**: full path to the output directory
* **SUFFIX**: a python-formatted list with the suffix to use for the read1 (R1) and read2 (R2) files, respectively
* **EXTENSION**: the extension to use for the fastq files (the fastq-dump default is `fastq.gz`)


Alternatively to the manual `--config` flags one can provide a .yaml file as follows:

```
TABLE = "/path/to/sample_config_table.txt"
OUTDIR = "/full/path/to/output/directory"
SUFFIX = ['_R1', '_R2']
EXTENSION = ".fastq.gz"
```

And run the following code:

```shell
snakemake \
-s </target/folder>/multiDUMP/workflow/multiDUMP.snakefile  \
--cores 5 \
--configfile /path/to/config.yaml
```


<br>

## Collect several SRA accession numbers [<img src="https://raw.githubusercontent.com/sebastian-gregoricchio/sebastian-gregoricchio.github.io/main/generic_resources/vignette.svg" align="right" height = 125/>](https://sebastian-gregoricchio.github.io/multiDUMP/resources/download_publicly_available_fastq.html)
To inspect and collect the samples belonging to a specific project you can follow the [fastq downloading tutorial](https://sebastian-gregoricchio.github.io/multiDUMP/resources/download_publicly_available_fastq.html). A tab-delimited tables can be downloaded from the [ENA browser](https://www.ebi.ac.uk/ena/browser/home) as described in [paragraph 2.2.1](https://sebastian-gregoricchio.github.io/multiDUMP/resources/download_publicly_available_fastq.html#221_Obtain_SRR_numbers) of the tutorial.


<br>


-----------------
## Package history and releases
A list of all releases and respective description of changes applied could be found [here](https://sebastian-gregoricchio.github.io/multiDUMP/NEWS).

## Contact
For any suggestion, bug fixing, commentary please report it in the [issues](https://github.com/sebastian-gregoricchio/multiDUMP/issues)/[request](https://github.com/sebastian-gregoricchio/multiDUMP/pulls) tab of this repository.

## License
This repository is under a [GNU General Public License (version 3)](https://sebastian-gregoricchio.github.io/multiDUMP/LICENSE).

<br/>

#### Contributors
[![contributors](https://contrib.rocks/image?repo=sebastian-gregoricchio/multiDUMP)](https://sebastian-gregoricchio.github.io/)
