# Notes on running

You will need latest `tidk` installed and in $PATH.

```bash
# install Rust. Follow:
# https://www.rust-lang.org/tools/install

# then:
git clone https://github.com/tolkit/telomeric-identifier
cd telomeric-identifier
cargo install --path=.
```

## Main analysis

This will run the script to generate the main plot figure in the manuscript:

```bash
bash run.bash
```

## Complexity

The time and complexity of the commands can be estimated using this script:

```bash
bash complexity.bash
```

The times are printed to stdout and are compiled/plotted [here](https://observablehq.com/@euphrasiologist/sketches-for-tidk-manuscript).

## Simulation analysis

To understand if `tidk explore` works well under different error rates:

```bash
bash accuracy_simulation.bash
```
