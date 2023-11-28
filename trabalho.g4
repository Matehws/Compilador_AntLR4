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
		condic
		printar
		'termina'{codJava += "\t}\n}";
			     System.out.println(codJava);
			     };


atrib:  ID {	boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
					}
				}
		PV
     ;

declarar:    (
                tipo
                ID { novaVariavel = new Variavel($ID.text, tipo);
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
							codJava += "float ";}
        )
   ;

printar:	'mostra ' texto {codJava += "System.out.println("+$texto.text+");";}  #TEM QUE COLOCAR " " EM VOLTA DO PRINT, SE NÃO FICA ERRADO
			PV;


texto:		(ID 
	|		ESP 
	|		expr 
	|		FRAC 
	|		NUM )*;


condic:   	'se' {codJava += "if ";}  AP apj comparador FP fpj AC acj cmd FC fcj
			('senao' {codJava += "else ";} AC acj cmd FC fcj)?
			PV pvj {codJava += "\n";};
	
comparador:	expr (OPER_REL_MAI {codJava += ">=";}) expr
			;

cmd:    (condic 
	|	atrib 
	|	comparador 
	|	ESP 
	|	expr 
	|	ESP)*
		;
		
expr:   expr (OPER_ARIT_VEZ {codJava += "*";} | OPER_ARIT_DIV {codJava += "/";}) expr
    |   expr (OPER_ARIT_MAI {codJava += "+";} | OPER_ARIT_MEN {codJava += "-";}) expr
    |   NUM {codJava += $NUM.text;}
	|   FRAC {codJava += $FRAC.text;}
    |   ID {codJava += $ID.text;}
    |   AP apj expr FP fpj;

stat:   expr
    |   ID OPER_ATRIB oper_atribj expr
    |   laco
    |   comparador
    ;
	
laco: 	'enquanto' AP apj comparador FP fpj AC acj stat FC fcj
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


ID :		[a-zA-Z]+;
NUM:		[0-9]+;
FRAC:		([0-9]+)+','+[0-9]*;
PV:			';' ;
AP:			'(' ;
FP:			')' ;
AC:			'{' ;
FC:			'}' ;
ESP:		' ' ;
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
