from modules.conector import Interface_base
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame
import statistics

class Functions:
    try:        
        def import_CSV():
            try:
                banco_13 = Interface_base("user", "user", "127.0.0.1", "banco_13")                
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
                    data = str(dado[0])            
                    values = (data, dado[1])
                    query = f"insert into entrada (data_entrada, valor) values {values}"
                    banco_13.action(query)
            except Exception as e:
                print(f"Error {str(e)}")
        

        def bloc_select():
            try:
                banco_13 = Interface_base("user", "user", "127.0.0.1", "banco_13")
                for i in range(0, 9000000000, 50):                    
                    query = f"select data_entrada, valor from entrada where id > {i} limit 50"
                    entrada = banco_13.action(query) 
                    if entrada == []:
                        break
                    else:
                        valores, data = [], []                    
                        for item in entrada:
                            data.append(item[0]) 
                            valores.append(float(item[1]))
                        valores = np.array(valores)
                        values = (str(np.min(data)), str(np.max(data)), valores.mean(), np.median(valores), statistics.mode(valores), statistics.stdev(valores), valores.max(), valores.min())
                        query = f"insert into informacoes (data_inicio, data_fim, media, mediana, moda, desvio, maximo, minimo) values {values}"
                        banco_13.action(query)
                   
            except Exception as e:
                print(f"Error {str(e)}")

        
    except Exception as e:
        print(f"Error {str(e)}")

        