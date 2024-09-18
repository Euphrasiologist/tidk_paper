#let results = csv("tidk_explore_summary_results.tsv", delimiter: "\t")
// pop the header
#let _ = results.remove(0)

= Supplementary Table S3

We simulated genomes, each with a thousand sequence replicates of varying lengths (600, 12,000, or 30,000 nucleotides) and composed of TTAGGG telomeric repeats (with the lexicographically minimal canonical telomeric repeat being AACCCT) at different error rates (1%, 1.5%, 2%, 5%, and 10%). We aimed to assess the performance of `tidk explore` in identifying telomeric repeats.

The table below shows:
+ The simulated conditions (mixture of error rate and sequence length)
+ The most abundant canonical telomeric repeat
+ The count of the most abundant canonical telomeric repeat
+ The most abundant 6-nucleotide canonical telomeric repeat
+ The count of the most abundant 6-nucleotide canonical telomeric repeat
+ The count of AACCCT canonical telomeric repeat
+ The total number of canonical telomeric repeats identified by `tidk explore`

#rotate(
  -90deg,
  reflow: true,
table(
    columns: 7,
    [*Simulation Conditions*], [*Most abundant canonical repeat*], [*Most abundant count*], [*Most abundant 6 nucleotide canonical repeat*], [*Most abundant 6 nucleotide count*], [*AACCCT count*], [*Total canonical repeats*],
    ..results.flatten(),
  )
)
