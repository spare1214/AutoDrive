import mysql.connector
import hashlib
import smtplib
from datetime import date, datetime

EMAIL_MITTENTE = ""
EMAIL_PASSWORD = ""

def connect_to_db():
    return mysql.connector.connect(
        host="127.0.0.1",
        user="root",
        password="",
        database="portale_vendita_veicoli"
    )

def hash_password(password: str) -> str:
    return hashlib.sha256(password.encode('utf-8')).hexdigest()

def invia_mail_login(email_destinatario, username):
    try:
        data = datetime.now().strftime("%d/%m/%Y %H:%M")
        oggetto = "Subject: Conferma accesso\n\n"
        testo = f"Ciao {username},\n\nHai effettuato l'accesso in data {data}.\nSe non sei stato tu, cambia subito la password."
        msg = oggetto + testo

        server = smtplib.SMTP("smtp.gmail.com", 587)
        server.starttls()
        server.login(EMAIL_MITTENTE, EMAIL_PASSWORD)
        server.sendmail(EMAIL_MITTENTE, email_destinatario, msg)
        server.quit()

        return True
    except Exception as e:
        print("Errore invio mail:", e)
        return False

def register_user():
    conn = connect_to_db()
    cursor = conn.cursor()

    nome = input("Inserisci il nome: ")
    cognome = input("Inserisci il cognome: ")
    username = input("Scegli un username: ")
    email = input("Inserisci la tua email: ")
    password = input("Scegli una password: ")

    cursor.execute(
        "SELECT * FROM utente WHERE username = %s OR email = %s",
        (username, email)
    )

    if cursor.fetchone():
        print("Username o email già esistente!")
        cursor.close()
        conn.close()
        return None

    hashed = hash_password(password)

    cursor.execute(
        "INSERT INTO utente (username, password, email, nome, cognome, data_registrazione) "
        "VALUES (%s, %s, %s, %s, %s, %s)",
        (username, hashed, email, nome, cognome, date.today())
    )

    conn.commit()
    print(f"Registrazione completata per {username}!")

    cursor.close()
    conn.close()
    return username

def login_user():
    conn = connect_to_db()
    cursor = conn.cursor()

    username = input("Inserisci il tuo username: ")
    password = input("Inserisci la tua password: ")

    cursor.execute(
        "SELECT password, email FROM utente WHERE username = %s",
        (username,)
    )

    result = cursor.fetchone()

    if not result:
        print("Username non trovato.")
        cursor.close()
        conn.close()
        return False

    stored_password, email = result
    hashed_input = hash_password(password)

    if hashed_input == stored_password:
        print(f"Login effettuato correttamente per {username}!")

        # Invio mail di conferma accesso
        if invia_mail_login(email, username):
            print("Email di conferma inviata.")
        else:
            print("Login riuscito, ma errore nell'invio email.")

        cursor.close()
        conn.close()
        return True
    else:
        print("Password errata.")
        cursor.close()
        conn.close()
        return False

def main():
    while True:
        print("\n--- Menu ---")
        print("1. Registrazione")
        print("2. Login")
        print("3. Esci")

        scelta = input("Scegli un'opzione: ")

        if scelta == "1":
            register_user()
        elif scelta == "2":
            login_user()
        elif scelta == "3":
            print("Uscita dal programma.")
            break
        else:
            print("Opzione non valida.")

if __name__ == "__main__":
    main()