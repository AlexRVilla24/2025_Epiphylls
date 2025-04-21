##%######################################################%##
#                                                          #
####        Epiphylls Ecology. By: Alex R. Villa        ####
#                                                          #
##%######################################################%##

pacman:: p_load("readr", "dplyr", "ggplot2", "skimr","factoextra", "tidyr",
                "viridis", "ggstatsplot", "broom")
setwd("~/Data")

################################################################### 1) Data ----

Data_Epiphylls <- read_csv("Inputs/Data_Epiphylls.csv")

########################################################### 2) Microclimate ----

# Select variables
Data_Epiphylls_PCA <- Data_Epiphylls %>% 
  dplyr::select(Site, HR, Temp, DD, Ilum)

# Stats
Data_Epiphylls_PCA %>% filter(Site== "H") %>% skim
Data_Epiphylls_PCA %>% filter(Site == "S") %>% skim

# PCA
PCA <- prcomp(Data_Epiphylls_PCA[, 2:5],  scale = TRUE)
Fig4_PCA <- fviz_pca_biplot(PCA, label = "var", habillage=Data_Epiphylls_PCA$Site,
                addEllipses=TRUE, ellipse.level=0.8,
                ggtheme = theme_minimal(), 
                title = "Agrupación por microclima")

# t-test (four variables)
t_tests_Results_Microclimate <- list()
for (i in names(Data_Epiphylls_PCA[2:5])) {
  MS1 <- Data_Epiphylls_PCA %>% filter(Site == "H") %>% select(i)
  MS2 <- Data_Epiphylls_PCA %>% filter(Site == "S")  %>% select(i)
  t_tests_Results_Microclimate[[i]] <- tidy(t.test(MS1, MS2))
  write.csv(t_tests_Results_Microclimate[[i]], paste0("Outputs/meantest_", i, ".csv"))
}
t_tests_Results_Microclimate

############################################ 3) Heatmap Epiphylls dominance ----

# Select Columns for Heatmap
Data_Epiphylls_Heatmap <- Data_Epiphylls %>% 
  mutate(Algas = Trentepohlia + Phycopeltis) %>% 
  dplyr::select(ID, E = Liquenes, D = Hepaticas, C = Algas, 
                B = Liquen_Hepatica, A = Liquen_Hepatica_Alga)

# Prepare Data
Long_Data_Epiphylls <- pivot_longer(Data_Epiphylls_Heatmap,
                                    cols = 2:ncol(Data_Epiphylls_Heatmap),
                                    names_to =  "Epifilos")
