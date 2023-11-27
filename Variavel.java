/**
 *
 * @author amgjunior
 */
public class Variavel {
    private String nome;
    private int tipo;

    public Variavel(String nome, int tipo) {
        this.nome = nome;
        this.tipo = tipo;
    }

    public Variavel() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }
    
    
    public void imprime(){
        System.out.println("Nome: "+nome+"\nTipo: "+tipo);
    }
}