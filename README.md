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


Am adaugat modulul button_sync, pe care il folosesc pentru a sincroniza semnalul venit de la buton cu clock-ul sistemului. Am ales sa fac pasul acesta separat deoarece butoanele sunt intrari externe fata de FPGA si nu este o idee buna sa fie folosite direct in logica principala.

Modulul foloseste doua registre succesive:
 - primul registru preia semnalul brut al butonului
 - al doilea registru ofera semnalul sincronizat, folosit mai departe in proiect

Pentru verificare am facut un testbench scurt, in care am urmarit clk, btn_in si btn_sync. In waveform se vede ca btn_sync urmareste btn_in cu o mica intarziere, lucru normal pentru acest tip de sincronizare.


Am adaugat modulul debouncer, folosit pentru filtrarea semnalului primit de la buton dupa sincronizare. Acest modul este necesar deoarece butoanele fizice pot produce oscilatii scurte la apasare sau eliberare, iar acestea ar putea fi interpretate gresit ca mai multe apasari.

Am gandit debouncer-ul astfel incat iesirea btn_stable sa nu se modifice imediat cand se schimba btn_in. Daca semnalul de intrare ramane diferit de iesirea stabila un anumit numar de cicluri de clock, atunci noua stare este acceptata.

Pentru verificare am realizat o simulare simpla, in care am introdus schimbari rapide pe btn_in, pentru a simula bouncing-ul. In waveform se observa ca btn_stable ignora oscilatiile scurte si se modifica doar dupa ce semnalul ramane stabil suficient timp.


Am adaugat modulul edge_detector, folosit pentru detectarea frontului pozitiv al semnalului de la buton. Modulul primeste semnalul deja stabilizat de la debouncer si genereaza un impuls de un singur ciclu de clock atunci cand butonul trece din starea 0 in starea 1.

Acest pas este necesar deoarece, daca butonul este tinut apasat, semnalul ramane pe 1 mai multe cicluri de clock, iar contorul ar putea incrementa sau decrementa continuu. Prin folosirea acestui modul, o apasare valida produce o singura comanda pentru contor.

Am realizat un testbench, in care am tinut semnalul signal_in pe 1 mai multe cicluri. In waveform se observa ca pulse_out devine 1 doar pentru un singur ciclu la aparitia frontului pozitiv.


Am adaugat modulul top, unde am legat modulele realizate pana acum pentru a obtine functionarea completa a contorului pe 16 biti. In acest modul, fiecare buton trece prin acelasi lant de prelucrare, astfel incat semnalul fizic sa fie sincronizat, filtrat si apoi transformat intr-un impuls de un singur ciclu.
- Am integrat modulele button_sync, debouncer, edge_detector si counter16b.
- Am folosit cate un lant separat pentru butoanele de incrementare, decrementare si reset.
- Semnalele rezultate, inc_pulse, dec_pulse si rst_pulse, sunt conectate la intrarile contorului.
- Iesirea count[15:0] este legata direct la led[15:0], pentru afisarea valorii contorului pe LED-uri.
  
Am realizat un testbench pentru top, in care am verificat functionarea lantului complet prin resetare, incrementare si decrementare. In simulare se observa ca apasarile butoanelor sunt transformate corect in comenzi pentru contor, iar valoarea afisata pe LED-uri se modifica in functie de operatia efectuata.


## Probleme intampinate si rezolvari:

Pe parcursul proiectului am intampinat cateva probleme legate de tratarea butoanelor si de integrarea modulelor in Vivado. Initial, am observat ca butoanele fizice nu pot fi folosite direct in contor, deoarece semnalele lor sunt externe fata de clock si pot avea bouncing. Pentru rezolvare, am impartit tratarea butoanelor in trei module: button_sync, debouncer si edge_detector.

O alta problema a aparut in simulari, unde unele semnale apareau cu valoarea X. Am rezolvat acest lucru prin initializarea semnalelor si prin verificarea conexiunilor dintre testbench si modulul testat. De exemplu, la button_sync a fost necesar sa conectez corect si semnalul clk.

La modulul debouncer, a trebuit sa folosesc o valoare mica pentru numarator in simulare, pentru ca rezultatul sa fie vizibil rapid, iar pentru implementarea pe placa valoarea trebuie sa fie mai mare, pentru a obtine o intarziere reala de ordinul milisecundelor.

La final, provocarea principala a fost integrarea modulelor in top si realizarea fisierului .xdc, unde numele porturilor trebuiau sa corespunda exact cu cele din modulul principal. Impartirea proiectului in module mici m-a ajutat sa testez fiecare parte separat si sa inteleg mai usor functionarea completa a contorului.


