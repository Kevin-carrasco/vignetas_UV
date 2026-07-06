pacman::p_load(readr, dplyr, formr)

#formr_connect("kevin.carrasco@ug.uchile.cl", "k959371343")
#base = formr_results("vignetas_mat")
#save(base, file="output/base.RData")
#base <- data
#base <- read_csv("input/data/original/vignetas 2026-05-19.csv")

base <- jsonlite::read_json("input/data/original/vignetas 2026-07-06.json", simplifyVector = TRUE)
base <- as.data.frame(base)

data <- filter(base, start_01==1)
names(data)
class(data$created)

data <- data %>%
  mutate(created = as.POSIXct(created))

data <- data %>%
  filter(created >= as.POSIXct("2026-05-01 00:00:00"))

data <- data %>%
  filter(!is.na(curso))

sjmisc::frq(data$nombre_colegio)

data <- data %>%
  filter(nombre_colegio!="123")

# bajo_rendimiento <- data %>%
#   filter(ran_group == 1)
# 
# alto_rendimiento <- data %>%
#   filter(ran_group == 2)

completas <- data %>%
  filter(!is.na(ended))
.
incompletas <- data %>%
  filter(is.na(ended))

# bajo_rendimiento <- completas %>%
#   filter(ran_group == 1)
# 
# alto_rendimiento <- completas %>%
#   filter(ran_group == 2)


#completan_vignetas <- incompletas %>% filter(!is.na(gconflict_01))
# completan_vignetas <- incompletas %>% filter(!is.na(gc_commonality_01))
# completan_vignetas <- incompletas %>% filter(!is.na(gc_discrimination_01))
# completan_vignetas <- incompletas %>% filter(!is.na(gaffect_01))
# 
# completan_vignetas <- incompletas %>% filter(!is.na(egenero_01))
# 
# completan_vignetas <- incompletas %>% filter(!is.na(emigrante_01))
# 
# completan_vignetas <- incompletas %>% filter(!is.na(atencion2))
# 
# completan_vignetas <- incompletas %>% filter(!is.na(depe))


iniciadas <- data
completan_vignetas <- data %>% filter(!is.na(gconflict_01))

save(iniciadas, file="output/iniciadas.RData")
# save(completan_vignetas, file="output/completan_vignetas.RData")
save(completas, file="output/completas.RData")

table(iniciadas$genero)
