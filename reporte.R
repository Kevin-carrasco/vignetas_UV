pacman::p_load(readr, dplyr, formr)

#formr_connect("kevin.carrasco@ug.uchile.cl", "k959371343")
#base = formr_results("vignetas_mat")
#save(base, file="output/base.RData")
#base <- data
#base <- read_csv("input/data/original/vignetas 2026-05-19.csv")

base <- jsonlite::read_json("input/data/original/vignetas 2026-10-14.json", simplifyVector = TRUE)


data <- dplyr::filter(base, start_01==1)
names(data)
class(data$created)

data <- data %>%
  dplyr::mutate(created = as.POSIXct(created))

data <- data %>%
  dplyr::filter(created >= as.POSIXct("2026-05-01 00:00:00"))

data <- data %>%
  dplyr::filter(!is.na(curso))

sjmisc::frq(data$nombre_colegio)

data <- data %>%
  dplyr::filter(nombre_colegio!="123")
data <- data %>%
  dplyr::filter(nombre_colegio!="test")

# bajo_rendimiento <- data %>%
#   dplyr::filter(ran_group == 1)
# 
# alto_rendimiento <- data %>%
#   dplyr::filter(ran_group == 2)

completas <- data %>%
  dplyr::filter(!is.na(ended))

incompletas <- data %>%
  dplyr::filter(is.na(ended))

# bajo_rendimiento <- completas %>%
#   dplyr::filter(ran_group == 1)
# 
# alto_rendimiento <- completas %>%
#   dplyr::filter(ran_group == 2)


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



base2 <- jsonlite::read_json("input/data/original/vignetas rforms 2026-09-21.json", simplifyVector = TRUE)
base2 <- as.data.frame(base2)

data2 <- filter(base2, start_01==1)
names(data2)
class(data2$created)

data2 <- data2 %>%
  mutate(created = as.POSIXct(created))

data2 <- data2 %>%
  filter(created >= as.POSIXct("2026-05-01 00:00:00"))

data2 <- data2 %>%
  filter(!is.na(curso))

sjmisc::frq(data2$nombre_colegio)

data2 <- data2 %>%
  filter(nombre_colegio!="test")

completas2 <- data2 %>%
  filter(!is.na(ended))

data <- rbind(data, data2)
completas <- rbind(completas, completas2)

iniciadas <- data
completan_vignetas <- data %>% filter(!is.na(gconflict_01))

save(iniciadas, file="output/iniciadas.RData")
# save(completan_vignetas, file="output/completan_vignetas.RData")
save(completas, file="output/completas.RData")

table(iniciadas$genero)


################## Convocatoria abierta

base_abierta <- jsonlite::read_json("input/data/original/vignetas abierto 2026-10-19.json", simplifyVector = TRUE)
base_abierta <- as.data.frame(base_abierta)

data_abierta <- filter(base_abierta, start_01==1)
names(data_abierta)
class(data_abierta$created)

data_abierta <- data_abierta %>%
  mutate(created = as.POSIXct(created))

data_abierta <- data_abierta %>%
  filter(created >= as.POSIXct("2026-05-01 00:00:00"))

data_abierta <- data_abierta %>%
  filter(!is.na(curso))

sjmisc::frq(data_abierta$nombre_colegio)

completas_abierta <- data_abierta %>%
  filter(!is.na(ended))

iniciadas_abierta <- data_abierta
completan_vignetas <- data_abierta %>% filter(!is.na(gconflict_01))

save(iniciadas_abierta, file="output/iniciadas_abierta.RData")
# save(completan_vignetas, file="output/completan_vignetas.RData")
save(completas_abierta, file="output/completas_abierta.RData")

table(iniciadas_abierta$genero)

