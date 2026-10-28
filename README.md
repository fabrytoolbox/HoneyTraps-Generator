# ⚠️ AVVERTENZA LEGALE E DI SICUREZZA

**QUESTO TOOL È DESTINATO ESCLUSIVAMENTE A RICERCATORI DI SICUREZZA E ANALISTI DI MALWARE.**

Genera file esca (honeypot) contenenti dati fittizi (wallet, password, documenti bancari) progettati per attirare malware come infostealer e RAT.

**REGOLE TASSATIVE:**
1. Usalo SOLO su macchine virtuali isolate (sandbox).
2. NON eseguirlo su PC di produzione o con dati reali.
3. Sei l'unico responsabile dell'uso improprio di questo software.
4. L'autore non si assume alcuna responsabilità per danni, perdite di dati o conseguenze legali derivanti dall'uso di questo tool.

Usalo solo se sai esattamente cosa stai facendo. Se non sei un professionista della sicurezza, chiudi questa pagina.

---

# 👻 HoneyTraps Generator

Genera file esca (honeypot) per attirare e studiare infostealer, RAT e malware.

## ✨ Cosa fa

Crea file fittizi in `Documents\Dati Segreti` (e in `Downloads`) con contenuti che i malware cercano:
- **Wallet Crypto**: seed phrase e saldo fittizio
- **Password**: credenziali di Google, Facebook, PayPal, Amazon, ecc.
- **Dati Bancari**: IBAN, PIN, codice fiscale
- **Chiavi PGP**: chiave privata fittizia
- **Ricatti**: log di ricatto fittizio
- **Transazioni Illegali**: bonifici offshore fittizi
- **MetaMask**: seed phrase per wallet Ethereum

## 🎯 A cosa serve

Se un malware infetta la macchina, invece di rubare i dati veri, ruba quelli finti. In questo modo:
- Puoi **loggare** il traffico (IP, timestamp) e capire chi sta rubando i dati.
- Puoi **studiare** il comportamento del malware in un ambiente controllato.
- Puoi **tracciare** l'infrastruttura del criminale (se usi uno sniffer come Wireshark).

## 📋 Requisiti

- **Windows 10 / 11**
- **PowerShell 7+** (scarica da https://aka.ms/powershell)
- **Macchina virtuale isolata (sandbox)** — obbligatorio

## 🚀 Quick start

```powershell
git clone https://github.com/fabrytoolbox/HoneyTraps-Generator.git
cd HoneyTraps-Generator
Unblock-File .\HoneyTraps-Generator.ps1
.\HoneyTraps-Generator.ps1

🛡️ Come funziona

1.	Lancia lo script (apparirà un disclaimer, devi accettarlo).

2.	Scegli quale esca creare (o "Genera tutte").

3.	I file vengono creati nelle cartelle Documents\Dati Segreti e Downloads della VM.

4.	Se un malware infetta la VM, ruberà questi dati fittizi.

5.	Usa uno sniffer (Wireshark) per monitorare il traffico e capire dove vanno i dati.

📜 Licenza
MIT (vedi LICENSE).

🙏 Crediti
Fabry Toolbox
PowerShell 7 + WinForms

Tema Matrix