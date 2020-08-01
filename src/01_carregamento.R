library(openxlsx)
library(readxl)
library(WriteXLS)
library(ggthemes)
library(RColorBrewer)
library(lubridate)
library(caret)
library(tidyverse)
library(here)
library(usethis)
library(googlesheets4)
library(googledrive)
library(clipr)

Sys.setenv(TZ="Brazil/East")
options(tz="Brazil/East")
Sys.getenv("TZ")
options(scipen = 999999)


# Carrega as tabelas do google drive por mês
maio <- read_sheet(ss = "1wi2G6pDu_2FR5Xwc1niOZ6DKeBv_CMI_W24Ck2ZiBbM", sheet = 'Internações_Maio', col_names = FALSE, skip = 1)
junho <- read_sheet(ss = "1wi2G6pDu_2FR5Xwc1niOZ6DKeBv_CMI_W24Ck2ZiBbM", sheet = 'Internações_Junho', col_names = FALSE, skip = 1)

# Cria variável mes para guardar a informação a que mês pertence o dado
maio$mes <- 5
junho$mes <- 6

# Junta os df mensais em um df geral
pacientes <- bind_rows(maio, junho)
names(pacientes) <- c("nome", "prontuario", "dt_int", "dias_vm", "vm", "covid", "mes")   # troca os nomes das variáveis

duplicados <- pacientes %>% 
  filter(duplicated(nome)) %>% 
  pull(nome)


x <- pacientes %>% 
  filter(nome %in% duplicados)



