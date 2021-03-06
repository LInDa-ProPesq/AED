x <- c(2, 4.2, 5, 4.88)  ## criando um vetor tipo numeric
x
x <- c("a", "carro", "c2", "22")  ## criando um vetor com texto (tipo character)
x
x <- as.factor(c("a", "carro", "c2", "22"))  ## criando um fator (veja a diferença)
x
x <- c(FALSE, TRUE, TRUE)  ## criando um vetor com valores lógicos (TRUE e FALSE)
x
x <- c(NA, 9, 16, -1)
x
sqrt(x)  # raiz
x/0
1:10  ## situação bem usual
-2:4  ## sequência iniciando com número negativo
10:1  ## sequência descrescente

rm(list=ls())   ## apaga (quase tudo) antes de uma nova análise (boa prática)
nomearquivo<-file.choose()       
endereco <- "http://s3.amazonaws.com/ihbs-html/dados/ODB2013originalcorrigido.csv" ## especifica a localização do arquivo
df <- read.csv2(endereco, fileEncoding = "latin1") ## "carga" da tabela em formato .csv para o R
dim(df)  ## mostrará o número de linhas (casos) e colunas (variáveis) já em formato de data.frame em R
str(df, 1:5)

df[1:3, 1:8]  ## mostra linhas 1 a 4 e colunas 1 a 5 do data.frame

names(df)

nomesorig <- names(df)  # preservando os nomes originais das variáveis

novonome <- c("dh", "num", "loc", "sex", "dan", "alt", "pes", "cal", "cir", 
              "mao", "pub", "fac", "alu", "sta", "uni", "pg1", "pg2", "hco", "hmq", "est", 
              "cid", "cso", "ipa", "in1", "in2", "in3", "in4", "ol1", "ol2", "rel1", "rel2", 
              "mu1", "mu2", "ho1", "ho2", "fum", "alc", "ani", "tim", "sat", "odi", "odf", 
              "odl", "oda", "odt", "cus", "con", "out", "nlv", "liv")

names(df) <- novonome ## atribuindo novos nomes de variáveis

names(df)  ## exibindo os novos nomes

df$sex

levels(df$sex)  ## mostra os níveis ou categorias da variável sex no data.frame df
## [1] "Feminino"  "Masculino"
levels(df$sex) <- c("f", "m")  # troca por identificadores mais sintéticos
levels(df$sex)  ## mostrando os novos nomes, já alterados na variável
## [1] "f" "m"
df$sex <- factor(df$sex, levels(df$sex)[c(2, 1)])  # reordenação de níveis
levels(df$sex)  # note a reordenação abaixo

df$sex <- factor(df$sex, levels(df$sex)[c(2, 1)])
levels(df$sex)  # note o retorno à ordem anterior

levels(df$loc)
## [1] "UAT"      "UCR"      "UCR, UAT"
levels(df$loc) <- c("at", "cr", "po")

levels(df$mao)
## [1] "Canhoto (usa a mão esquerda para escrever)"
## [2] "Destro (usa a mão direita para escrever)"  
levels(df$mao) <- c("c", "d")

levels(df$fac)
##  [1] "Administração de Empresas"    "Engenharia Agronômica"       
##  [3] "Engenharia Agrícola"          "Engenharia Ambiental"        
##  [5] "Engenharia Eletrica"          "Engenharia Mecatrônica"      
##  [7] "Engenharia Mecânica"          "Engenharia Produção Mecânica"
##  [9] "Engenharia Química"           "Engenharia de Alimentos"     
## [11] "Engenharia de Automação"      "Engenharia de Meio Ambiente" 
levels(df$fac) <- c("adm", "eagri", "eagro", "eamb", "eali", "eauto", "emambi", 
                        "ee", "emec", "emeca", "eprod", "equi")


## Criando novas variáveis (tempg e cures) para facilitar a análise dos
## cursos de pg
levels(df$pg1)
## [1] "Completei 1 ou mais cursos de especialização"                                                                       
## [2] "Completei 1 ou mais cursos de especialização, Estou cursando a pós em Engenharia de Segurança"                      
## [3] "Estou cursando a pós em Engenharia de Segurança"                                                                    
## [4] "Estou cursando a pós em Engenharia de Segurança, Estou cursando um ou mais cursos de especialização"                
## [5] "Estou cursando um ou mais cursos de especialização"                                                                 
## [6] "Nunca cursei Pós graduação"                                                                                         
## [7] "Tenho mestrado, Estou cursando a pós em Engenharia de Segurança, Estou cursando um ou mais cursos de especialização"
df$tempg <- df$pg1
levels(df$tempg) <- c("esp", "esp", "cur", "cur", "cur", "nc", "msc")
df$cures <- df$pg1
levels(df$cures) <- c("n", "s", "s", "s", "n", "n", "s")

