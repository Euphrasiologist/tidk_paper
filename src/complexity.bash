# assuming the data is in the directory ../data

# create fasta with more data by duplicating the original fasta ../data/bombus_sylvestris.fa
for i in {1..2}; do
    cat ../data/bombus_sylvestris.fa >> ../data/bombus_sylvestris2.fa
done

for i in {1..3}; do
    cat ../data/bombus_sylvestris.fa >> ../data/bombus_sylvestris3.fa
done

for i in {1..4}; do
    cat ../data/bombus_sylvestris.fa >> ../data/bombus_sylvestris4.fa
done

for i in {1..5}; do
    cat ../data/bombus_sylvestris.fa >> ../data/bombus_sylvestris5.fa
done

time tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris.fa > /dev/null
time tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris2.fa > /dev/null
time tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris3.fa > /dev/null
time tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris4.fa > /dev/null
time tidk explore -m 5 -x 30 --distance 0.001 ../data/bombus_sylvestris5.fa > /dev/null

mkdir temp

time tidk search -s AACCT -o null -d temp ../data/bombus_sylvestris.fa 
time tidk search -s AACCT -o null -d temp ../data/bombus_sylvestris2.fa 
time tidk search -s AACCT -o null -d temp ../data/bombus_sylvestris3.fa 
time tidk search -s AACCT -o null -d temp ../data/bombus_sylvestris4.fa 
time tidk search -s AACCT -o null -d temp ../data/bombus_sylvestris5.fa 


rm -r temp
# get rid of the temp files
rm ../data/*.fa
