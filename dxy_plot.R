library(dplyr)
library(readr)

dxy_table <- read_tsv("chr6_results.tsv")

grouped <-dxy_table %>%
  group_by(pop1,pop2,start_window, end_window) 

result_df <- grouped %>%
  summarize(average_distance = mean(distance))

result_df <- as.data.frame(result_df)

# filter haplotype 1 vs TcII
TcVH1vsTcII <- result_df %>%
  filter(pop1 == "TcVI-H1", pop2 == "TcII")

# filter haplotype 2 vs TcII
TcVH2vsTcII <- result_df %>%
  filter(pop1 == "TcVI-H2", pop2 == "TcII")

# filter TcII vs TcIII
TcIIIvsTcII <- result_df %>%
  filter(pop1 == "TcII", pop2 == "TcIII")

#plot dxy over entire chromosome
plot <- TcVH1vsTcII %>%
  mutate(chr_position = ((start_window + end_window)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = average_distance))+
  geom_line(size = 0.25, color="darkorange")+
  xlab("Position on Chromosome (Mb)")+
  ylab("Dxy")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0))+
  geom_line(data=TcVH2vsTcII %>% mutate(chr_position = ((start_window + end_window)/2)/1000000), size = 0.25, color="black") +
  geom_line(data=TcIIIvsTcII %>% mutate(chr_position = ((start_window + end_window)/2)/1000000), size = 0.25, color="magenta")
    
