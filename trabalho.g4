grammar trabalho;

@header { import java.util.*; }
@members{
    // Código Java que será incorporado na classe gerada
    // Pode incluir métodos, variáveis, inicializadores, etc.
    @members{
	Print interCode = new Print();
    }
}

comeca: 'comeco'{System.out.print(interCode.printComeco());};
		declarar
		'fim' {System.out.print(interCode.printFim());};
		


declarar:	'numero' {System.out.print("\nint ");}
			ID {System.out.print($ID.text+";\n");} PV;
			
			
printar:


teclar:
			

ID : [a-zA-Z]+;
INT: [0-9]+;
FLOAT: ([0-9]+)+[0-9]*;
PV: ';' ;
AP: '(' ;
FP: ')' ;
OPER_AT: '=' | ':' ;
OPER_REL: '>' | '<' | '>=' | '<=' | '==' | '!=' ;
WS : [ \t\r\n]+ -> skip;