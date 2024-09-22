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
head(datos)

# visualizacion

install.packages("ggplot2")
install.packages("gridExtra")
library(ggplot2)
library(gridExtra)

# Crear histogramas
hist_modificado <-ggplot(datos, aes(x = Modificado)) +
  geom_histogram(binwidth = 0.2, fill = "blue", color = "white") +
  ggtitle("Histograma de Modificado") +
  xlab("Valores") +
  ylab("Frecuencia")

hist_sin_modificar <-ggplot(datos, aes(x = `Sin Modificar`)) +
  geom_histogram(binwidth = 0.2, fill = "red", color = "white") +
  ggtitle("Histograma de Sin Modificar") +
  xlab("Valores") +
  ylab("Frecuencia")

# Mostrar ambos gráficos en una sola visualización
grid.arrange(hist_modificado, hist_sin_modificar, ncol = 2)