# Criando variável df$itot com os pontos totais no inglês
df$itot <- df$in1 + df$in2 + df$in3 + df$in4

levels(df$ani)
## [1] "Não tenho animal de estimação" "Tenho um ou mais cachorros"   
levels(df$ani) <- c("n", "s")

levels(df$tim)
##  [1] "Atlético Mineiro"             "Corinthians"                 
##  [3] "Cruzeiro"                     "E C Vitória"                 
##  [5] "Flamengo"                     "Goiás"                       
##  [7] "Grêmio"                       "Não me interesso por futebol"
##  [9] "Outro time"                   "Palmeiras"                   
## [11] "Santos"                       "São Paulo"                   
levels(df$tim) <- c("am", "co", "cr", "vi", "fl", "go", "gr", "ni", "ot", 
                        "pa", "sa", "sp")

levels(df$odf)
## [1] "Jovem Parceiro" "Outras formas" 
levels(df$odf) <- c("j", "o")

levels(df$oda)
## [1] "Agrícola (Operação)"                         
## [2] "Agrícola (Planejamento e/ou Controle)"       
## [3] "Ambiente"                                    
## [4] "Indústria (Planejamento e/ou Controle)"      
## [5] "Manutenção Automotiva"                       
## [6] "Manutenção Automotiva, Manutenção Industrial"
## [7] "Manutenção Industrial"                       
## [8] "Parcerias e Fornecedores"                    
levels(df$oda) <- c("agop", "agpc", "ambi", "inpc", "mana", "manai", "mani", 
                        "parf")
## Acesso a observação 3 da variável df$alt
df$alt[3]
## [1] 1.89
## Acesso às observações 2, 3 e 7
df$alt[c(2, 3, 7)]
## [1] 1.60 1.89 1.87
## Modificando valores de vetores
alt2 <- df$alt[c(2, 3, 7)]  ## criando uma réplica de df$alt
alt2[c(2, 3, 7)] <- c(1.5, 1.72, 1.8)  ## alterando as observações 2, 3 e 7
prop.table(table(df$sex))
## 
##      f      m 
## 0.3913 0.6087 
## Observações de altura dos df do sexo feminino
df$alt[df$sex == "f"]

df$sex == "f" 
df$alt[df$sex == "f" & df$loc == "at"]  # (& corresponde ao **e** lógico)
df$alt[df$sex == "f" | df$pes >= 70]  # (| corresponde ao **ou** lógico)

## estatísticas elementares incondicionais
mean(df$alt)  # média
median(df$alt)  # mediana
sd(df$alt)  # desvio padrão
max(df$alt)  # máximo
min(df$alt)  # mínimo

## estatísticas elementares condicionais
mean(df$alt[df$sex == "f"])  # média da altura das mulheres
mean(df$alt[df$sex == "m"])  # média da altura dos homens

# algumas estatísticas do núm do sapato para pessoas com altura maior que 1,6 trabalhando em Alto Taquari
median(df$cal[df$alt > 1.6 & df$loc == "at"])
sd(df$cal[df$alt > 1.6 & df$loc == "at"])
max(df$cal[df$alt > 1.6 & df$loc == "at"])
min(df$cal[df$alt > 1.6 & df$loc == "at"])

df$alt[which.max(df$pes)]

tapply(df$alt, df$sex, mean)

tapply(df$alt, list(df$sex, df$loc), mean)


n <- length(df$sex)  ## definindo o número de observações
sum(df$sex == "f")  ## frequência absoluta de mulheres (possibilidade 1)

length(df$sex[df$sex == "f"])  ## frequência absoluta de mulheres (possibilidade 1)

sum(df$sex == "f")/n  ## frequência relativa de mulheres

length(df$sex[df$sex == "m"])  ## frequência absoluta de homens

length(df$sex[df$sex == "m"])/n  ## frequência relativa de mulheres

## Sexo dos df
table(df$sex)

prop.table(table(df$sex))

table(df$loc)

prop.table(table(df$loc))

ident <- c("Mulheres", "Homens")
barplot(table(df$sex), names.arg = ident, col = c("pink", "lightblue"))

ident <- c("Mulheres", "Homens")
barplot(prop.table(table(df$sex)) * 100, names.arg = ident, col = c(gray(0.8), gray(0.5)))
title(main = "Frequência relativa - sexo", xlab = "sexo", ylab = "%")

