#------Cargue inicial de Datos------

# Instalar el paquete readxl si no lo tienes instalado
install.packages("readxl")
# Cargar el paquete readxl
library(readxl)
# Especificar la ruta del archivo de Excel usar (/)
ruta_archivo <- "C:/Users/acerc/OneDrive/Escritorio/Diseño de experimentos/Exp1.xlsx"
# Crea base de datos desde el archivo de Excel
datos <- read_excel(ruta_archivo)
# Mostrar los primeros registros del archivo head para los primeros 6 ,
# Mostrar todos los registros Print
head(datos, n=10)

#-----Analisis exploratorio de los datos-----

# visualizacion de datos en Histograma
install.packages("ggplot2")
install.packages("gridExtra")
library(ggplot2)
library(gridExtra)

#Crear histogramas visualizar por variable desde ggplot para visualizar ambos
#todo el script
#Histograma Variable "Modificado"
hist_modificado <-ggplot(datos, aes(x = Modificado)) +
geom_histogram(binwidth = 0.2, fill = "blue", color = "white") +
ggtitle("Histograma de Modificado") +
xlab("Valores") +
ylab("Frecuencia")
#Histograma Variable "sin_Modificar"
hist_sin_modificar <-ggplot(datos, aes(x = `Sin_Modificar`)) +
geom_histogram(binwidth = 0.2, fill = "red", color = "white") +
ggtitle("Histograma de Sin Modificar") +
xlab("Valores") +
ylab("Frecuencia")

# Mostrar ambos gráficos en una sola visualización
grid.arrange(hist_modificado, hist_sin_modificar, ncol = 2)

# Crear boxplot
# Renombrar las columnas si tienen espacios
colnames(datos) <- c("Modificado", "Sin_Modificar")
boxplot(datos,
        main = "Boxplot de Fuerza de Adhesión",
        xlab = "Tratamiento",
        ylab = "Fuerza de Adhesión",
        col = c("blue", "red"))

# test de normalidad de shapiro Shapiro-Wilk
# Realizar el test de Shapiro-Wilk para cada columna
shapiro_test_modificado <- shapiro.test(datos$Modificado)
shapiro_test_sin_modificar <- shapiro.test(datos$Sin_Modificar)

# Mostrar los resultados
shapiro_test_modificado
shapiro_test_sin_modificar


#resumen de los datos
summary (datos)
#Calculo de la desvicion estandar "modificado"
desMod<-sd(datos$Modificado)
print(desMod)
#Calculo de la desvicion estandar "sin_modificar"
desSmod<-sd(datos$Sin_Modificar)
print(desSmod)

#-----Ajuste de los datos a una distribucion normal-----

# Simulación de 30 eventos para cada tratamiento
set.seed(123)  # Para reproducibilidad

sim_Sin_Modificar <- rnorm(30, mean = 17.92, sd = 0.24)
sim_Modificado <- rnorm(30, mean = 16.72, sd = 0.31)

# Crear un data frame
datos_simulados <- data.frame(
  Tratamiento = rep(c("Sin_Modificar", "Modificado"), each = 30),
  Fuerza_Adhesion = c(sim_Sin_Modificar, sim_Modificado)
)

# Mostrar los primeros 30 valores del data frame
head(datos_simulados, 60)

#Reorientar el dataframe datos simulados
# Instalar y cargar el paquete tidyr si no lo tienes
install.packages("tidyr")
install.packages("dplyr")
library(dplyr)
library(tidyr)

# Crear el data frame original
datos_simulados <- data.frame(
  Tratamiento = rep(c("Sin_Modificar", "Modificado"), each = 30),
  Fuerza_Adhesion = c(sim_Sin_Modificar, sim_Modificado)
)

# Reorganizar el data frame
datos_reorganizados <- datos_simulados %>%
  group_by(Tratamiento) %>%
  mutate(id = row_number()) %>%
  pivot_wider(names_from = Tratamiento, values_from = Fuerza_Adhesion)

# Mostrar los primeros 10 valores del data frame reorganizado
head(datos_reorganizados, 10)

print(datos_reorganizados, n=30)

#----Visualizacion de datos re-organizados-----------

# Crear histogramas desde datos normalizados
hist_smodificado <-ggplot(datos_reorganizados, aes(x = Modificado)) +
  geom_histogram(binwidth = 0.2, fill = "lightblue", color = "white") +
  ggtitle("Histograma de Modificado") +
  xlab("Valores") +
  ylab("Frecuencia")

hist_ssin_modificar <-ggplot(datos_reorganizados, aes(x = `Sin_Modificar`)) +
  geom_histogram(binwidth = 0.2, fill = "pink", color = "white") +
  ggtitle("Histograma de Sin Modificar") +
  xlab("Valores") +
  ylab("Frecuencia")

grid.arrange(hist_smodificado, hist_ssin_modificar, ncol = 2)

#crear boxplot desde datos re-organizados
# Convertir el data frame a formato largo
datos_largo <- datos_reorganizados %>%
  pivot_longer(cols = -id, names_to = "Tratamiento", values_to = "Fuerza_Adhesion")

# Crear el boxplot
boxplot <- ggplot(datos_largo, aes(x = Tratamiento, y = Fuerza_Adhesion, fill = Tratamiento)) +
  geom_boxplot() +
  ggtitle("Boxplot de Fuerza de Adhesión por Tratamiento") +
  xlab("Tratamiento") +
  ylab("Fuerza de Adhesión") +
  theme_minimal()+
  scale_fill_manual(values = c("Sin_Modificar" = "pink", "Modificado" = "lightblue"))

# Mostrar el boxplot
print(boxplot)

# prueba de normalidad a datos simulados
# test de normalidad de shapiro Shapiro-Wilk
# Realizar el test de Shapiro-Wilk para cada columna
shapiro_test_smodificado <- shapiro.test(datos_reorganizados$Modificado)
shapiro_test_ssin_modificar <- shapiro.test(datos_reorganizados$Sin_Modificar)

# Mostrar los resultado
shapiro_test_smodificado
shapiro_test_ssin_modificar
