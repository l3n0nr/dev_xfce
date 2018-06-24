Bem vindo ao script de automação de tarefas no Linux. 

    Ele poderá realizar:
        - Atualização do sistema;
        - Correção de erros;
        - Limpeza geral do sistema;
        - Instalação de programas;
        - Remoção de programas desnecessários;

    Exemplos:        
        - Funcoes do script:
            ~ v5.sh vetor "atualiza/corrige/config/limpa/instala"

        - Para listar alguma especifica dentro de "atualiza/corrige/limpa/instala", basta:
            ~v5.sh vetor ajuda "atualiza/corrige/config/limpa/instala"

        - Para executar todas as funções(semi-automático)
            ~ v5.sh todas(contém funcões que necessitam de interação do usuário)

        - Após a maquina ser formatada(apenas as funções automáticas e depois desliga a máquina)
            ~ v5.sh formatado(desliga a máquina, após finalização do script)        

        - Interface em dialog  
            ~ v5.sh interface
                [Zenity - EM DESENVOLVIMENTO]

    **    SCRIPT COMPATIVEL COM UBUNTU 16.04 LTS | DEBIAN TESTING    **
