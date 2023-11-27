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
		printar
		condic
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

printar:	'mostra' ID {System.out.println($ID.text);}
			PV;

texto: (ID | ESP)*;

condic:   'se' {codJava += "if ";}  AP apj comparador FP fpj AC acj cmd FC fcj
		  ('senao' {codJava += "else ";} AC acj cmd FC fcj)?
		  PV pvj;
	
comparador: (ID {codJava += $ID.text;}| NUM {codJava += $NUM.text;}) (OPER_REL | OPER_ARIT) (ID {codJava += $ID.text;}| NUM {codJava += $NUM.text;})
			;

cmd:    (condic | atrib | comparador)*
		;

pvj:			{codJava += ";";};
apj:			{codJava += "(";};
fpj:			{codJava += ")";};
acj:			{codJava += "{";};
fcj:			{codJava += "}";};
espj:			{codJava += " ";};
oper_atribj:	{codJava += "=";};

ID :	[a-zA-Z]+;
NUM:	[0-9]+;
FRAC:	([0-9]+)+','+[0-9]*;
PV:		';' ;
AP:		'(' ;
FP:		')' ;
AC:		'{' ;
FC:		'}' ;
ESP:	' ' ;
OPER_ATRIB: ':=' ;
OPER_ARIT: '/' {codJava += "/";} | '*' {codJava += "*";} | '-' {codJava += "-";} | '+'{codJava += "+";};
OPER_REL: '>' {codJava += ">";} | '<' {codJava += "<";} | '>=' {codJava += ">=";} | '<=' {codJava += "<=";} | '==' {codJava += "==";} | '!=' {codJava += "!=";};
WS : [ \t\r\n]+ -> skip;
