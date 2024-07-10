#!/bin/bash

# Define the parameters
sequence_lengths=(600 12000 30000)
error_rates=(0.1 0.05 0.01)
num_sequences=1000
motif="TTAGGG"
simulation_dir="simulation"
tidk_output_dir="tidk_output"
summary_file="tidk_explore_summary_results.tsv"
# in the current directory
python_script="./random_telomere_generator.py"

########################
##### SIMULATION #######
########################

# Create directories if they don't exist
mkdir -p $simulation_dir
mkdir -p $tidk_output_dir
# Loop through all combinations of sequence length and error rate
for seq_len in "${sequence_lengths[@]}"; do
  for err_rate in "${error_rates[@]}"; do
    # Create a temporary output file for the current combination
    temp_output="${simulation_dir}/len${seq_len}_err${err_rate}.fasta"
    
    # Run the Python script with the current parameters
    python3 $python_script $motif $err_rate $seq_len $num_sequences $temp_output
    # Determine the threshold based on the sequence length
    if (( seq_len < 1000 )); then
      threshold=10
    else
      threshold=100
    fi

    # Run the tidk explore command on the generated file
    tidk_output="${tidk_output_dir}/len${seq_len}_err${err_rate}.tsv"
    tidk explore -t $threshold --minimum 5 --maximum 12 --distance 0.5 $temp_output > $tidk_output
  done
done


echo "All simulations and tidk analyses have been completed."

########################
######## SUMMARY #######
########################

# Initialize the summary file with headers
echo -e "simulation_conditions\tmost_abundant_canonical_repeat_unit\tmost_abundant_count\tmost_abundant_6nt_canonical_repeat_unit\tmost_abundant_6nt_count\tAACCCT_count\ttotal_canonical_repeats" > $summary_file

# Function to process each TSV file
process_tsv() {
  local tsv_file=$1
  local conditions=$2

  # Skip the header and extract the most abundant canonical repeat unit and its count
  most_abundant=$(tail -n +2 "$tsv_file" | head -n 1)
  most_abundant_unit=$(echo $most_abundant | awk '{print $1}')
  most_abundant_count=$(echo $most_abundant | awk '{print $2}')

  # Get the count of the canonical repeat unit AACCCT (could be null)
  aaccct_count=$(grep -E "^AACCCT\s" "$tsv_file" | awk '{print $2}')
  if [ -z "$aaccct_count" ]; then
    aaccct_count=0
  fi

  # Get the total number of identified canonical repeats (excluding header)
  total_repeats=$(($(wc -l < "$tsv_file") - 1))

  # Extract the most abundant 6nt canonical repeat unit and its count
  most_abundant_6nt=$(grep -m 1 -E '^\S{6}\s' "$tsv_file")
  if [ -z "$most_abundant_6nt" ]; then
    most_abundant_6nt_unit="N"
    most_abundant_6nt_count="0"
  else
    most_abundant_6nt_unit=$(echo $most_abundant_6nt | awk '{print $1}')
    most_abundant_6nt_count=$(echo $most_abundant_6nt | awk '{print $2}')
  fi

  # Append the results to the summary file
  echo -e "$conditions\t$most_abundant_unit\t$most_abundant_count\t$most_abundant_6nt_unit\t$most_abundant_6nt_count\t$aaccct_count\t$total_repeats" >> $summary_file
}

# Process each TSV file in the tidk_output directory
for tsv_file in $tidk_output_dir/*.tsv; do
  # Extract the simulation conditions from the file name
  file_name=$(basename "$tsv_file")
  conditions="${file_name%.tsv}"
  
  # Process the TSV file
  process_tsv "$tsv_file" "$conditions"
done

echo "Summary results have been compiled into $summary_file."
