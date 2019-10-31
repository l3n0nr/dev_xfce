Bem vindo ao script de automação de tarefas no Debian. 

    Ele poderá realizar no sistema:
        - Atualização;
        - Correção de erros;
        - Configurações personalizadas;
        - Limpeza geral;
        - Instalação de programas padrões e opcionais;
        - Remoção de programas desnecessários;

    Exemplos:        
        - Funções disponiveis:
            ~ v5.sh vetor "atualiza/corrige/config/limpa/instala/instala_outros"

        - Para listar algumas funções especificas dentro dos vetores, basta:
            ~ v5.sh vetor ajuda "atualiza/corrige/config/limpa/instala/instala_outros"

        - Para executar a maiora das funções de forma automática:
            ~ v5.sh geral(contém funções que não necessitam de interação com o usuário)

        - Para executar todas as funções(semi-automático)
            ~ v5.sh todas(contém funcões que necessitam de interação do usuário)

        - Após a maquina ser formatada(apenas as funções automáticas e depois desliga a máquina)
            ~ v5.sh formatado(desliga a máquina, após finalização do script)        

        - Interfaces disponiveis no script
            ~ v5.sh interface_d
                - Interface em dialog

            ~ v5.sh interface_z
                - Interface em zenity
