grammar trabalho;

@header { import java.util.*; }
@members{
    // Código Java que será incorporado na classe gerada
    // Pode incluir métodos, variáveis, inicializadores, etc.
	Variavel novaVariavel = new Variavel();
	Print interCode = new Print();
	String codJava = "";
	int escopo;
	int tipo;
}

comeca: 'comeco'{System.out.println(interCode.printComeco());}
		condic
		'termina'{codigoJava += "\t}\n}";
			     System.out.println(codigoJava);
			     };


atrib:  ID {	boolean resultado = cv.jaExiste($ID.text);
				if(!resultado){
					System.err.println("A variavel "+$ID.text+" nao foi declarada");
					System.exit(0);
				else {
					}
				}
			}
		PV
     ;

declarar:    (
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


condic:   'se' {codJava += "if "} AP comparador FP AC cmd FC
		  ('senao' AC cmd FC)?
		  PV;
	
comparador: (ID {codJava += "$ID.text "}| NUM {codJava += $NUM.text}) (OPER_REL | OPER_ARIT) (ID {codJava += "$ID.text "}| NUM {codJava += $NUM.text})
    ;

cmd:    (condic | atrib | comparador)*
   ;


ID : [a-zA-Z]+;
NUM: [0-9]+;
FRAC: ([0-9]+)+','+[0-9]*;
PV: ';' {codJava += ";"};
AP: '(' {codJava += "("};
FP: ')' {codJava += ")"};
AC: '{' {codJava += "{"};
FC: '}' {codJava += "}"};
OPER_ATRIB: ':=' {codJava += "="};
OPER_ARIT: '/' {codJava += "/"} | '*' {codJava += "*"} | '-' {codJava += "-"} | '+'{codJava += "+"};
OPER_REL: '>' {codJava += ">"} | '<' {codJava += "<"} | '>=' {codJava += ">="} | '<=' {codJava += "<="} | '==' {codJava += "=="} | '!=' {codJava += "!="};
WS : [ \t\r\n]+ -> skip;
