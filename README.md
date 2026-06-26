# Proiect_FPGA-Contor_Binar_cu_3_Butoane
Implementarea unui contor binar pe 16 biti, afisat pe 16 LED-uri, controlat prin 3 butoane.

Cerinta: Implementați pe placa de dezvoltare FPGA un contor binar pe 16 biți, afișat pe 16 LED-uri, controlat prin 3 butoane:
• Buton 1 — Incrementare: la fiecare apăsare, valoarea binară afișată pe LED-uri se incrementează cu 1.
• Buton 2 — Decrementare: la fiecare apăsare, valoarea binară afișată pe LED-uri se decrementează cu 1.
• Buton 3 — Reset: readuce valoarea contorului la 0 (toate LED-urile stinse).

Rezolvare: 
Am gandit inceperea proiectului prin definirea unei structuri generale pentru contorul binar pe 16 biti. Stabilesc ca semnale principale ale proiectului sa fie urmatoarele:
 - clk - clock-ul principal al placii, pentru sincronizarea sistemului
 - btn_inc - butonul folosit pentru incrementarea contorului
 - btn_dec - butonul folosit pentru decrementare
 - led[15:0] - iesirea (cele 16 led-uri)
 - count[15:0] - registrul intern care retine valoarea curenta a contorului (De vazut ECE 3300 31-33)
Am ales ca fiecare led sa reprezinte un bit al valorii curente a contorului, astfel incat led[0] va afisa LSB, iar led[15] va afisa MSB, folosind un bus atat pentru led, cat si pentru counter, fiind o varianta mai curata.
De asemenea, proiectul va fi sincronizat pe front-ul pozitiv al clock-ului, pentru ca modificarile contorului sa fie predictibile.
