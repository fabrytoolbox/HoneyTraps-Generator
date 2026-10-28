# HoneyTraps-Generator.ps1 - v1.0 (Matrix Defense Edition)
# Genera file esca (honeypot) per attirare e studiare infostealer.
# ATTENZIONE: Usare SOLO su macchine virtuali isolate (sandbox).

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$script:workDir = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$script:logFile = $null
$script:baseDir = [System.Environment]::GetFolderPath("UserProfile")

# ============================================
# LOGGING
# ============================================
function Start-Log {
    $ts = Get-Date -Format "yyyyMMdd_HHmmss"
    $script:logFile = Join-Path $script:workDir "HoneyTraps_$ts.log"
    "--- HONEYTRAPS GENERATOR LOG ---" | Set-Content -Path $script:logFile -Encoding UTF8
}

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $ts = Get-Date -Format "HH:mm:ss"
    $line = "[$ts] [$Level] $Message"
    if ($txtLog) {
        $txtLog.AppendText("$line`r`n")
        $txtLog.SelectionStart = $txtLog.TextLength
        $txtLog.ScrollToCaret()
        [System.Windows.Forms.Application]::DoEvents()
    }
    if ($script:logFile) {
        Add-Content -Path $script:logFile -Value $line -Encoding UTF8
    }
}

# ============================================
# GENERATORI DI ESCHE
# ============================================

