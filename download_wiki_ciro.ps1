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

# Download Cirò Rosso (Real from Wiki)
Invoke-WebRequest -Uri "https://upload.wikimedia.org/wikipedia/commons/c/c1/Cir%C3%B2_rosso_wine_and_bottle_1.jpg" -OutFile "d:\python\vini2026\foto_vini\ciro_rosso.png" -UseBasicParsing
