library(ggplot2)

#plot box plot
dxy_table_chr1 <- read_tsv("results_chr1_overlap.tsv") %>%
  mutate(chr = "chr1")

dxy_table_chr1$comparison <- paste(dxy_table_chr1$pop1, dxy_table_chr1$pop2, sep="_")

dxy_table_chr2 <- read_tsv("results_chr2.tsv") %>%
  mutate(chr = "chr2")

dxy_table_chr2$comparison <- paste(dxy_table_chr2$pop1, dxy_table_chr2$pop2, sep="_")

dxy_table_chr3 <- read_tsv("chr3_results.tsv") %>%
  mutate(chr = "chr3")

dxy_table_chr3$comparison <- paste(dxy_table_chr3$pop1, dxy_table_chr3$pop2, sep="_")

dxy_table_chr4 <- read_tsv("chr4_results.tsv") %>%
  mutate(chr = "chr4")

dxy_table_chr4$comparison <- paste(dxy_table_chr4$pop1, dxy_table_chr4$pop2, sep="_")

dxy_table_chr5 <- read_tsv("chr5_results.tsv") %>%
  mutate(chr = "chr5")

dxy_table_chr5$comparison <- paste(dxy_table_chr5$pop1, dxy_table_chr5$pop2, sep="_")

dxy_table_chr6 <- read_tsv("chr6_results.tsv") %>%
  mutate(chr = "chr6")

dxy_table_chr6$comparison <- paste(dxy_table_chr6$pop1, dxy_table_chr6$pop2, sep="_")

dxy_table_chr7 <- read_tsv("chr7_results.tsv") %>%
  mutate(chr = "chr7")

dxy_table_chr7$comparison <- paste(dxy_table_chr7$pop1, dxy_table_chr7$pop2, sep="_")

chr1_TcIII_II <- dxy_table_chr1 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr2_TcIII_II <- dxy_table_chr2 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr3_TcIII_II <- dxy_table_chr3 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr4_TcIII_II <- dxy_table_chr4 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr5_TcIII_II <- dxy_table_chr5 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr6_TcIII_II <- dxy_table_chr6 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

chr7_TcIII_II <- dxy_table_chr7 %>%
  filter(comparison == "TcIII_TcII" | comparison == "TcV-H1_TcII" | comparison == "TcV-H2_TcII")

TcIII_II <- bind_rows(chr1_TcIII_II, chr2_TcIII_II, chr3_TcIII_II,chr4_TcIII_II,chr5_TcIII_II,chr6_TcIII_II,chr7_TcIII_II)
ggplot(data=TcIII_II, aes(x=chr,y=distance,fill=comparison)) +
  geom_boxplot()