# Plot
Fig5_Heatmap <- ggplot(Long_Data_Epiphylls, aes(x = ID, y = Epifilos, fill = value)) + 
  geom_tile(colour = "white", linewidth = 0.5, width = .9, height = .9) + 
  theme_minimal() +  scale_fill_gradient(low = "white", high = "red") +
  scale_x_continuous(expand = c(0,0), 
                     breaks = seq(0, 72, by = 18),
                     limits = c(0, 72)) +
  geom_vline(xintercept = 18, color = "gray", linewidth = 0.5) + 
  geom_vline(xintercept = 36, color = "gray", linewidth = 0.5) + 
  geom_vline(xintercept = 54, color = "gray", linewidth = 0.5) + 
  geom_vline(xintercept = 72, color = "gray", linewidth = 0.5) +
  ggtitle("Prevalencia de epífilos en cada combinación 
          de microclima y tipo de forófito") + 
  theme(legend.text=element_text(face="bold"),
        axis.ticks=element_line(linewidth = 0.4),
        plot.background=element_blank(),
        panel.border=element_blank(),
        legend.position = "top")

############################### 4) Microclimate vs host ----

# Variable selection
Data_Epiphylls_Stats <- Data_Epiphylls %>% 
  dplyr::select(Code, Hepaticas, Liquenes, Trentepohlia, Phycopeltis, 
                Liquen_Hepatica, Liquen_Hepatica_Alga) %>% 
  mutate(Algas = Trentepohlia + Phycopeltis, .before = Trentepohlia) %>% 
  select(-Trentepohlia, -Phycopeltis)

# Frequency histograms
# attach(Data_Epiphylls_Stats)
# hist(Liquenes)
# hist(Hepaticas)
# hist(Algas)

# Full data frame
Data_Epiphylls_Long <- Data_Epiphylls_Stats %>% pivot_longer(!Code, 
                                                             names_to = "Epifilo", 
                                                             values_to = "Prevalence")
# Mean test for all Epiphylls
# Results <- list()
# for (i in unique(Data_Epiphylls_Long$Epifilo)) {
#   Data_Loop <- Data_Epiphylls_Long %>% filter(Epifilo == i) %>% select(Code, Prevalence)
#   t_tests_Results_Groups <- list()
#   A <- tidy(t.test(Data_Loop  %>% filter(Code == "P1M1") %>% select(Prevalence), 
#                    Data_Loop  %>% filter(Code == "P1M2") %>% select(Prevalence)))
#   B <- tidy(t.test(Data_Loop  %>% filter(Code == "P1M1") %>% select(Prevalence) , 
#                    Data_Loop  %>% filter(Code == "P2M1") %>% select(Prevalence)))
#   C <- tidy(t.test(Data_Loop  %>% filter(Code == "P1M1") %>% select(Prevalence), 
#                    Data_Loop  %>% filter(Code == "P2M2") %>% select(Prevalence)))
#   D <- tidy(t.test(Data_Loop  %>% filter(Code == "P1M2") %>% select(Prevalence), 
#                    Data_Loop  %>% filter(Code == "P2M1") %>% select(Prevalence)))
#   E <- tidy(t.test(Data_Loop  %>% filter(Code == "P1M2") %>% select(Prevalence), 
#                    Data_Loop  %>% filter(Code == "P2M2") %>% select(Prevalence)))
#   G <- tidy(t.test(Data_Loop  %>% filter(Code == "P2M1") %>% select(Prevalence), 
#                    Data_Loop  %>% filter(Code == "P2M2") %>% select(Prevalence)))
#   group_vect <- c("AmMS1 - AmMS2", "AmMS1 - DnMS1", "AmMS1 - DnMS2", 
#                   "AmMS2 - DnMS1", "AmMS2 - DnMS2",  "DnMS1 - DnMS2")
#   Results <- bind_rows(A,B,C,D,E,G, .id = "estimate") %>% 
#     mutate(group = group_vect, Epi = i)
#   write.csv(Results, paste0("Outputs/Stats_", i,".csv"))
# }

##################################################### 5) Outputs ----

# Fig. 4 - PCA
# ggsave(Fig4_PCA, file = paste0("Outputs/Fig. 4 - PCA.pdf"), 
#        width = 16, height = 12, units = "cm") 
# 
# # Fig. 5 - Heatmap
# ggsave(Fig5_Heatmap, file = paste0("Outputs/Fig. 6 - Heatmap.pdf"), 
#        width = 16, height = 12, units = "cm") 
# 
# # Fig. 6 - Stats
# Epifilos <- list()
# Fig5_Stats <- list()
# for (i in unique(Data_Epiphylls_Long$Epifilo)) {
#   Epifilos[[i]] <- Data_Epiphylls_Long %>% filter(Epifilo == i)
#   Fig5_Stats[[i]] <- ggbetweenstats(data = Epifilos[[i]],
#                                     x = Code,
#                                     y = Prevalence) +
#     labs(x = "Grupos por sitio y tipo de forófito",
#          y = i) +
#     theme(
#       plot.subtitle = element_text(
#         size = 12,
#         color="#1b2838"),
#       axis.text = element_text(size = 10, color = "black"),
#       axis.title = element_text(size = 12))
#   ggsave(Fig5_Stats[[i]], file = paste0("Outputs/Fig. 6 - Stats_", i, ".pdf"),
#          width = 16, height = 12, units = "cm")
# }

##%######################################################%##
#                                                          #
####                     THE END :D                     ####
#                                                          #
##%######################################################%##