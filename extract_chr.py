from Bio import SeqIO
import os
import sys
'''
usage: python3 extract_chr.py <chr number> <output file>
'''

combined_fa = open(sys.argv[2], "w")
combined_fa.write(">TcYC6\n")
seqs = list(SeqIO.parse("TcruziYC6.fasta", "fasta"))
combined_fa.write(str(seqs[int(sys.argv[1])].seq + "\n\n"))
for i in os.listdir("fasta"):
	if (i.endswith(".fa")):
		seqs = list(SeqIO.parse("fasta/"+ i, "fasta"))
		combined_fa.write(">" + i[:-3] + "\n")
		combined_fa.write(str(seqs[int(sys.argv[1])].seq + "\n\n").replace("*","-"))

for i in os.listdir("fasta/TcI-IV"):
	if (i.endswith(".fa")):
		seqs = list(SeqIO.parse("fasta/TcI-IV/" + i, "fasta"))
		combined_fa.write(">" + i[:-3] + "\n")
		combined_fa.write(str(seqs[int(sys.argv[1])].seq + "\n\n").replace("*","-"))
