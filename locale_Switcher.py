import tkinter as tk
from tkinter import ttk
from tkinter import messagebox
from sv_ttk import set_theme
import subprocess
import ctypes
import atexit

__version__ = "1.0.1"
__app_name__ = "Locale switcher"
__author__ = "Mizu"

# --------------------------------------------------------
# Costanti | Definizione dei locali disponibili
LOCALE_ORIGINALE = "it-IT"
LOCALE_GIAPPONESE = "ja-JP"
LOCALE_INGLESE = "en-US"

# ----------------------------
# Variabile per tenere traccia del locale modificato
LOCALE_MODIFICATO = None

# --------------------------------------------------------
# Funzioni di sistema

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False
    
def run_command(cmd_list):
    try:
        result = subprocess.run(
            cmd_list,
            capture_output=True,
            text=True,
            check=True,
            creationflags=subprocess.CREATE_NO_WINDOW
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        raise RuntimeError(e.stderr.strip())
    except Exception as e:
        raise RuntimeError(str(e))

def set_locale(locale):
    try:
        global LOCALE_MODIFICATO
        run_command(["powershell", "-Command", f"Set-Culture -CultureInfo {locale}"])
        messagebox.showinfo("Successo", f"Locale cambiato a {locale}")
        LOCALE_MODIFICATO = locale
    except Exception as e:
        messagebox.showerror("Errore", str(e))

def restore_locale():
    try:
        global LOCALE_MODIFICATO
        if LOCALE_MODIFICATO:
            run_command(["powershell", "-Command", f"Set-Culture -CultureInfo {LOCALE_ORIGINALE}"])
    except:
        pass

class locale_switcher(tk.Tk):
    
    # Label informativa
    def __init__(self):
        super().__init__()
        self.title("Locale Switcher")
        self.geometry("350x225")
        self.minsize(350, 225)
        set_theme("dark")
        self.create_widgets()
    
    # Creazione della finestra principale dell'applicazione
    # Pulsanti per selezionare le varie opzioni
    def create_widgets(self):
        ttk.Label(self, text="Opzioni disponibili:").pack(pady=10)
        
        ttk.Button(self, text=f"Italiano ({LOCALE_ORIGINALE})", width=25, command=lambda: set_locale(LOCALE_ORIGINALE)).pack(pady=5)
        ttk.Button(self, text=f"Giapponese ({LOCALE_GIAPPONESE})", width=25, command=lambda: set_locale(LOCALE_GIAPPONESE)).pack(pady=5)
        ttk.Button(self, text=f"Inglese ({LOCALE_INGLESE})", width=25, command=lambda: set_locale(LOCALE_INGLESE)).pack(pady=5)
        ttk.Button(self, text="Esci", width=25, command=self.destroy).pack(pady=5)

def main():
    
    # --------------------------------------------------------
    # Controllo privilegi di amministratore
    if not is_admin():
        messagebox.showerror("Errore",
            "Questo programma deve essere eseguito come amministratore.\n\n"
            "Clicca con il tasto destro e scegli: 'Esegui come amministratore'.")
        return
    
    # ----------------------------
    # Registra il ripristino automatico del locale originale alla chiusura
    atexit.register(restore_locale)
    
    # ----------------------------
    # Avvio del loop principale dell'interfaccia grafica
    app = locale_switcher()
    app.mainloop()

if __name__ == '__main__':
    main()