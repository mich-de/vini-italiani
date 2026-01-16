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

function Download-WikiImage {
    param ($SearchTerm, $Filename)
    
    Write-Host "Searching Wiki for $SearchTerm..."
    # Search for files (namespace 6)
    $Url = "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrnamespace=6&gsrsearch=$([Uri]::EscapeDataString($SearchTerm))&gsrlimit=1&prop=imageinfo&iiprop=url&format=json"
    
    try {
        $Response = Invoke-WebRequest -Uri $Url -UseBasicParsing
        
        # Regex to find "url":"..."
        if ($Response.Content -match '"url":"(https:[^"]+\.(jpg|png|jpeg))"') {
            $ImageUrl = $matches[1]
            Write-Host "Found: $ImageUrl"
            
            # Download
            try {
                Invoke-WebRequest -Uri $ImageUrl -OutFile "d:\python\vini2026\foto_vini\$Filename" -UseBasicParsing
                Write-Host "Successfully saved to $Filename"
            } catch {
                Write-Host "Download failed: $_"
            }
        } else {
            Write-Host "No image found for $SearchTerm"
        }
    } catch {
        Write-Host "API Request failed: $_"
    }
}

# 1. Alto Piemonte (Gattinara)
Download-WikiImage "Gattinara wine bottle" "alto_piemonte.png"

# 2. Roero DOCG
Download-WikiImage "Roero Arneis bottle" "roero_docg.png"

# 3. Ruche
Download-WikiImage "Ruche Castagnole Monferrato" "ruche.png"

# 4. Timorasso
Download-WikiImage "Timorasso wine" "timorasso.png"

# 5. Lugana
Download-WikiImage "Lugana wine bottle" "lugana.png"

# 6. Moscato Scanzo
Download-WikiImage "Moscato di Scanzo" "moscato_scanzo.png"

# 7. Fior d'Arancio
Download-WikiImage "Colli Euganei Fior d'Arancio" "fior_arancio.png"

# 8. Grechetto
Download-WikiImage "Grechetto wine" "grechetto.png"

# 9. Cesanese
Download-WikiImage "Cesanese del Piglio" "cesanese_piglio.png"

# 10. Lacrima
Download-WikiImage "Lacrima di Morro d'Alba" "lacrima_morro.png"

# 11. Vernaccia
Download-WikiImage "Vernaccia di Serrapetrona" "vernaccia_serrapetrona.png"

# 12. Tintilia
Download-WikiImage "Tintilia del Molise" "tintilia.png"

# 13. Susumaniello
Download-WikiImage "Susumaniello wine" "susumaniello.png"

# 14. Ciro Rosso (Already have but good to double check)
Download-WikiImage "Ciro wine bottle" "ciro_rosso.png"

# 15. Etna Rosso
Download-WikiImage "Etna Rosso wine" "etna_rosso.png"

# 16. Etna Bianco
Download-WikiImage "Etna Bianco wine" "etna_bianco.png"

# 17. Cerasuolo
Download-WikiImage "Cerasuolo di Vittoria" "cerasuolo_vittoria.png"
