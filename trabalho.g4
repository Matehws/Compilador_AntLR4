grammar trabalho;

@header { import java.util.*; }
@members{
    // Código Java que será incorporado na classe gerada
    // Pode incluir métodos, variáveis, inicializadores, etc.
    @members{
	Variavel novaVariavel = new Variavel();
	Print interCode = new Print();
	String codJava = "";
	int escopo;
	int tipo;
    }
}

comeca: 'comeco'{System.out.print(interCode.printComeco());};
		declarar
		'fim' {System.out.print(interCode.printFim());};
		



   atrib:  ID {	boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
				}
			}
		PV
     ;

declvar:    (
                tipo
                ID { novaVariavel = new Variavel($ID.text, tipo, escopo);
                     boolean declarado = cv.adiciona(novaVariavel);
					 if(!declarado){
					    System.err.println("Variavel "+$ID.text+" ja foi declarada!!!");
					    System.exit(0);
					 }
					 codJava += $ID.text;
				   }
		        PV {codJava += ";\n";}
		    )*
       ;

tipo:   (
            'natural'   {	tipo = 0;
							codJava += "int ";
						} |
            'texto'     {	tipo = 1;
							codJava += "String ";
						} |
            'decimal'   {	tipo = 2;
							codJava += "float "}
        )
   ;


senao:   'se' AP comparador FP AC cmd FC
		('senao' AC cmd FC )?
	;

comparador:   (ID | NUM) OPREL (ID | NUM)
    ;

cmd:    (cond |atrib)*
   ;

enquanto:


para: 



termina:



declarar:	'numero' {System.out.print("\nint ");}
			ID {System.out.print($ID.text+";\n");} PV;
			
			
printar:	'printar' ID {}




   
   
teclar:
			

ID : [a-zA-Z]+;
NUM: [0-9]+;
FRAC: ([0-9]+)+","+[0-9]*;
PV: ';' ;
AP: '(' ;
FP: ')' ;
AC: '{' ;
FC: '}' ;
OPER_ATRIB: ':=';
OPER_ARITMETICO: '/' | '*' | '-' | '+';
OPER_REL: '>' | '<' | '>=' | '<=' | '==' | '!=' ;
WS : [ \t\r\n]+ -> skip;
