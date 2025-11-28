# ===========================
#   Cambia formato regionale -> Ripristina
# ===========================

<#
    Locale Switcher
    Autore: Viozenium
    Scopo: Permette di cambiare rapidamente il locale di sistema tramite GUI
#>

# Importa librerie per creare una GUI Windows
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Definizione dei locali utilizzati
$localeOriginale = "it-IT"			# Locale originale del sistema
$localeGiapponese = "ja-JP"			# Locale giapponese
$localeInglese    = "en-US"			# Locale universale

$localeModificato = $false			# Indica se il locale è stato cambiato

# ===============================
#  Funzione: Cambia il locale in sicurezza
# ===============================
function Set-LocaleSafe($locale) {
    try {
        # Imposta il locale
        Set-Culture -CultureInfo $locale
        
        # Svuota cache culturale per applicare correttamente
        [System.Globalization.CultureInfo]::CurrentCulture.ClearCachedData()

        # Segna che il locale è stato modificato
        $script:localeModificato = $true

        # Messaggio di conferma
        [System.Windows.Forms.MessageBox]::Show(
            "Locale cambiato a: $locale",
            "Successo",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Information
        )
    }
    catch {
        # Messaggio di errore
        [System.Windows.Forms.MessageBox]::Show(
            "Errore nel cambiare locale: $_",
            "Errore",
            [System.Windows.Forms.MessageBoxButtons]::OK,
            [System.Windows.Forms.MessageBoxIcon]::Error
        )
    }
}

# ===============================
#  Funzione: Ripristina locale
# ===============================
function Ripristina-Locale {
    if ($script:localeModificato -eq $true) {
        # Ritorna al locale originale
        Set-Culture -CultureInfo $localeOriginale

        # Svuota cache culturale
        [System.Globalization.CultureInfo]::CurrentCulture.ClearCachedData()

        $script:localeModificato = $false
    }
}

# ===============================
#  Interfaccia Grafica (GUI)
# ===============================

# Crea la finestra principale
$form = New-Object System.Windows.Forms.Form
$form.Text = "Girls' Frontline - Locale Switcher"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"

# Etichetta descrittiva
$label = New-Object System.Windows.Forms.Label
$label.Text = "Seleziona il locale desiderato:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20,20)
$form.Controls.Add($label)

# Pulsante: Locale originale
$btnOriginale = New-Object System.Windows.Forms.Button
$btnOriginale.Text = "Locale Originale (it-IT)"
$btnOriginale.Size = New-Object System.Drawing.Size(150,30)
$btnOriginale.Location = New-Object System.Drawing.Point(20,60)
$btnOriginale.Add_Click({ Set-LocaleSafe $localeOriginale })
$form.Controls.Add($btnOriginale)

# Pulsante: Locale giapponese
$btnGiapponese = New-Object System.Windows.Forms.Button
$btnGiapponese.Text = "Giapponese (ja-JP)"
$btnGiapponese.Size = New-Object System.Drawing.Size(150,30)
$btnGiapponese.Location = New-Object System.Drawing.Point(200,60)
$btnGiapponese.Add_Click({ Set-LocaleSafe $localeGiapponese })
$form.Controls.Add($btnGiapponese)

# Pulsante: Locale inglese
$btnInglese = New-Object System.Windows.Forms.Button
$btnInglese.Text = "Inglese (en-US)"
$btnInglese.Size = New-Object System.Drawing.Size(150,30)
$btnInglese.Location = New-Object System.Drawing.Point(20,100)
$btnInglese.Add_Click({ Set-LocaleSafe $localeInglese })
$form.Controls.Add($btnInglese)

# Pulsante: Esci
$btnEsci = New-Object System.Windows.Forms.Button
$btnEsci.Text = "Esci"
$btnEsci.Size = New-Object System.Drawing.Size(150,30)
$btnEsci.Location = New-Object System.Drawing.Point(200,100)
$btnEsci.Add_Click({ $form.Close() })
$form.Controls.Add($btnEsci)

# Evento: Quando la finestra viene chiusa, ripristina il locale
$form.Add_FormClosing({ Ripristina-Locale })

# Avvia la GUI
[void]$form.ShowDialog()
