from logging import info
from modules.conector import Interface_base
import pandas as pd
import numpy as np
from pandas.core.frame import DataFrame
import statistics

# TODO - melhorar a documentação e comentários

class Functions:
    """Metodos com o processamento dos dados para resolução das questões
    
    """
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
                    data = str(dado[0]) # Convertendo a data para string            
                    values = (data, dado[1]) # montando a tupla com data e valor para inserir na query
                    query = f"insert into entrada (data_entrada, valor) values {values}"
                    banco_13.action(query) # abre a conexao, executa a query e fecha a conexao
            except Exception as e:
                print(f"Error {str(e)}")
        

        def bloc_select(): #
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
        
        def selection_entrada():
            try:
                banco_13 = Interface_base("user", "user", "127.0.0.1", "banco_13")
                query = f"select data_entrada, valor from entrada"
                entrada = banco_13.action(query)
                df_entrada = pd.DataFrame(columns=["Data", "valor"], data = entrada)
                print(df_entrada)
            except Exception as e:
                print(f"Error {str(e)}")

        def selection_informacoes():
            try:
                banco_13 = Interface_base("user", "user", "127.0.0.1", "banco_13")
                query = f"select data_inicio, data_fim, media, mediana, moda, desvio, maximo, minimo from informacoes"
                informacoes = banco_13.action(query)
                df_informacoes = pd.DataFrame(columns=["Data Inicio", "Data fim", "Média", "Mediana", "Moda", "Desvio", "Valor Máximo", "Valor Minimo"], data = informacoes)               
                print(df_informacoes)
            except Exception as e:
                print(f"Error {str(e)}")
        
        def selection_log():
            try:
                banco_13 = Interface_base("user", "user", "127.0.0.1", "banco_13")
                query = f"select user, data_log, descricao from entrada_log"
                log = banco_13.action(query)
                df_log = pd.DataFrame(columns=["User", "Data Log", "Descrição"], data = log)
                print(df_log)

            except Exception as e:
                print(f"Error {str(e)}")

    except Exception as e:
        print(f"Error {str(e)}")

        