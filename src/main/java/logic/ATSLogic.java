package logic;

import java.io.InputStream;
import java.util.*;

import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

/**
 * Equivalente al logic.php original.
 * Analiza el texto del CV y calcula el match score
 * contra las keywords del perfil de vacante activo.
 */
public class ATSLogic {

    // ── Perfil de vacante activo ──────────────────────────────────────────────
    public static final String VACANTE_TITULO = "Desarrollador Full Stack Java";

    public static final Map<String, Integer> KEYWORDS_PESO;

    static {
        Map<String, Integer> m = new LinkedHashMap<>();
        m.put("java", 30);
        m.put("spring", 25);
        m.put("sql", 20);
        m.put("react", 15);
        m.put("docker", 10);
        KEYWORDS_PESO = Collections.unmodifiableMap(m);
    }

    // ── Calcular score ────────────────────────────────────────────────────────

    /**
     * Extrae el texto del PDF y calcula el score.
     * El JSP solo pasa el InputStream — PDFBox vive aquí.
     */
    public static Candidato procesarCVDesdeStream(String nombre, String email,
                                                   InputStream pdfStream) throws Exception {

        String cvTexto = "";

        try (PDDocument doc = Loader.loadPDF(pdfStream.readAllBytes())) {
            PDFTextStripper stripper = new PDFTextStripper();
            cvTexto = stripper.getText(doc);
        }

        return procesarCV(nombre, email, cvTexto);
    }

    /**
     * Calcula el score basado en las keywords del perfil.
     */
    public static Candidato procesarCV(String nombre, String email, String cvTexto) {

        String texto = cvTexto.toLowerCase();

        int scoreTotal = 0;
        int pesoTotal = KEYWORDS_PESO.values()
                .stream()
                .mapToInt(i -> i)
                .sum();

        List<String> detectadas = new ArrayList<>();

        for (Map.Entry<String, Integer> entry : KEYWORDS_PESO.entrySet()) {

            if (texto.contains(entry.getKey())) {

                scoreTotal += entry.getValue();
                detectadas.add(entry.getKey());

            }

        }

        // Normalizar a porcentaje
        int scorePct = (pesoTotal > 0)
                ? (int) Math.round(scoreTotal * 100.0 / pesoTotal)
                : 0;

        String kwStr = detectadas.isEmpty()
                ? "—"
                : String.join(", ", detectadas);

        return new Candidato(nombre, email, scorePct, kwStr);
    }

    // ── Ordenar candidatos por score descendente ──────────────────────────────
    public static List<Candidato> ordenar(List<Candidato> lista) {

        List<Candidato> copia = new ArrayList<>(lista);

        copia.sort((a, b) -> Integer.compare(b.getScore(), a.getScore()));

        return copia;
    }
}