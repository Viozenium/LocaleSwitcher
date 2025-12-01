import tkinter as tk
from tkinter import messagebox
import subprocess
import atexit

def main():
    
    # ----------------------------
    # Definizione dei locali disponibili
    LOCALE_ORIGINALE = "it-IT"
    LOCALE_GIAPPONESE = "ja-JP"
    LOCALE_INGLESE = "en-US"
    
    # ----------------------------
    # Variabile per tenere traccia del locale modificato
    locale_modificato = None

    def set_locale(locale):
        
        """
        Cambia il locale di sistema al valore specificato.

        Parametri:
        locale (str): codice del locale da impostare (es. 'it-IT', 'ja-JP', 'en-US')

        Mostra una finestra di conferma se il cambio è avvenuto con successo,
        altrimenti mostra un messaggio di errore.
        """
        
        global locale_modificato
        try:
            # Comando PowerShell per cambiare il locale
            cmd = f'Set-Culture -CultureInfo "{locale}"'
            subprocess.run(["powershell", "-Command", cmd], check=True)
            locale_modificato = locale
            messagebox.showinfo("Successo", f"Locale cambiato a {locale}")
        except Exception as e:
            messagebox.showerror("Errore", str(e))

    def restore_locale():
        
        """
        Ripristina il locale originale se è stato modificato durante l'esecuzione.

        Questa funzione viene registrata tramite atexit per essere eseguita automaticamente
        alla chiusura del programma.
        """
        
        global locale_modificato
        if locale_modificato:
            try:
                cmd = f'Set-Culture -CultureInfo "{LOCALE_ORIGINALE}"'
                subprocess.run(["powershell", "-Command", cmd], check=True)
            except:
                pass

    # ----------------------------
    # Registra il ripristino automatico del locale originale alla chiusura
    atexit.register(restore_locale)

    # ----------------------------
    # Label informativa
    root = tk.Tk()
    root.title("Locale Switcher")
    root.geometry("400x150")

    # ----------------------------
    # Creazione della finestra principale dell'applicazione
    tk.Label(root, text="Seleziona il locale desiderato:").pack(pady=10)

    # ----------------------------
    # Pulsanti per selezionare i vari locali
    tk.Button(root, text=f"Locale Originale ({LOCALE_ORIGINALE})", width=25,
            command=lambda: set_locale(LOCALE_ORIGINALE)).pack(pady=5)
    tk.Button(root, text=f"Giapponese ({LOCALE_GIAPPONESE})", width=25,
            command=lambda: set_locale(LOCALE_GIAPPONESE)).pack(pady=5)
    tk.Button(root, text=f"Inglese ({LOCALE_INGLESE})", width=25,
            command=lambda: set_locale(LOCALE_INGLESE)).pack(pady=5)
    tk.Button(root, text="Esci", width=25, command=root.destroy).pack(pady=5)

    # ----------------------------
    # Avvio del loop principale dell'interfaccia grafica
    root.mainloop()

if __name__ == '__main__':
    main()