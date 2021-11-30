from modules.functions import Functions

if __name__ == "__main__":
    try:
        while True:
            print("Escolha a opção desejada.", "[1] - Inserir arquivos em CSV", "[2] - Fazer Análise dos blocos de 50.", "[3] - Consultar tabela de entrada", "[4] - Consultar tabela de médias", "[5] - Consultar tabela de log", "[0] - Sair", sep = "\n")
            escolha = input("Digite a opção: ")

            if escolha == "1":
                print("Inserção iniciada...")
                Functions.import_CSV()
                print("inserção finalizada")
            
            elif escolha == "2":
                print("Análise iniciada...")
                Functions.bloc_select()
                print("Análise finalizada")

            elif escolha == "3":
                Functions.selection_entrada()

            elif escolha == "4":
                Functions.selection_informacoes()
            
            elif escolha == "5":
                Functions.selection_log()
            
            elif escolha == "0":
                break

            else:
                print("Opção inválida tente novamente.\n")


               
    except Exception as e:
        print(str(e))









