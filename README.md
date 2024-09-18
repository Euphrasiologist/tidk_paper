# `tidk`: a toolkit to rapidly identify telomeric repeats from genomic datasets

Max R. Brown (1), Pablo Gonzalez de La Rosa (2), Mark Blaxter (2)

(1) School of Life Sciences, Anglia Ruskin University, Cambridge, UK
(2) Tree of Life, Wellcome Sanger Institute, Hinxton, UK

Repository for analysis and supplementary materials presented for the above paper.

- The main figure and analysis can be run with `cd src; bash ./src/run.bash`
- The complexity data used in the supplementary can be run with `cd src; bash complexity.bash`
- The simulations of error rates in `tidk explore` can be run with `cd src; bash accuracy_simulation.bash`

## Supplementary information

`./src/supplementary.html` contains graphs which plot genome length vs computation time for various subcommands and parameters in `tidk`. `./pcode/pcode.pdf` contains the pseudocode for a part of the `tidk explore` subcommand. `./data/Supplementary_Table_S3.pdf` contains the PDF of simulation results from randomly generated data. If you generate the data yourself, it may deviate slightly from what is in the manuscript by chance.
