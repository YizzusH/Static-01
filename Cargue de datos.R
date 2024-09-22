# Instalar el paquete readxl si no lo tienes instalado
install.packages("readxl")

# Cargar el paquete readxl
library(readxl)

# Especificar la ruta del archivo de Excel
ruta_archivo <- "C:/Users/acerc/OneDrive/Escritorio/Diseño de experimentos/Exp1.xlsx"

# Leer el archivo de Excel
datos <- read_excel(ruta_archivo)

# Mostrar los primeros registros del archivo
print(datos)

