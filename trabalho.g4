	grammar trabalho;

@header { import java.util.*; }
@members{
	Variavel novaVariavel = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	String codJava = "";
	int tipo;
	String nome;
}

comeca: { codJava += "public class Codigo{\n\t";
		}
		'comeco'{ codJava += "public static void main(String args[]){\n\t\t"; 
				}
		operacao
		'termina'{codJava += "\t}\n}";
			     System.out.println(codJava);
			     };


atrib:  ID ESP {	boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
					}
				else {codJava += $ID.text+" ";};
					}
		OPER_ATRIB oper_atribj ESP
		(ID {codJava += $ID.text;}
		| NUM {codJava += $NUM.text;} 
		| FRAC {codJava += $FRAC.text;})
		PV pvj {codJava += "\n";} 
		;

declarar:   (
                tipo
                ID { novaVariavel = new Variavel($ID.text, tipo);
                     boolean declarado = cv.adiciona(novaVariavel);
					 if(!declarado){
					    System.err.println("Variavel "+$ID.text+" ja foi declarada!!!");
					    System.exit(0);
					 }
					 codJava += $ID.text;
				   }
		        PV pvj {codJava += "\n";}
		    )+
       ;

tipo:   (
            'natural '   {	tipo = 0;
							codJava += "int ";
						} |
            'texto '     {	tipo = 1;
							codJava += "String ";
						} |
            'decimal '   {	tipo = 2;
							codJava += "float ";}
        )
   ;

printar:	'mostra ' {codJava += "\nSystem.out.println(";} (ID {codJava += $ID.text;} | texto {codJava += $texto.text;})
			{codJava += ")";}
			PV pvj
			;
			
texto:		'"' (ID
	|		ESP
	|		FRAC
	|		NUM)*
			'"'
	;
	
textoEscreve:	(ID
	|			ESP
	|			FRAC
	|			NUM)*
	;

teclar: 'escreve ' ID PV {
    codJava += "Scanner scanner = new Scanner(System.in);\n";
    codJava += $ID.text + " = scanner.next();\n";
};				

condic:   	'se' {codJava += "\nif ";}  AP apj comparador FP fpj AC acj cmd FC fcj
			('senao' {codJava += "\nelse ";} AC acj cmd FC fcj)?
			PV pvj {codJava += "\n";};
	
comparador:	expr	(OPER_REL_MA oper_rel_maj
					| OPER_REL_ME oper_rel_mej
					| OPER_REL_MAI oper_rel_maij
					| OPER_REL_MEI oper_rel_meij
					| OPER_REL_II oper_rel_iij
					| OPER_REL_EI oper_rel_eij
					) expr
			;

operacao: 	( declarar
			| atrib
			| expr 
			| enquantoLoop
			| condic 
			| printar 
			| teclar
			| paraLoop)+
			;

cmd:    (condic
	|	atrib
	|	comparador
	|	ESP
	|	expr
	|	printar)*
	;
		
expr:   expr (OPER_ARIT_VEZ oper_arit_vezj | OPER_ARIT_DIV oper_arit_divj) expr
    |   expr (OPER_ARIT_MAI oper_arit_maij | OPER_ARIT_MEN oper_arit_menj) expr
    |   NUM {codJava += $NUM.text;}
	|   FRAC {codJava += $FRAC.text;}
    |   ID {codJava += $ID.text;}
    |   AP apj expr FP fpj;

stat:   expr
    |   ID OPER_ATRIB oper_atribj expr
    |   enquantoLoop
    |   comparador
    ;

enquantoLoop: 	'enquanto ' {codJava += "\nwhile ";} AP apj comparador FP fpj AC acj stat FC fcj
		;
		
paraLoop: 'para ' {codJava += "\nfor ";} AP apj ID 'de' NUM 'ate' NUM AC cmd FC;



pvj:			{codJava += ";";};
apj:			{codJava += "(";};
fpj:			{codJava += ")";};
acj:			{codJava += "{ \n";};
fcj:			{codJava += "}";};
espj:			{codJava += " ";};

oper_atribj:	{codJava += "=";};
oper_arit_divj: {codJava += "/";};
oper_arit_vezj: {codJava += "*";};
oper_arit_menj: {codJava += "-";};
oper_arit_maij: {codJava += "+";};

oper_rel_maj:   {codJava += ">";};
oper_rel_mej:   {codJava += "<";};
oper_rel_maij:  {codJava += ">=";};
oper_rel_meij:  {codJava += "<=";};
oper_rel_iij:   {codJava += "==";};
oper_rel_eij:   {codJava += "!=";};

ID :		[a-zA-Z]+;
NUM:		[0-9]+;
FRAC:		([0-9]+)+'.'+[0-9]*;
PV:			';' ;
AP:			'(' ;
FP:			')' ;
AC:			'{' ;
FC:			'}' ;
ESP:		' '|'\n';
OPER_ATRIB: '=' | ':' | ':=';

OPER_ARIT_DIV: '/';
OPER_ARIT_VEZ: '*';
OPER_ARIT_MEN: '-';
OPER_ARIT_MAI: '+';

OPER_REL_MA:	'>';
OPER_REL_ME: 	'<';
OPER_REL_MAI: 	'>=';
OPER_REL_MEI:	'<=';
OPER_REL_II:	'==';
OPER_REL_EI: 	'!=';

OU: 	'||';
E:  	'&&';
WS: 	[ \t\r\n]+ -> skip;
