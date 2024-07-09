# short pipeline to download and run tidk

# fetch
curl -o ../data/bombus_sylvestris.fa.gz https://ftp.ensembl.org/pub/rapid-release/species/Bombus_sylvestris/GCA_911622165.1/ensembl/genome/Bombus_sylvestris-GCA_911622165.1-softmasked.fa.gz

# unzip
gunzip ../data/bombus_sylvestris.fa.gz

# run explore
# assumes tidk is in PATH
# emits a TSV to STDOUT by default
tidk --version # == 0.2.5 - latest on GitHub

tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris.fa > ../data/bomSyl_telomere.tsv

# look at the output
# it's a mixture of AACCCG, AACCT, and AACCCT
# a cursory look shows AACCT probably to be the most abundant.

# now we can search for this across the genome
tidk search -s AACCT -o bomSyl -d ../data -e tsv ../data/bombus_sylvestris.fa

# and for the reviewers
# filter ../data/bombus_sylvestris so we just have the first record
# requires mmft.
mmft regex -r "1 softmasked:chromosome" ../data/bombus_sylvestris.fa > ../data/bomb_chrom_1.fa

# now run tidk again, but with a window size of 500
tidk search -s AACCT -o bomSyl_chrom_1_500 -d ../data -w 500 -e tsv ../data/bomb_chrom_1.fa

# filter out the chromosomes we want
# egrep, as we need extended grep for the pipes
# sort as we'll want the chromosomes in order in the plot
egrep '^id|^1\s|^2\s|^3\s|^4\s|^5\s|^6\s|^7\s|^8\s|^9\s|^10\s' \
  ../data/bomSyl_telomeric_repeat_windows.tsv | \
  sort -s -n -k 1,1 \
  > ../data/bomSyl_telomeric_repeat_windows_filtered.tsv

# now we can plot
tidk plot --fontsize 20 -o ../img/bomSyl -t ../data/bomSyl_telomeric_repeat_windows_filtered.tsv

# manual edits done using the first 100bp and merging SVGs
mmft extract -r 0-100 ../data/bomb_chrom_1.fa > ../data/first_100bp_chrom_1.fa

# render the svg to PNG
# I use the nice resvg library (https://github.com/RazrFalcon/resvg)
resvg --background white --dpi 400 ../img/bomSyl.svg ../img/bomSyl.png

# also plot in R, if we are so inclined.
Rscript plot.R
# delete the big data
rm ../data/bombus_sylvestris.fa
