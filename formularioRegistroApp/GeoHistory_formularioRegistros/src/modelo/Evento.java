package modelo;

public class Evento {
    private String nombreCorto;
    private String nombre;
    private String fecha;
    private String descripcion;
    private int ordenRelevancia;
    private String coordenadas;
    private String linkWiki;

    // Constructor, getters y setters
    public Evento(String nombreCorto, String nombre, String fecha, String descripcion, int ordenRelevancia, String coordenadas, String linkWiki) {
        this.nombreCorto = nombreCorto;
        this.nombre = nombre;
        this.fecha = fecha;
        this.descripcion = descripcion;
        this.ordenRelevancia = ordenRelevancia;
        this.coordenadas = coordenadas;
        this.linkWiki = linkWiki;
    }

    public String getNombreCorto() { return nombreCorto; }
    public String getNombre() { return nombre; }
    public String getFecha() { return fecha; }
    public String getDescripcion() { return descripcion; }
    public int getOrdenRelevancia() { return ordenRelevancia; }
    public String getCoordenadas() { return coordenadas; }
    public String getLinkWiki() { return linkWiki; }
}
