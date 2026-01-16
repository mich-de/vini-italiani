add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Edg/120.0.0.0"

function Download-Image {
    param ($SearchTerm, $Filename)
    
    Write-Host "Searching for $SearchTerm..."
    # Search on Bing Images which usually has direct links in the HTML
    $SearchUrl = "https://www.bing.com/images/search?q=$([Uri]::EscapeDataString($SearchTerm))&first=1"
    
    try {
        $Response = Invoke-WebRequest -Uri $SearchUrl -UserAgent $UserAgent -TimeoutSec 10 -UseBasicParsing
        
        # Regex to find image URLs (Bing puts them in murl or mediaurl)
        # Looking for .jpg or .png
        if ($Response.Content -match 'murl&quot;:&quot;(https://[^&quot;]+\.(jpg|png))&quot;') {
            $ImageUrl = $matches[1]
            Write-Host "Found Image: $ImageUrl"
            
            try {
                Invoke-WebRequest -Uri $ImageUrl -OutFile "d:\python\vini2026\foto_vini\$Filename" -UserAgent $UserAgent -TimeoutSec 10 -UseBasicParsing
                Write-Host "Saved to $Filename"
                return $true
            } catch {
                Write-Host "Failed to download image: $_"
            }
        } else {
            Write-Host "No image found in search results."
        }
    } catch {
        Write-Host "Search failed: $_"
    }
    return $false
}

# 1. Gattinara
Download-Image "Gattinara Travaglini bottiglia vino" "alto_piemonte.png"
# 2. Roero
Download-Image "Roero Arneis DOCG bottiglia vino" "roero_docg.png"
# 3. Ruche
Download-Image "Ruche Castagnole Monferrato bottiglia" "ruche.png"
# 4. Timorasso
Download-Image "Timorasso Derthona bottiglia" "timorasso.png"
# 5. Lugana
Download-Image "Lugana DOC bottiglia" "lugana.png"
# 6. Moscato Scanzo
Download-Image "Moscato di Scanzo bottiglia" "moscato_scanzo.png"
# 7. Fior d'Arancio
Download-Image "Fior d'Arancio Colli Euganei bottiglia" "fior_arancio.png"
# 8. Grechetto
Download-Image "Grechetto Orvieto bottiglia" "grechetto.png"
# 9. Cesanese
Download-Image "Cesanese del Piglio bottiglia" "cesanese_piglio.png"
# 10. Lacrima
Download-Image "Lacrima di Morro d'Alba bottiglia" "lacrima_morro.png"
# 11. Vernaccia
Download-Image "Vernaccia Serrapetrona bottiglia" "vernaccia_serrapetrona.png"
# 12. Tintilia
Download-Image "Tintilia Molise bottiglia" "tintilia.png"
# 13. Susumaniello
Download-Image "Susumaniello vino bottiglia" "susumaniello.png"
# 14. Ciro Rosso
Download-Image "Ciro Rosso Classico bottiglia" "ciro_rosso.png"
# 15. Etna Rosso
Download-Image "Etna Rosso bottiglia" "etna_rosso.png"
# 16. Etna Bianco
Download-Image "Etna Bianco bottiglia" "etna_bianco.png"
# 17. Cerasuolo
Download-Image "Cerasuolo di Vittoria bottiglia" "cerasuolo_vittoria.png"