ident <- c("Mulheres", "Homens")
pie(prop.table(table(df$sex)) * 100, label = ident, col = c("lightblue2","lightblue3")) 
title(main = "Frequência relativa - sexo")

sum(df$sex == "f" & df$loc == "at")

sum(df$sex == "m" & df$loc == "at")

sum(df$sex == "f" & df$loc == "cr")

sum(df$sex == "m" & df$loc == "cr")

sum(df$sex == "f" & df$loc == "po")

sum(df$sex == "m" & df$loc == "po")

table(df$sex, df$loc)
prop.table(table(df$sex, df$loc))

oldoptions <- options()  # preservando as opções existentes
options(digits = 3)

prop.table(table(df$odf, df$loc, df$sex))

length(df$sex[df$sex == "m" & df$loc == "at"])/length(df$sex[df$loc =="at"])
sum(df$sex == "m" & df$loc == "at")/sum(df$loc == "at")                                                                             



prop.table(table(df$sex, df$loc), 2)

prop.table(table(df$odf, df$loc, df$sex), 3)


## gráfico de barras justapostas (segunda variável no eixo x) - Frequência
## conjunta absoluta
barplot(table(df$sex, df$loc), beside = TRUE, legend.text = TRUE, args.legend = list(x = 8.8,                                                                                              y = 5, title = "sexo", horiz = TRUE, cex = 0.8))
title("Frequências conjuntas absolutas\n sexo x localização", xlab = "localização", 
      ylab = "df")

## gráfico de barras empilhadas (segunda variável no eixo x) - Frequência
## conjunta relativa
barplot(prop.table(table(df$sex, df$loc)) * 100, legend.text = TRUE, 
        xpd = TRUE, args.legend = list(x = "right", title = "sexo", horiz = FALSE, 
                                       inset = -0.07, cex = 0.8))
title("Frequências conjuntas relativas\n sexo x localização", xlab = "localização", 
      ylab = "%")

## Gráfico de frequência condicional (df$sex|df$loc)
barplot(prop.table(table(df$sex, df$loc), 2) * 100, legend.text = TRUE, 
        xpd = TRUE, ylim = c(0, 100), args.legend = list(x = "right", title = "sexo", 
                                                         horiz = FALSE, inset = -0.07, cex = 0.8))
title("Frequências condicionais relativas\n sexo | localização", xlab = "localização", 
      ylab = "%")


## carregamento do package vcd (deve ser instalado antes)
require(vcd)
## gráfico tipo mosaico - frequências condicionais sexo | localização
mosaic(sex ~ loc, data = df, highlighting_fill = c("pink", "lightblue"))


## gráfico tipo mosaico - frequências condicionais sexo | localização,
## tipo de ingresso
mosaic(sex ~ loc + odf, data = df, highlighting_fill = c("pink", "lightblue"))

## carregamento do package vcd (deve ser instalado antes)
require(vcd)
## gráfico tipo doubledecker, frequência condicional sexo | localização,
## tipo de ingresso
doubledecker(loc ~ sex + odf, data = df)

df$imc <- df$pes/df$alt^2
## histograma do peso dos df - básico
hist(df$imc, breaks = 5)

## a próxima implementação incorpora algumas opções específicas e deixa o
## número de categorias para o R especificar
hist(df$imc, xlab = "IMC", ylab = "densidade de frequência", main = "Histograma do IMC", 
     col = "bisque", freq = FALSE)

boxplot(df$imc)

boxplot(df$imc ~ df$sex, col = "bisque")

abrestring <- function(mvec, sep) {
  n <- length(mvec)
  nvec <- list()
  for (i in 1:n) {
    nvec <- list(nvec, strsplit(as.character(mvec[i]), sep))
  }
  nvec <- unlist(nvec)
  return(nvec)
}

relhobbies <- abrestring(df$ho1, ", ")
table(relhobbies)

totrelig <- as.factor(abrestring(df$rel1, ", "))
levels(totrelig) <- c("at", "ca", "es", "ev", "ad", "ou", "pr")
table(totrelig)

livvec <- as.factor(abrestring(df$liv, ";"))
levels(livvec)

levels(livvec)[c(1, 2, 4, 8, 34, 35)] <- c("Cinquenta Tons de Cinza mais Escuro", 
                                           "Diablo III", "A Cabana", "A Cabana", "Sobreviver, Crescer e Perpetuar", 
                                           "Sobreviver, Crescer e Perpetuar")

levels(livvec)

sort(table(livvec), decreasing = TRUE)

write.table(df, "./dados/ODB2018.csv", sep = ";", dec = ",",row.names = FALSE) # no ruindows...
            
