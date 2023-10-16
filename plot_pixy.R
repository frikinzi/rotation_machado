pixy_to_long <- function(pixy_files){
  
  pixy_df <- list()
  
  for(i in 1:length(pixy_files)){
    
    stat_file_type <- gsub(".*_|.txt", "", pixy_files[i])
    
    if(stat_file_type == "pi"){
      
      df <- read_delim(pixy_files[i], delim = "\t")
      df <- df %>%
        gather(-pop, -window_pos_1, -window_pos_2, -chromosome,
               key = "statistic", value = "value") %>%
        rename(pop1 = pop) %>%
        mutate(pop2 = NA)
      
      pixy_df[[i]] <- df
      
      
    } else{
      
      df <- read_delim(pixy_files[i], delim = "\t")
      df <- df %>%
        gather(-pop1, -pop2, -window_pos_1, -window_pos_2, -chromosome,
               key = "statistic", value = "value")
      pixy_df[[i]] <- df
      
    }
    
  }
  
  bind_rows(pixy_df) %>%
    arrange(pop1, pop2, chromosome, window_pos_1, statistic)
  
}




pixy_folder <- "pixy"
pixy_files <- list.files(pixy_folder, full.names = TRUE)
pixy_df <- pixy_to_long(pixy_files)

# custom labeller for special characters in pi/dxy/fst
pixy_labeller <- as_labeller(c(avg_pi = "pi",
                               avg_dxy = "D[XY]",
                               avg_wc_fst = "F[ST]"),
                             default = label_parsed)

test <- pixy_df %>%
  filter(chromosome == "TcYC6_Chr2") %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  filter(pop1 == "TcIII" & pop2 == "TcII")

test2 <- pixy_df %>%
  filter(chromosome == "TcYC6_Chr2") %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  filter(pop1 == "TcIII" & pop2 == "TcV")

test3 <- pixy_df %>%
  filter(chromosome == "TcYC6_Chr2") %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  filter(pop1 == "TcIII" & pop2 == "TcVI")

TcII_TcVI <- pixy_df %>%
  filter(chromosome == "TcYC6_Chr2") %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  filter(pop1 == "TcII" & pop2 == "TcVI")

TcII_TcV <- pixy_df %>%
  filter(chromosome == "TcYC6_Chr2") %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  filter(pop1 == "TcII" & pop2 == "TcV")

# plotting summary statistics along a single chromosome
plot1 <- test %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = value, color = statistic))+
  geom_line(size = 0.25)+
  facet_grid(statistic ~ .,
             scales = "free_y", switch = "x", space = "free_x",
             labeller = labeller(statistic = pixy_labeller,
                                 value = label_value))+
  xlab("Position on Chromosome (Mb)")+
  ylab("Statistic Value")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0))+
  scale_color_manual(values = c("darkorange", "red", "green"))

# plotting summary statistics along a single chromosome
plot2 <- test2 %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = value, color = statistic))+
  geom_line(size = 0.25)+
  facet_grid(statistic ~ .,
             scales = "free_y", switch = "x", space = "free_x",
             labeller = labeller(statistic = pixy_labeller,
                                 value = label_value))+
  xlab("Position on Chromosome (Mb)")+
  ylab("Statistic Value")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0)) +
  scale_color_manual(values = c("lightblue", "red", "green"))  # Specify the color values for each group

# plotting summary statistics along a single chromosome
plot3 <- test3 %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = value, color = statistic))+
  geom_line(size = 0.25)+
  facet_grid(statistic ~ .,
             scales = "free_y", switch = "x", space = "free_x",
             labeller = labeller(statistic = pixy_labeller,
                                 value = label_value))+
  xlab("Position on Chromosome (Mb)")+
  ylab("Statistic Value")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0))+
  scale_color_manual(values = c("darkgreen", "red", "green"))

plot2 <- test2 %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = value, color = statistic))+
  geom_line(size = 0.25)+
  facet_grid(statistic ~ .,
             scales = "free_y", switch = "x", space = "free_x",
             labeller = labeller(statistic = pixy_labeller,
                                 value = label_value))+
  xlab("Position on Chromosome (Mb)")+
  ylab("Statistic Value")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0)) +
  scale_color_manual(values = c("lightblue", "red", "green"))  # Specify the color values for each group

# plotting summary statistics along a single chromosome
plot_test <- test %>%
  filter(statistic %in% c("avg_pi", "avg_dxy", "avg_wc_fst")) %>%
  mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000) %>%
  ggplot(aes(x = chr_position, y = value))+
  geom_line(size = 0.25, color = "green")+
  facet_grid(statistic ~ .,
             scales = "free_y", switch = "x", space = "free_x",
             labeller = labeller(statistic = pixy_labeller,
                                 value = label_value))+
  xlab("Position on Chromosome (Mb)")+
  ylab("Statistic Value")+
  theme_bw()+
  theme(panel.spacing = unit(0.1, "cm"),
        strip.background = element_blank(),
        strip.placement = "outside",
        legend.position = "none")+
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0))+
  geom_line(data=TcII_TcV %>% mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000), size = 0.25, color="pink") +
  geom_line(data=TcII_TcVI %>% mutate(chr_position = ((window_pos_1 + window_pos_2)/2)/1000000), size = 0.25, color="darkorange") +
  ylim(0, 0.4)

