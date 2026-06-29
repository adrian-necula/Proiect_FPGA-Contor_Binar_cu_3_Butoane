# Proiect_FPGA-Contor_Binar_cu_3_Butoane
Implementarea unui contor binar pe 16 biti, afisat pe 16 LED-uri, controlat prin 3 butoane.

## Cerinta: Implementați pe placa de dezvoltare FPGA un contor binar pe 16 biți, afișat pe 16 LED-uri, controlat prin 3 butoane:
 - Buton 1 — Incrementare: la fiecare apăsare, valoarea binară afișată pe LED-uri se incrementează cu 1.
 - Buton 2 — Decrementare: la fiecare apăsare, valoarea binară afișată pe LED-uri se decrementează cu 1.
 - Buton 3 — Reset: readuce valoarea contorului la 0 (toate LED-urile stinse).

## Rezolvare: 
Am gandit inceperea proiectului prin definirea unei structuri generale pentru contorul binar pe 16 biti. Stabilesc ca semnale principale ale proiectului sa fie urmatoarele:
 - clk - clock-ul principal al placii, pentru sincronizarea sistemului
 - btn_inc - butonul folosit pentru incrementarea contorului
 - btn_dec - butonul folosit pentru decrementare
 - btn_rst - butonul folosit pentru resetarea contorului
 - led[15:0] - iesirea (cele 16 led-uri)
 - count[15:0] - registrul intern care retine valoarea curenta a contorului (De vazut ECE 3300 31-33)
Am ales ca fiecare led sa reprezinte un bit al valorii curente a contorului, astfel incat led[0] va afisa LSB, iar led[15] va afisa MSB, folosind un bus atat pentru led, cat si pentru counter, fiind o varianta mai curata.
De asemenea, proiectul va fi sincronizat pe front-ul pozitiv al clock-ului, pentru ca modificarile contorului sa fie predictibile.

Am inceput implementarea cu modulul counter16b, deoarece logica de numarare este partea principala a proiectului. Modulul are intrarile clk, rst, inc, dec si iesirea count[15:0].

Comportamentul modulului este urmatorul:
 - contorul este sincronizat pe frontul pozitiv al clock-ului
 - daca rst este activ, valoarea revine la 0
 - daca este activ doar inc, valoarea creste cu 1
 - daca este activ doar dec, valoarea scade cu 1
 - daca inc și dec sunt active simultan, contorul nu isi modifica valoarea, deoarece comenzile sunt contradictorii

Pentru verificare am realizat un testbench simplu, in care am generat clock-ul si am testat resetarea, incrementarea, decrementarea si cazul inc + dec simultan. In waveform am urmarit semnalele clk, rst, inc, dec si count[15:0].