function New-CryptoWalletBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $balance = Get-Random -Minimum 5 -Maximum 51
    $wallet = @{
        coin = "Bitcoin"
        address = "1FakeWalletAddressXYZ123456789ABCDEF"
        balance = "{0:N2} BTC" -f $balance
        last_access = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
        seed_phrase = "apple banana cherry dog elephant frog grape house igloo jungle kite lemon"
        note = "NON CONDIVIDERE QUESTA SEED PHRASE CON NESSUNO"
    }
    
    $file = Join-Path $path "wallet_crypto_backup.json"
    $wallet | ConvertTo-Json -Depth 3 | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-PasswordsBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $passwords = @(
        "=== CREDENZIALI SALVATE ===",
        "",
        "Google: utente.esca@gmail.com / PasswordFarlocca123!",
        "Facebook: utente.esca@hotmail.com / SocialPassword2025",
        "PayPal: utente.esca@paypal.com / PayPalSicuro123!",
        "Amazon: utente.esca@gmail.com / AmazonPrime2025",
        "Home Banking: Cliente987654 / PIN: 123456",
        "Netflix: utente.esca@gmail.com / NetflixFamily2025"
    )
    
    $file = Join-Path $path "passwords.txt"
    $passwords -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-BankDetailsBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $bank = @(
        "=== DATI BANCARI RISERVATI ===",
        "",
        "Banca: Banca Farlocca S.p.A.",
        "IBAN: IT99Z0542841800000000123456",
        "Swift/BIC: BAFRIT33XXX",
        "Intestatario: Mario Rossi",
        "Codice Cliente: 9876543210",
        "PIN: 123456",
        "Codice Fiscale: RSSMRA80A01H501X",
        "Saldo disponibile: 125.430,50 EUR"
    )
    
    $file = Join-Path $path "Dati_Bancari_Segreti.txt"
    $bank -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-PGPKeyBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $pgp = @(
        "-----BEGIN PGP PRIVATE KEY BLOCK-----",
        "Version: GnuPG v2.1.20 (MingW32)",
        "",
        "lQOYBF+X1a8BCADH7p8FjJhZ3tJdKz4qY5s6vW8xR2mN9pL0qT1uV3wX5yZ7aB9cD1eF3gH5iJ7kL9",
        "mN1oP3qR5sT7uV9wX1yZ3aB5cD7eF9gH1iJ3kL5mN7oP9qR1sT3uV5wX7yZ9aB1cD3eF5gH7iJ9",
        "kL1mN3oP5qR7sT9uV1wX3yZ5aB7cD9eF1gH3iJ5kL7mN9oP1qR3sT5uV7wX9yZ1aB3cD5eF7gH9",
        "-----END PGP PRIVATE KEY BLOCK-----"
    )
    
    $file = Join-Path $path "chiave_privata.asc"
    $pgp -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-BlackmailBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $blackmail = @(
        "=== PROVA DI RICATTO - NON APRIRE ===",
        "",
        "Log Chat Confidenziali 2024 (cifrato)",
        "Hash File Originale: E3F4D0A9C1B2D5E6F7A8B9C0D1E2F3A4",
        "",
        "Contatto: agente.segreto@protonmail-farlocca.com",
        "Scadenza pagamento: 2025-12-31",
        "",
        "IMPORTANTE: Non divulgare. Solo l'agente X conosce la password."
    )
    
    $file = Join-Path $path "Ricatto_Segreto_Log.txt"
    $blackmail -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-IllegalTxBait {
    $path = Join-Path $script:baseDir "Documents\Dati Segreti"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $tx = @(
        "=== TRANSAZIONE ILLEGALE OFFSHORE ===",
        "",
        "Data: 2025-10-26",
        "Importo: 5.000.000 EUR",
        "Beneficiario: Conto Offshore YZ90 - Cayman Islands",
        "Causale: Consulenza non documentata",
        "",
        "Riferimento transazione: TX-2025-987654321",
        "Codice SWIFT: CAYMKYXXXXX"
    )
    
    $file = Join-Path $path "Transazione_Ilegale_2025.txt"
    $tx -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

function New-MetamaskBait {
    $path = Join-Path $script:baseDir "Downloads"
    if (-not (Test-Path $path)) { New-Item -ItemType Directory -Path $path -Force | Out-Null }
    
    $metamask = @(
        "=== METAMASK WALLET BACKUP ===",
        "",
        "Mnemonic: apple banana cherry dog elephant frog grape house igloo jungle kite lemon",
        "Address: 0xFakeMetaMaskAddress1234567890ABCDEF",
        "Network: Ethereum Mainnet",
        "",
        "NON PERDERE QUESTA FRASE!"
    )
    
    $file = Join-Path $path "metamask_seed.txt"
    $metamask -join "`r`n" | Set-Content -Path $file -Encoding UTF8
    Write-Log "Creato: $file" "OK"
}

# ============================================
# GENERATORE COMPLETO
# ============================================

function New-AllBaits {
    Write-Log "Avvio generazione di tutte le esche..." "INFO"
    New-CryptoWalletBait
    New-PasswordsBait
    New-BankDetailsBait
    New-PGPKeyBait
    New-BlackmailBait
    New-IllegalTxBait
    New-MetamaskBait
    Write-Log "Tutte le esche create con successo!" "OK"
}

# ============================================
# GUI MATRIX
# ============================================
$form = New-Object System.Windows.Forms.Form
$form.Text = "HONEYTRAPS GENERATOR - MATRIX DEFENSE"
$form.Size = New-Object System.Drawing.Size(700, 650)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::Black
$form.ForeColor = [System.Drawing.Color]::Lime
$form.Font = New-Object System.Drawing.Font("Consolas", 9)

$lblTitle = New-Object System.Windows.Forms.Label
$lblTitle.Text = "HONEYTRAPS GENERATOR"
$lblTitle.Font = New-Object System.Drawing.Font("Consolas", 16, [System.Drawing.FontStyle]::Bold)
$lblTitle.ForeColor = [System.Drawing.Color]::Lime
$lblTitle.TextAlign = "MiddleCenter"
$lblTitle.Location = New-Object System.Drawing.Point(20, 10)
$lblTitle.Size = New-Object System.Drawing.Size(640, 30)
$form.Controls.Add($lblTitle)

$lblSub = New-Object System.Windows.Forms.Label
$lblSub.Text = "Genera file esca per attirare infostealer (SOLO su VM isolate!)"
$lblSub.Font = New-Object System.Drawing.Font("Consolas", 9, [System.Drawing.FontStyle]::Italic)
$lblSub.ForeColor = [System.Drawing.Color]::Gray
$lblSub.TextAlign = "MiddleCenter"
$lblSub.Location = New-Object System.Drawing.Point(20, 45)
$lblSub.Size = New-Object System.Drawing.Size(640, 20)
$form.Controls.Add($lblSub)

# --- Pulsanti ---
function New-MatrixButton { param($text, $x, $y, $w, $h, $color = "Black") 
    $b = New-Object System.Windows.Forms.Button
    $b.Text = $text
    $b.Location = New-Object System.Drawing.Point($x, $y)
    $b.Size = New-Object System.Drawing.Size($w, $h)
    $b.FlatStyle = "Flat"
    $b.FlatAppearance.BorderColor = [System.Drawing.Color]::Lime
    $b.ForeColor = [System.Drawing.Color]::Lime
    $b.BackColor = $color
    $form.Controls.Add($b)
    return $b
}

$y = 80
$btnCrypto = New-MatrixButton "GENERA CRYPTO WALLET BAIT" 20 $y 300 35
$y += 45
$btnPasswords = New-MatrixButton "GENERA PASSWORDS BAIT" 20 $y 300 35
$y += 45
$btnBank = New-MatrixButton "GENERA BANK DETAILS BAIT" 20 $y 300 35
$y += 45
$btnPGP = New-MatrixButton "GENERA PGP KEY BAIT" 20 $y 300 35
$y += 45
$btnBlackmail = New-MatrixButton "GENERA BLACKMAIL BAIT" 20 $y 300 35
$y += 45
$btnIllegalTx = New-MatrixButton "GENERA ILLEGAL TRANSACTION BAIT" 20 $y 300 35
$y += 45
$btnMetaMask = New-MatrixButton "GENERA METAMASK BAIT" 20 $y 300 35
$y += 45
$btnAll = New-MatrixButton "GENERA TUTTE LE ESCHE" 20 $y 300 35 "DarkGreen"
$btnAll.Font = New-Object System.Drawing.Font("Consolas", 10, [System.Drawing.FontStyle]::Bold)

$btnExit = New-MatrixButton "TERMINATE" 500 470 160 35 "DarkRed"

# --- Log ---
$txtLog = New-Object System.Windows.Forms.TextBox
$txtLog.Multiline = $true
$txtLog.ScrollBars = "Vertical"
$txtLog.Location = New-Object System.Drawing.Point(20, 520)
$txtLog.Size = New-Object System.Drawing.Size(640, 80)
$txtLog.ReadOnly = $true
$txtLog.BackColor = [System.Drawing.Color]::FromArgb(10, 10, 10)
$txtLog.ForeColor = [System.Drawing.Color]::Lime
$txtLog.Font = New-Object System.Drawing.Font("Consolas", 8)
$txtLog.BorderStyle = "FixedSingle"
$form.Controls.Add($txtLog)

# ============================================
# EVENTI
# ============================================
$btnCrypto.Add_Click({ New-CryptoWalletBait })
$btnPasswords.Add_Click({ New-PasswordsBait })
$btnBank.Add_Click({ New-BankDetailsBait })
$btnPGP.Add_Click({ New-PGPKeyBait })
$btnBlackmail.Add_Click({ New-BlackmailBait })
$btnIllegalTx.Add_Click({ New-IllegalTxBait })
$btnMetaMask.Add_Click({ New-MetaMaskBait })
$btnAll.Add_Click({ New-AllBaits })
$btnExit.Add_Click({ $form.Close() })

# ============================================
# AVVIO
# ============================================
Start-Log
$form.Add_Shown({
    Write-Log "HoneyTraps Generator avviato." "INFO"
    Write-Log "ATTENZIONE: usare solo su VM isolate." "WARNING"
})

# ============================================
# DISCLAIMER LEGALE E DI SICUREZZA (BLOCCANTE)
# ============================================
$disclaimerText = @"
ATTENZIONE - STRUMENTO DI SICUREZZA OFFENSIVA

Questo tool genera file esca (honeypot) contenenti DATI FITTIZI progettati per attirare malware (infostealer, RAT, ecc.).

REGOLE TASSATIVE:
1. Usalo SOLO su macchine virtuali isolate (sandbox).
2. NON eseguirlo su PC di produzione o con dati reali.
3. Sei l'unico responsabile dell'uso improprio di questo software.
4. L'autore non si assume alcuna responsabilità per danni, perdite di dati o conseguenze legali derivanti dall'uso di questo tool.

Cliccando 'SI', confermi di aver letto e compreso queste regole e di trovarti in un ambiente sicuro.
"@

$disclaimerResult = [System.Windows.Forms.MessageBox]::Show(
    $disclaimerText,
    "DISCLAIMER - HONEYTRAPS GENERATOR",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Warning
)

if ($disclaimerResult -ne [System.Windows.Forms.DialogResult]::Yes) {
    exit
}

# ============================================
# AVVIO GUI
# ============================================
Start-Log
$form.Add_Shown({
    Write-Log "HoneyTraps Generator avviato." "INFO"
    Write-Log "ATTENZIONE: usare solo su VM isolate." "WARNING"
})
$form.ShowDialog() | Out-Null
