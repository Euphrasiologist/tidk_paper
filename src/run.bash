# short pipeline to download and run tidk
#

# fetch
curl -o ../data/bombus_sylvestris.fa.gz https://ftp.ensembl.org/pub/rapid-release/species/Bombus_sylvestris/GCA_911622165.1/ensembl/genome/Bombus_sylvestris-GCA_911622165.1-softmasked.fa.gz

# unzip
gunzip ../data/bombus_sylvestris.fa.gz

# run explore
# assumes tidk is in PATH
# emits a TSV to STDOUT by default
tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris.fa > ../data/bomSyl_telomere.tsv

# look at the output
# it's a mixture of AACCCG, AACCT, and AACCCT
# a cursory look shows AACCT probably to be the most abundant.

# now we can search for this across the genome
tidk search -s AACCT -o bomSyl -d ../data -e tsv ../data/bombus_sylvestris.fa

# now we can plot
Rscript plot.R

# delete the big data
rm ../data/bombus_sylvestris.fa
