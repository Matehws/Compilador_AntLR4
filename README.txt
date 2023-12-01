1. Para rodar o programa, é necessário abrir o path de onde está o arquivo no CMD.

2. Com ele aberto, utilizamos o comando "antlr4 trabalho.g4" (sem aspas) para o Antlr criar os arquivos necessários para a execução do Java.

3. Após esta etapa, outro comando é utilizado, o "javac *.java" (sem aspas), para compilar todo o programa na linguagem Java.

4. E então, conseguimos estar rodando um arquivo de texto na nossa linguagem utilizando o "grun trabalho comeca INTERPRETADOR.txt", com o INTERPRETADOR sendo um dos arquivos .txt de teste, pode estar utilizando os seguintes arquivos:

grun trabalho comeca teste_declarar_atribuir_printar.txt
grun trabalho comeca teste_if.txt
grun trabalho comeca teste_while.txt
grun trabalho comeca teste_scanner.txt
grun trabalho comeca teste_for.txt


5. Depois que o arquivo for rodado, pode estar copiando o código Java gerado no CMD e colando no arquivo "Codigo.java". Assim consegue testar o código que foi criado.

-------------------------------------------------------

Nossa linguagem sempre se inicia com um "comeca" na primeira linha, e finaliza com um "termina" na última. Entre estas palavras, podemos utilizar as seguintes funções:


DECLARAR
Esta função é capaz de declarar uma variável utilizando um dos 3 tipos que a linguagem aceita.
exemplo: inteiro Numero;


ATRIBUIR
Função capaz de dar valor a uma das variáveis declaradas no código.
exemplo: Numero : 5;


PRINTAR
Função capaz de mostrar um texto no terminal Java.
exemplo: mostra "Maria tem 5 amigos.";


CONDICIONAL
Função equivalente ao if de Java, capaz de comparar um código, rodando um comando caso a lógica comparada seja verdadeira ou falsa
exemplo: se(Numero>=4){
mostra Valor maior ou igual a 4;
}senao{
mostra Valor menor do que 4;
};


ENQUANTOLOOP
Função capaz de rodar um código enquanto uma certa condição não ser atingida.
exemplo: enquanto (Numero!=4){
mostra "Valor nao eh 4";
Numero++;
};


PARALOOP
Função capaz de rodar um mesmo bloco de instruções diversas vezes com base em um laço, equivalente ao for do java.
exemplo: para(8)(<10)(++);
para (Valor estático)(condição)(incrementa/decrementa);


TECLAR
Função que chama um Scanner simples em Java que pede um input, e printa o mesmo logo em seguida.
exemplo: escreve;


EXPR
É a função responsável por organizar todas as expressões aritméticas do código, respeitando a ordem de resolução.
















