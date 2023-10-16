from multiprocessing import Pool
import multiprocessing
from multiprocessing import Lock
from Bio import SeqIO
import sys

# Define a global lock
file_lock = Lock()

def read_pop_file(file):
    dict = {}
    pops = open(file, "r")
    lines = pops.readlines()
    for i in lines:
        dict[i.split("\t")[0].strip()] = i.split("\t")[1].strip()
    pops.close()
    return dict

def calculate_divergence(seq1, seq2):
    count = 0
    for i in range(len(seq1)):
        if seq1[i] != seq2[i]:
            count += 1
    return count / len(seq1)

def calculate_avg_divergence(fasta_file, pop_dict, start_index, file):
    sequence_list = list(pop_dict.keys())
    totals_pop = {}
    # unused. meant to count total to calculate the average divergence
    for pops in sequence_list:
        totals_pop[pops] = 0
    seqs = list(SeqIO.parse(fasta_file, "fasta"))
    seq_dict = {}
    # create dictionary of keys = sequence description and value = sequence
    for seq in seqs:
        seq_dict[seq.description] = str(seq.seq)[start_index:start_index+10000]
    matrix = [[0 for i in range(len(sequence_list))] for j in range(len(sequence_list))]
    for i in range(len(sequence_list)):
        for j in range(len(sequence_list)):
            if (pop_dict[sequence_list[i]] != pop_dict[sequence_list[j]]):
                try:
                    matrix[j][i] = calculate_divergence(seq_dict[sequence_list[i]], seq_dict[sequence_list[j]])
                    with file_lock:
                        file.write(sequence_list[i] + "\t" + sequence_list[j] + "\t" + pop_dict[sequence_list[i]] + "\t" + pop_dict[sequence_list[j]] + "\t" + str(start_index) + "\t" + str(start_index+10000) + "\t" + str(matrix[j][i]) + "\n")
                except KeyError: #if something in pop file doesn't exist in sequences
                    pass
    
def run_calcs(start, end, fasta, pop_dict, i, output_file):
    for i in range(start, end, 2000):
        calculate_avg_divergence(fasta, pop_dict, i, output_file)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("usage: python3 calc_divergence.py <fasta_file> <pop_file> <results_table>")
        exit(1)
    fasta = sys.argv[1]
    table_results = open(sys.argv[3], "w")
    table_results.write("seq1" + "\t" + "seq2" + "\t" + "pop1" + "\t" + "pop2" + "\t" + "start_window" + "\t" + "end_window" + "\t" + "distance" + "\n")
    pop_dict = read_pop_file(sys.argv[2])
    # Define the number of processes you want to run in parallel
    num_processes = 368 
    
    # Define the range of 'i' values to process in parallel
    #ranges = [(i, i + 2000) for i in range(1, 2950000, 2000)]

    #pool = multiprocessing.Pool(processes=num_processes)

    for i in range(1,1600000,2000):
        calculate_avg_divergence(fasta, pop_dict, i, table_results)
    
    #results = [pool.apply_async(run_calcs, args=(fasta, pop_dict, start, end, table_results)) for start, end in ranges]
    # Close the pool and wait for all processes to complete
    #pool.close()
    #pool.join()
    
    table_results.close()