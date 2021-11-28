from conector import Interface_base
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame

class Functions:
    try:
        def import_CSV():
            try:
                banco_13 = Interface_base()
                # Importando os arquivos csv para o dataframe
                df_dados1 = pd.read_csv('dados1.csv', sep = ',', usecols = ['data', 'valor'])
                df_dados2 = pd.read_csv('dados2.csv', sep = ',', usecols = ['data', 'valor'])
                
                df_dados = df_dados1.append(df_dados2)  # Concatenando os dois arquivos em um
                df_dados['data'] = pd.to_datetime(df_dados.data) # Convertendo os objetos data para formato de datetime
                df_dados = df_dados.sort_values(by=['data']) # Organizando os dados por data
                df_dados = df_dados.dropna() # Dropando as linhas com campos de data ou valor vazios
                dados = np.array(df_dados) # Convertendo o dataframe para array
                lista =[]
                                
                for dado in dados:
                    dado = tuple(dado)
                    data = str(dado[0])            
                    values = (data, dado[1])
                    query = f"insert into entrada (data_entrada, valor) values {values}"
                    banco_13.action(query)
            except Exception as e:
                print("Error {str(e)}")
        

        def bloc_select(): # TODO arrumar a data
            try:
                for i in range(0, 2000, 50):
                    banco_13 = Interface_base()
                    query = f"select data_entrada, valor from entrada where id > {i} limit 50"
                    entrada = banco_13.action(query)
                    lista = []
                    for item in entrada:    
                        lista.append(item[1])# Organizando                                             min(lista), max(lista)
                    query2 = "insert into informacoes (media, mediana, moda, desvio, padrao, maior, menor, data_inicio, data_fim) values (mean(lista), median(dados), moda(dados), descvio(dados.....)"
                    
                    for item in entrada:
                        data = str(item[0])          
                        lista.append(data)
                        
                    print(max(lista))
                    print(min(lista))

            except Exception as e:
                print("Error {str(e)}")
    except Exception as e:
        print(f"Error {str(e)}")