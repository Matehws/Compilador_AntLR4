	grammar trabalho;

@header {import java.util.*;}
@members{
	Variavel novaVariavel = new Variavel();
	ControleVariavel cv = new ControleVariavel();
	String codJava = "";
	String importJava = "";
	int tipo;
	String nome;
	
}

comeca: {codJava += "public class Codigo{\n\t";}
		'comeca;'{ codJava += "public static void main(String args[]){\n\t\t";}
		declarar
		operacao
		'termina'{codJava += "\t}\n}";
					System.out.println(importJava);
					System.out.println(codJava);};

atribuir:  ID ESP 	{boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
					}
				else {codJava += $ID.text+" ";};
					}
			OPER_atrib oper_atribj ESP
			(texto	{codJava += $texto.text;}
			| NUM 	{codJava += $NUM.text;} 
			| FRAC 	{codJava += $FRAC.text;})
			PV pvj 	{codJava += "\n";}
			;

declarar:   (	tipo
                ID {novaVariavel = new Variavel($ID.text, tipo);
                    boolean declarado = cv.adiciona(novaVariavel);
					if(!declarado){
						System.err.println("Variavel "+$ID.text+" ja foi declarada!!!");
						System.exit(0);
					}
					codJava += $ID.text;}
		        PV pvj {codJava += "\n";})*
				;

tipo:   (	'inteiro '  {tipo = 0;
						codJava += "int ";} 
			|'texto '   {tipo = 1;
						codJava += "String ";} 
			|'decimal '{tipo = 2;
						codJava += "float ";})
   ;
   
teclar:   	'escreve'   {importJava += "import java.util.*;\n";}
						{codJava += "Scanner scanner = new Scanner(System.in);\n";}
						{codJava += "System.out.print(\"Digite algo: \");\n";}
						{codJava += "String textoUsuario = scanner.nextLine();\n";}
                        {codJava += "System.out.println(\"Voce digitou: \" + textoUsuario);\n";}
						{codJava += "scanner.close();";}
                        PV
                        ;

printar:	'mostra ' 	{codJava += "\nSystem.out.println(";} 
						(ID {boolean resultado = cv.jaExiste($ID.text);
						if(!resultado){
							System.err.println("A variavel "+$ID.text+" nao foi declarada");
							System.exit(0);}
						else {codJava += $ID.text;}}
						| texto {codJava += $texto.text;})
					{codJava += ")";}
			PV pvj
			;
			
texto:		'"' (ID
	|		ESP
	|		FRAC
	|		NUM)*
			'"'
	;

condicional:   	'se' {codJava += "\nif ";}  AP apj comparador FP fpj AC acj cmd FC fcj
			('senao' {codJava += "\nelse ";} AC acj cmd FC fcj)?
			PV pvj {codJava += "\n";}
			;
	
comparador:	expr	( OPER_REL_MA oper_rel_maj
					| OPER_REL_ME oper_rel_mej
					| OPER_REL_MAI oper_rel_maij
					| OPER_REL_MEI oper_rel_meij
					| OPER_REL_II oper_rel_iij
					| OPER_REL_EI oper_rel_eij
					) expr
			;

operacao: 	( atribuir
			| expr 
			| enquantoLoop
			| paraLoop
			| printar 
			| teclar
			| condicional)+
			;

cmd:    (condicional
	|	atribuir
	|	comparador
	|	ESP
	|	expr
	|	printar)*
	;
		
expr:   fator
	| 	fator (OPER_ARIT_VEZ oper_arit_vezj fator | OPER_ARIT_DIV oper_arit_divj fator)
    |   fator (OPER_ARIT_MAI oper_arit_maij fator | OPER_ARIT_MEN oper_arit_menj fator)
	;

fator: 		NUM {codJava += $NUM.text;}
		| 	FRAC {codJava += $FRAC.text;}
		|	ID {codJava += $ID.text;}
		|	AP apj expr FP fpj
		;

stat:   (expr
    |   ID OPER_atrib oper_atribj expr
    |   enquantoLoop
	|	condicional
    |   comparador PV pvj
	|	printar
	|	ESP
	|	ID {boolean resultado = cv.jaExiste($ID.text);
			if(!resultado){
				System.err.println("A variavel "+$ID.text+" nao foi declarada");
				System.exit(0);}}
		{codJava += $ID.text;}
		OPER_INCRE oper_increj PV pvj)+
    ;

enquantoLoop: 	'enquanto ' {codJava += "\nwhile ";} AP apj comparador FP fpj AC acj stat FC fcj
		PV pvj
		;
		
paraLoop: 	'para' {codJava += "\nfor ";} AP apj {codJava += "int i=";} NUM {codJava += $NUM.text;} FP AP {codJava += ";i";} paraCompara {codJava += ";i";} FP AP (OPER_INCRE oper_increj | OPER_DECRE oper_decrej) FP fpj
			{codJava += "{System.out.println(\"Iteracao \" + i);}";}
			PV
		;

paraCompara: (OPER_REL_MA oper_rel_maj
			|OPER_REL_ME oper_rel_mej
			|OPER_REL_MAI oper_rel_maij
			|OPER_REL_MEI oper_rel_meij
			|OPER_REL_EI oper_rel_eij)+
			NUM {codJava += $NUM.text;}
			;

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

oper_increj: {codJava += "++";};
oper_decrej: {codJava += "--";};

ID :		[a-zA-Z]+;
NUM:		[0-9]+;
FRAC:		([0-9]+)+'.'+[0-9]*;
PV:			';' ;
AP:			'(' ;
FP:			')' ;
AC:			'{' ;
FC:			'}' ;
ESP:		' ' | '\n';
OPER_atrib: '=' | ':' | ':=';

OPER_ARIT_DIV: '/';
OPER_ARIT_VEZ: '*';
OPER_ARIT_MEN: '-';
OPER_ARIT_MAI: '+';
OPER_INCRE: '++';
OPER_DECRE: '--';

OPER_REL_MA:	'>';
OPER_REL_ME: 	'<';
OPER_REL_MAI: 	'>=';
OPER_REL_MEI:	'<=';
OPER_REL_II:	'==';
OPER_REL_EI: 	'!=';


OU: 	'||';
E:  	'&&';
WS: 	[ \t\r\n]+ -> skip;
