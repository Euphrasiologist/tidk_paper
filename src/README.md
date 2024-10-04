# Notes on running

You will need latest `tidk` installed and in `$PATH`. This can be done in one of three ways:

```bash
# 1. Using Rust

# install Rust. Follow:
# https://www.rust-lang.org/tools/install

# then:
git clone https://github.com/tolkit/telomeric-identifier
cd telomeric-identifier
cargo install --path=.

# OR from crates.io
cargo install tidk

# 2. From the latest releases on GitHub
# e.g. for a Mac
curl -LJO https://github.com/tolkit/telomeric-identifier/releases/download/v0.2.62/tidk-x86_64-apple-darwin.tar.xz && tar -xvf tidk-x86_64-apple-darwin.tar.xz
cd tidk-x86_64-apple-darwin/ && chmod +x tidk

# 3. Install from conda
# note that latest version may still be being updated/uploaded
conda install -c bioconda tidk
```

## Main analysis

The main plot (Figure 1) is generated from two different programs. Part A of the Figure is generated from the bash script below.

There is some prerequisite software to download. The script has also been written on a Mac, so bear that in mind.

```bash
# 1. mmft for fasta manipulation. seqtk/seqkit are probably better alternatives, but you'd need to modify the script slightly
curl -LJO https://github.com/ARU-life-sciences/mmft/releases/download/v0.2.0/mmft-x86_64-apple-darwin.tar.xz && tar -xvf mmft-x86_64-apple-darwin.tar.xz; 
cd mmft-x86_64-apple-darwin.tar.xz && chmod +x mmft

# 2. resvg for rendering SVG plots to a PNG file.
# this command below requires a rust toolchain, but can be downloaded: https://github.com/RazrFalcon/resvg/releases/tag/v0.44.0
cargo install resvg

bash run.bash
```

Generated data is in the `../data` directory and images are placed in the `../img` directory. `run.bash` creates Figure 1A.

Figure 1B was created by extracting the first 100bp of chromosome 1 (see `run.bash`; the extracted base pairs are in `../data/first_100bp_chrom_1.fa` - you will need to generate this yourself). The base pairs are directly embedded into the HTML. View Figure 1B by opening `./figure1B.html`.

## Complexity

The time and complexity of the commands can be estimated using this script:

```bash
# using the create argument, we generate the data too - not necessary if you've already made the data once.
bash complexity.bash create
```

The times are printed to stdout and were manually compiled and then plotted in an HTML document. Open `./supplementary.html` to view the plots.

## Simulation analysis

To understand if `tidk explore` works well under different error rates:

```bash
bash accuracy_simulation.bash
```

This must be run in the current directory (i.e. `./src`) as the paths in the script are hard-coded.

## Supplementary material 

### Graphs

`./supplementary.html` contains graphs which plot genome length vs computation time for various subcommands and parameters in `tidk`. View in the browser.

### PDFs

The PDFs are compiled using `typst`. See https://typst.app/.

- `../pcode/pcode.pdf` contains the pseudocode for a part of the `tidk explore` subcommand.

- `../data/Supplementary_Table_S3.pdf` contains the PDF of simulation results from randomly generated data. If you generate the data yourself, it may deviate slightly from what is in the manuscript by chance.