## Cerinta suplimentara: 
- Adăugați un afișaj cu 7 segmente (7-segment display) care să arate valoarea contorului în format zecimal.
- Asigurați-vă că afișajul cu 7 segmente este sincronizat corect cu valoarea binară afișată pe LED-uri (ambele trebuie să reprezinte aceeași valoare a contorului, în paralel).

## Rezolvare:

Pentru aceasta parte am incercat sa separ problema in pasi mai mici, ca sa fie mai usor de inteles si de testat. Valoarea count[15:0] este folosita in continuare pentru LED-uri, iar pentru 7 segmente este mai intai impartita in cifre zecimale.

M-am inspirat si din exemplele facute la laboratorul de CID, unde am lucrat cu module pentru numarare, multiplexare, transcodare si detector de anod. Am adaptat ideea pentru proiectul meu, deoarece aici contorul este pe 16 biti si poate ajunge pana la valoarea 65535, deci sunt necesare 5 cifre zecimale.

Pentru afisajul pe 7 segmente am folosit urmatoarele module: 
- binary_to_decimal - imparte valoarea contorului in 5 cifre zecimale;
- num - genereaza un semnal de refresh pentru multiplexarea afisajului;
- mux - alege cifra care trebuie afisata la un anumit moment;
- transcodor_7seg - transforma cifra selectata in semnalele pentru segmente;
- decodor_anod - selecteaza pozitia activa de pe display.

Astfel, afisajul cu 7 segmente foloseste aceeasi valoare interna a contorului ca LED-urile, doar ca o afiseaza in format zecimal.


Am inceput partea de afisare pe 7 segmente prin adaugarea modulului binary_to_decimal. Ideea este ca valoarea contorului sa ramana aceeasi, dar sa poata fi afisata si in format zecimal, nu doar binar pe LED-uri.
- Modulul imparte valoarea count[15:0] in 5 cifre zecimale.
- Cifrele rezultate vor fi folosite mai departe pentru afisarea valorii contorului in format zecimal.


Am adaugat modulele num, mux, transcodor_7seg si decodor_anod, folosite pentru controlul afisajului pe 7 segmente, cu ajutorul exemplelor lucrate la laboratorul de CID. 
Aceste module permit afisarea pe rand a cifrelor, suficient de rapid incat pe afisaj sa para ca sunt aprinse simultan.


In final, am integrat afisajul pe 7 segmente in modulul top, in paralel cu afisarea valorii pe LED-uri. Valoarea interna count[15:0] este folosita atat pentru LED-uri, cat si pentru display-ul cu 7 segmente, astfel incat ambele afisari sa reprezinte aceeasi valoare a contorului.
- Am conectat binary_to_decimal la valoarea count[15:0].
- Am legat cifrele rezultate la mux, pentru selectarea cifrei active.
- Am conectat transcodor_7seg pentru generarea semnalelor seg[7:0].
- Am conectat decodor_anod pentru selectarea pozitiei active prin an[7:0].
- Am actualizat fisierul .xdc pentru semnalele afisajului pe 7 segmente.


## Probleme intampinate si rezolvari pentru afisajul pe 7 segmente:

La partea de afisare pe 7 segmente, prima problema a fost sa inteleg cum pot afisa valoarea contorului in format zecimal. Contorul este pe 16 biti, deci poate ajunge pana la 2^16 = 65535, iar varianta de a face manual toate combinatiile pentru segmente nu ar fi fost potrivita. Din acest motiv, am folosit modulul binary_to_decimal, care imparte valoarea contorului in 5 cifre zecimale.

O alta parte pe care a trebuit sa o inteleg a fost multiplexarea afisajului. Practic, display-ul nu afiseaza toate cifrele in acelasi timp, ci le activeaza foarte rapid pe rand. Pentru asta am folosit modulul num, care genereaza selectia, modulul mux, care alege cifra curenta, si modulul decodor_anod, care selecteaza pozitia activa de pe afisas.

Am fost atent si la ordinea bitilor pentru seg[7:0], deoarece in varianta mea am inclus si punctul zecimal in acelasi bus. De aceea a trebuit sa adaptez fisierul de constrangeri .xdc, astfel incat legaturile dintre semnalele din cod si pinii fizici ai placii sa fie corecte.

In final, partea de 7 segmente foloseste aceeasi valoare count[15:0] ca si LED-urile. Astfel, contorul este afisat in paralel in doua moduri: binar pe LED-uri si zecimal pe afisajul cu 7 segmente.
