# IS-032
ChIP-Seq analyses for IS-032 NextSeq run

## Setup
Clone the repo:

`$ git clone https://github.com/eco32i/IS-032.git`

ONLY IF YOU HAVEN'T DONE THIS BEFORE: Navigate to `IS-032/scripts` and run the `bootstrap.sh` script that will install dependencies and setup Python 3 virtual environment called `pydata3` in `$HOME/.venv` and Python 2 virtual environment called `pydata2` in `$HOME/.virtualenvs`::

`$ ./bootstrap.sh --all`

If you ran `bootstrap.sh` script from another repo (such as `IS-017`) then your python virtualenvs are all set up and you can copy the data files and go directly to running notebooks section below.

Navigate to `IS-032` directory and symlink the data files (assuming you are on `snowflake`):

`:~/IS-032$ ln -s /mnt/brick1/IS-032/data data`

## Sample table

| Sample ID | Name | Ab | Control |
|-----------|------|----|---------|
| skm01 | HepFLAG-WTS1-FLAG | FLAG | skm27 |
| skm02 | HepFLAG-WTS1-RNAP | RNAP | skm27 |
| skm03 | HepFLAG-WTS1-S9.6 | S9.6 | skm27 |
| skm04 | HepFLAG-S1d56-FLAG | FLAG | skm28 |
| skm05 | HepFLAG-S1d56-RNAP | RNAP | skm28 |
| skm06 | HepFLAG-S1d56-S9.6 | S9.6 | skm28 |
| skm07 | S1d56-HepFLAG-FLAG | FLAG | skm28 |
| skm08 | S1d56-HepFLAG-RNAP | RNAP | skm28 |
| skm09 | S1d56-HepFLAG-S9.6 | S9.6 | skm28 |
| skm10 | S1FLAG-dHep-FLAG | FLAG | skm30 |
| skm11 | S1FLAG-dHep-RNAP | RNAP | skm30 |
| skm12 | S1FLAG-dHep-S9.6 | S9.6 | skm30 |
| skm13 | Hep-FLAG_V-FLAG | FLAG | skm25 |
| skm14 | Hep-FLAG_V-RNAP | RNAP | skm25 |
| skm15 | Hep-FLAG_V-s9.6 | S9.6 | skm25 |
| skm16 | Hep-FLAG_rnh-FLAG | FLAG | skm26 |
| skm17 | Hep-FLAG_rnh-RNAP | RNAP | skm26 |
| skm18 | Hep-FLAG_rnh-S9.6 | S9.6 | skm26 |
| skm19 | S1-FLAG_V-FLAG | FLAG | skm25 |
| skm20 | S1-FLAG_V-RNAP | RNAP | skm25 |
| skm21 | S1-FLAG_V-S9.6 | S9.6 | skm25 |
| skm22 | S1-FLAG_rnh-FLAG | FLAG | skm26 |
| skm23 | S1-FLAG_rnh-RNAP | RNAP | skm26 |
| skm24 | S1-FLAG_rnh-S9.6 | S9.6 | skm26 |

## Results

Each subdirectory in `results` directory corresponds to a sample from the samples table and contains the output of `MACS2` for that sample:

* `{sample_id}_peaks.NarrowPeak` - coordinates of peaks 
* `{sample_id}_peaks.xls` - `.csv` file with statistics on each peak, can be loaded into a spreadsheet program directly  
* `{sample_id}_summits.bed` - `.bed` file with coordinates of summits for called peaks.
* `{sample_id}.cm.csv` - coverage matrix (as `.csv` file) for `TSS` plots. See `src/TSS_plots.ipynb` for details.

## Running notebooks

The analyses are organized into several `jupyter` notebooks. To launch the notebook, navigate to `IS-032/src` directory and activate `pydata3` environment:

```bash
$ source ~/.venv/pydata3/bin/activate
(pydata3) $ jupyter notebook
```
Or, for `pydata2` environment:

```bash
$ workon pydata2
(pydata2) $ jupyter notebook
```

Description of the notebooks:

* `data_download` - downloading the `.fastq` files from `basespace` and combining separate line files into one `.fastq` file per read per sample. You don't need to run this part again.
* `alignment` - aligning reads to the reference, sorting `.bam` files. You will need to install `bowtie2` and build E.coli genome index if you plan to re-run this part.
* `ChIP-Seq` - actual peak calling using `MACS2`. This notebook should be run from `pydata2` virtualenv because `MACS2` doesn't support python3.
* `TSS_plots` - TSS for all samples (not that it makes sense for all of them)

To deactivate `pydata3`  (or `pydata2`) virtualenv at the end of your session:

`(pydata3) $ deactivate`

