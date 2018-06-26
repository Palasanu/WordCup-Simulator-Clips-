(deftemplate jucator 
    (slot nume)
    (slot pozitie)
    (slot goluri (type INTEGER)(default 0))
)

(deftemplate echipa
	(slot nume)
	(multislot jucatori)
	(slot calificat(type INTEGER))
	(slot goluri (type INTEGER)(default 0))
	(slot check (default 0))
	(slot statistici (default 0))
)

(deftemplate grupa
	(slot litera)
	(multislot echipe)
)

(deftemplate meci
	(slot echipaA)
	(slot scorA (type INTEGER))
	(slot scorB (type INTEGER))
	(slot echipaB)
	(multislot data)
	(slot stadion)
)

(deffacts echipe
	(echipa (nume Brazilia) (jucatori Alisson Cassio Ederson DaniAlves Miranda Jemerson AlexSandro Marquinhos RodrigoCaio Jorge Danilo Casemiro RenatoAugusto PhilippeCoutinho Paulinho Fernandinho Fred Willian Arthur DiegoTardelli GabrielJesus Neymar RobertoFirmino))
	(echipa (nume Mexic)(jucatori Messi))
	(echipa (nume Croatia))
	(echipa (nume Camerun))
	(echipa (nume Olanda))
	(echipa (nume Spania))
	(echipa (nume Chile))
	(echipa (nume Australia))
	(echipa (nume Columbia))
	(echipa (nume Grecia))
	(echipa (nume CoastadeFildes))
	(echipa (nume Japonia))
	(echipa (nume CostaRica))
	(echipa (nume Uruguay))
	(echipa (nume Italia))
	(echipa (nume Anglia))
)

(deffacts grupe
	(grupa (litera A) (echipe Brazilia Mexic Croatia Camerun))
	(grupa (litera B) (echipe Olanda Spania Chile Australia))
	(grupa (litera C) (echipe Columbia Grecia CoastadeFildes Japonia))
	(grupa (litera D) (echipe CostaRica Uruguay Italia Anglia))
)

(deffacts jucatori
	(jucator (nume Neymar)(pozitie A)(goluri 4))
	(jucator (nume GabrielJesus)(pozitie A)(goluri 2))
	(jucator (nume Messi)(pozitie A)(goluri 4))
)
(deffacts meciuri
	(meci (echipaA Brazilia)(scorA 3)(scorB 1)(echipaB Croatia)(data 12 iunie)(stadion ArenadeSaoPaulo))
	(meci (echipaA Mexic)(scorA 1)(scorB 0)(echipaB Camerun)(data 13 iunie)(stadion ArenadasDunas))
	(meci (echipaA Brazilia)(scorA 0)(scorB 0)(echipaB Mexic)(data 17 iunie)(stadion EstadioCastelao))
	(meci (echipaA Camerun)(scorA 0)(scorB 4)(echipaB Croatia)(data 18 iunie)(stadion ArenadaAmazonia))
	(meci (echipaA Camerun)(scorA 1)(scorB 4)(echipaB Brazilia)(data 13 iunie)(stadion EstadioNacionalManeGarrincha))
	(meci (echipaA Croatia)(scorA 1)(scorB 3)(echipaB Mexic)(data 13 iunie)(stadion ArenaPernambuco))

	(meci (echipaA Spania)(scorA 1)(scorB 5)(echipaB Olanda)(data 13 iunie)(stadion ArenaFonteNova))
	(meci (echipaA Chile)(scorA 3)(scorB 1)(echipaB Australia)(data 13 iunie)(stadion ArenaPantanal))
	(meci (echipaA Australia)(scorA 2)(scorB 3)(echipaB Olanda)(data 18 iunie)(stadion EstadioBeira-Rio))
	(meci (echipaA Spania)(scorA 0)(scorB 2)(echipaB Chile)(data 18 iunie)(stadion EstadiodoMaracana))
	(meci (echipaA Australia)(scorA 0)(scorB 3)(echipaB Spania)(data 23 iunie)(stadion ArenadaBaixada))
	(meci (echipaA Olanda)(scorA 2)(scorB 0)(echipaB Chile)(data 23 iunie)(stadion ArenaFonteNova))

	(meci (echipaA Columbia)(scorA 3)(scorB 0)(echipaB Grecia)(data 14 iunie)(stadion ArenaFonteNova))
	(meci (echipaA CoastadeFildes)(scorA 2)(scorB 1)(echipaB Japonia)(data 14 iunie)(stadion ArenaFonteNova))
	(meci (echipaA Columbia)(scorA 2)(scorB 1)(echipaB CoastadeFildes)(data 19 iunie)(stadion ArenaFonteNova))
	(meci (echipaA Japonia)(scorA 0)(scorB 0)(echipaB Grecia)(data 19 iunie)(stadion ArenaFonteNova))
	(meci (echipaA Japonia)(scorA 1)(scorB 4)(echipaB Columbia)(data 24 iunie)(stadion ArenaFonteNova))
	(meci (echipaA Grecia)(scorA 2)(scorB 1)(echipaB CoastadeFildes)(data 24 iunie)(stadion ArenaFonteNova))

	(meci (echipaA Uruguay)(scorA 1)(scorB 3)(echipaB CostaRica)(data 14 iunie)(stadion EstadioMineirao))
	(meci (echipaA Anglia)(scorA 1)(scorB 2)(echipaB Italia)(data 14 iunie)(stadion ArenaPernambuco))
	(meci (echipaA Uruguay)(scorA 2)(scorB 1)(echipaB Anglia)(data 19 iunie)(stadion EstadioNacional))
	(meci (echipaA Italia)(scorA 0)(scorB 1)(echipaB CostaRica)(data 20 iunie)(stadion ArenadasDunas))
	(meci (echipaA Italia)(scorA 0)(scorB 1)(echipaB Uruguay)(data 24 iunie)(stadion ArenaPantanal))
	(meci (echipaA CostaRica)(scorA 0)(scorB 0)(echipaB Anglia)(data 24 iunie)(stadion EstadioCastelao))

	(optiune 9)
	(etapa 1)
)


(defrule initializareSfarsitulCalificarilor
	(meci (echipaA ?echipaA) (echipaB ?echipaB)(scorA ?A)(scorB ?B) (data $?x))
	(not (sfarsit_calificari $?))
	=>
	(assert (sfarsit_calificari $?x ?echipaA ?A -  ?B ?echipaB))
)
(defrule sfarsitulCalificarilor
	(meci (echipaA ?echipaA) (echipaB ?echipaB)(scorA ?A)(scorB ?B) (data ?x ?y))
	?id <- (sfarsit_calificari ?m ?n $?info)
	(test (> ?x ?m))
	=>
	(retract ?id)
	(assert (sfarsit_calificari ?x ?y ?echipaA ?A -  ?B ?echipaB))
)


(defrule introducere
	(not (introducere $?))
	(optiune ?)
	=>
	(printout t "Meciurle grupelor au fost introduse" crlf crlf)
	(assert (introducere fals))
)


(defrule castigatoarea
	?et <- (etapa ?e)
	(test(> ?e 3))
	(echipa (calificat ?e) (nume ?n))
	=>
	(printout t crlf crlf"CAMPIONATUL A FOST CASTIGAT DE " ?n " !!!" crlf crlf)

)

(defrule meniu
	(etapa ?e)
    (not (optiune $?))
    =>
    (if (< ?e 4) then
    (printout t crlf "Litere pentru comenzi:" crlf)
    (printout t "  a. Introdu meciurile echipelor calificate in  " )
    (if (= ?e 1) then (printout t "optimi" crlf))
    (if (= ?e 2) then (printout t "patrimi" crlf))
    (if (= ?e 3) then (printout t "finala" crlf))
    (printout t "  b. Simuleaza urmatoare etapa in functie de meciurile jucate. " crlf)
	)
    (printout t crlf "Alege statistici:" crlf)
    (printout t "1. Care e primul meci al campionatului?" crlf)
    (printout t "2. Care e ultimul meci al grupelor?" crlf)
    (printout t "3. In ce grupa se afla un jucator?" crlf)
    (printout t "4. Ce jucatori sunt pe o pozitie?(A-atacant,M-mijlocas,F-fundas,P-portar)" crlf)
    (printout t "5. Cate puncte are echipa?" crlf)
    (printout t "6. Cate goluri are echipa?" crlf)
    (printout t "7. Cate meciuri s-au jucat pe stadion?" crlf)
    (printout t "8. Care este clasamentul grupei?" crlf)
    (printout t "9. Ce echipe s-au calificat?" crlf)
    (printout t "10. Care sunt jucatorii cu cele mai multe goluri?" crlf)
    (printout t "11. Care sunt cele mai multe goluri date de un jucator?" crlf)
    (printout t "12. Care sunt cele mai multe goluri date intr-un meci?" crlf)
    (printout t "13. Care este meciul cu cele mai multe goluri?" crlf)
    (printout t "14. Care este nr total de goluri?" crlf)
    (printout t "15. Lista goluri date de echipe din grupa?" crlf)

    (printout t crlf "Pentru a inchide programul scrieti: exit" crlf)

    (assert (optiune (read)))
)


;(defrule goluriEchipa
;    ?id <- (echipa (nume ?n) (jucatori $?x ?y $?z)(goluri ?ge))
;    (jucator (nume ?y) (goluri ?gj))
;    =>
;   (modify ?id (goluri (+ ?gj ?ge)))
;)


(defrule primaData
	(sfarsit_calificari $?x)
	(optiune 1)
	(not (data $?))
	=>
	(assert (data $?x))
)


(defrule primulMeci
	?op <-(optiune 1)
	(meci (echipaA ?echipaA) (echipaB ?echipaB)(scorA ?A)(scorB ?B) (data ?x ?y))
	?id <- (data ?m ?n $?info)
	(test (< ?x ?m))
	=>
	(retract ?id)
	(assert (data ?x ?y ?echipaA ?A -  ?B ?echipaB))
)

(defrule afiseazaPrimulMeci
	?op <-(optiune 1)
	?id <- (data $?x)
	=>
	(printout t $?x crlf)
	(retract ?id)
	(retract ?op)
)


; Afiseaza Ultimul meci al campionatului
(defrule ultimulMeci
	?op <-(optiune 2)
	(sfarsit_calificari $?x)
	=>
	(printout t $?x crlf)
	(retract ?op)
)



;Afiseaza in ce grupa e jucatorul
(defrule numeJucator
	?op <-(optiune 3)
	=>
	(printout t "Introdu nume jucator: ")
    (bind ?a (read))
    (assert (numejucator ?a))
)

(defrule verificaJucator
	?op <-(optiune 3)
	?n <- (numejucator ?nume)
	(not(jucator (nume ?nume)))
	=>
	(printout t "Jucatorul " ?nume " nu exista" crlf)
)

(defrule grupaJucator
	?op <-(optiune 3)
	?n <- (numejucator ?nume)
	(jucator (nume ?nume))
	(echipa (nume ?x) (jucatori $? ?nume $?))
	(grupa (litera ?l) (echipe $? ?x $?))
	=>
	(printout t "Jucatorul " ?nume " este in grupa" ?l crlf)
	(retract ?op)
	(retract ?n)
)

;Care sunt jucatorii de pe o pozitie?
(defrule numePozitie
	?op <-(optiune 4)
	=>
	(printout t "Introdu litera ce indica pozitia cautata: ")
    (bind ?a (read))
    (assert (pozitie ?a))
    (printout t "Jucatorii pe pozitia " ?a " sunt:" )
)

(defrule numeJucatoriPozitie
	?op <-(optiune 4)
	?p <- (pozitie ?x)
	(jucator (nume ?n)(pozitie ?x))
	=>
	(printout t ?n " ")
)

(defrule afiseazaJucaoriiLigii
	?op <-(optiune 4)
	?p <- (pozitie ?x)
	=>
	(retract ?op)
	(retract ?p)
	(printout t crlf)
)

;Puncte echipa

(defrule numeEchipa
	?op <-(optiune 5)
	=>
	(printout t "Introdu echipa cautata: ")
    (bind ?a (read))
    (assert (numeechipa ?a))
)
(defrule calculeazaPuncte
	?op <-(optiune 5)
	?id <- (numeechipa ?nume)
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?m meci)) (or (and (= (str-compare ?m:echipaA ?nume) 0) (> ?m:scorA ?m:scorB)) (and (= (str-compare ?m:echipaB ?nume) 0) (> ?m:scorB ?m:scorA))) (bind ?sum (+ ?sum 3)) )
	(do-for-all-facts ((?m meci)) (and (= (str-compare ?m:echipaA ?nume) 0) (= ?m:scorA ?m:scorB)) (bind ?sum (+ ?sum 1)) )
	(printout t "Echipa " ?nume " are " ?sum " puncte" crlf)
	(retract ?op)
	(retract ?id)
)

;Goluri echipa
(defrule numeEchipaGoluri
	?op <-(optiune 6)
	=>
	(printout t "Introdu echipa cautata: ")
    (bind ?a (read))
    (assert (numeechipa ?a))
)
(defrule calculeazaGoluriEchipa
	?op <-(optiune 6)
	?id <- (numeechipa ?nume)
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaA ?nume) 0) (bind ?sum (+ ?sum ?m:scorA)) )
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaB ?nume) 0) (bind ?sum (+ ?sum ?m:scorB)) )
	(printout t "Echipa " ?nume " are " ?sum " goluri" crlf)
	(retract ?op)
	(retract ?id)
)

;Cate meciuri pe stadion
(defrule numeStadionMEciuri
	?op <-(optiune 7)
	=>
	(printout t "Introdu stadion cautat: ")
    (bind ?a (read))
    (assert (numestadion ?a))
)
(defrule calculeazaMeciuriStadion
	?op <-(optiune 7)
	?id <- (numestadion ?nume)
	=>
	(bind ?count 0)
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:stadion ?nume) 0) (bind ?count (+ ?count 1)))
	(printout t "numarul de meciur care s-a jucat pe stadionul " ?nume " este" ?count "." crlf)
	(retract ?op)
	(retract ?id)
)

;Clasamentul
(defrule numeGrupaPunctaje
	?op <-(optiune 8)
	=>
	(printout t "Introdu litera grupa cautata: ")
    (bind ?a (read))
    (assert (literagrupa ?a))
)

(defrule calculeazaEchipaPuncte
	?op <-(optiune 8)
	?id <-(literagrupa ?a)
	(grupa (litera ?a) (echipe $? ?nume $?))
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?m meci)) (or (and (= (str-compare ?m:echipaA ?nume) 0) (> ?m:scorA ?m:scorB)) (and (= (str-compare ?m:echipaB ?nume) 0) (> ?m:scorB ?m:scorA))) (bind ?sum (+ ?sum 3)) )
	(do-for-all-facts ((?m meci)) (and (= (str-compare ?m:echipaA ?nume) 0) (= ?m:scorA ?m:scorB)) (bind ?sum (+ ?sum 1)) )
	(assert (puncteEchipa ?nume ?sum))
	(printout t ?nume " are " ?sum " puncte" crlf)
)
(defrule curataCalculeazaEchipaPuncte
	?op <-(optiune 8)
	?id <-(literagrupa ?a)
	=>
	(retract ?op)
	(retract ?id)
)

;Echipa din fruntea grupei

(defrule numeGrupePunctajeD
	?op <-(optiune 9)
	?id <-(literagrupa D)
	=>
	(do-for-all-facts ((?m puncteEchipa)) (= 1 1) (retract ?m))
	(retract ?op)
	(retract ?id)

)

(defrule numeGrupePunctajeC
	?op <-(optiune 9)
	?id <-(literagrupa C)
	=>
	(retract ?id)
	(do-for-all-facts ((?m puncteEchipa)) (= 1 1) (retract ?m))
    (assert (literagrupa D))
)

(defrule numeGrupePunctajeB
	?op <-(optiune 9)
	?id <-(literagrupa B)
	=>
	(retract ?id)
	(do-for-all-facts ((?m puncteEchipa)) (= 1 1) (retract ?m))
    (assert (literagrupa C))
)

(defrule numeGrupePunctajeA
	?op <-(optiune 9)
	?id <-(literagrupa A)
	=>
	(retract ?id)
	(do-for-all-facts ((?m puncteEchipa)) (= 1 1) (retract ?m))
    (assert (literagrupa B))
)

(defrule numeGrupePunctaje
	?op <-(optiune 9)
	=>
    (assert (literagrupa A))
    (printout t "Echipele calificate sunt: " crlf )
)


(defrule calculeazaEchipaPunctei
	?op <-(optiune 9)
	?id <-(literagrupa ?a)
	(grupa (litera ?a) (echipe $? ?nume $?))
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?m meci)) (or (and (= (str-compare ?m:echipaA ?nume) 0) (> ?m:scorA ?m:scorB)) (and (= (str-compare ?m:echipaB ?nume) 0) (> ?m:scorB ?m:scorA))) (bind ?sum (+ ?sum 3)) )
	(do-for-all-facts ((?m meci)) (and (or (= (str-compare ?m:echipaA ?nume) 0) (= (str-compare ?m:echipaB ?nume) 0)) (= ?m:scorA ?m:scorB)) (bind ?sum (+ ?sum 1)) )
	(assert (puncteEchipa ?nume ?sum))
)
(defrule initializareLocuri
	(optiune 9)
	(literagrupa ?a)
	=>
	(assert (first nume 1))
	(assert (second nume 0))
)
(defrule cautaEchipele
	(optiune 9)
	(literagrupa ?a)
	?f <- (first ?fn ?fs)
	?s <- (second ?sn ?ss)
	?id <- (puncteEchipa ?nume ?scor)
	=>
	(if (> ?scor ?fs) then
		(retract ?f)
		(assert (first ?nume ?scor))
	)
	(if (and (> ?scor ?ss) (< ?scor ?fs)) then
		(retract ?s)
		(assert (second ?nume ?scor))
	)
)
(defrule afiseazaEchipeCalificate
	?op <- (optiune 9)
	?id <-(literagrupa ?a)
	?f <- (first ?fn ?fs)
	?s <- (second ?sn ?ss)
	?e1 <- (echipa (nume ?fn))
	?e2 <- (echipa (nume ?sn))

	=>
	(printout t "    " ?fn " si ")
	(printout t ?sn  crlf)
	(modify ?e1 (calificat 1))
	(modify ?e2 (calificat 1))
	(retract ?f)
	(retract ?s)
)

;Jucatorii cu cele mai multe goluri
(defrule maximGoluri
	?op <- (optiune 10)
	=>
	(bind ?max 0)
	(do-for-all-facts ((?j jucator)) (> ?j:goluri ?max) (bind ?max ?j:goluri))
	(assert(maxim ?max))
	(printout t "Jucatorii cu cele mai multe goluri: "  crlf)
)
(defrule afiseazaJucatoriGoluriMax
	?m <- (maxim ?max)
	?op <- (optiune 10)
	(jucator (nume ?n) (goluri ?max))
	=>
	(printout t ?n crlf)
)
(defrule curataJucatoriGoluriMax
	?m <- (maxim ?max)
	?op <- (optiune 10)
	=>
	(retract ?op)
	(retract ?m)

)

;Maximul de goluri
(defrule maximGoluriJ
	?op <- (optiune 11)
	=>
	(bind ?max 0)
	(do-for-all-facts ((?j jucator)) (> ?j:goluri ?max) (bind ?max ?j:goluri))
	(printout t "Cele mai multe goluri date de un jucator sunt " ?max  crlf)
	(retract ?op)
)

;Maxim de goluri pe un stadion
(defrule maximGoluriMeci
	?op <- (optiune 12)
	=>
	(bind ?max 0)
	(do-for-all-facts ((?j meci)) (> (+ ?j:scorA ?j:scorB) ?max) (bind ?max (+ ?j:scorA ?j:scorB)))
	(printout t "Cele mai multe goluri date pe un stadion intr-un meci sunt " ?max  crlf)
	(retract ?op)
)

;Meciurile cu cele mai multe goluri
(defrule maximGoluriMecia
	?op <- (optiune 13)
	=>
	(bind ?max 0)
	(do-for-all-facts ((?j meci)) (> (+ ?j:scorA ?j:scorB) ?max) (bind ?max (+ ?j:scorA ?j:scorB)))
	(assert(maxim ?max))
	(printout t "Meciurile cu cele mai multe golurisunt: "  crlf)
)
(defrule calcmaximGoluriMeci
	?op <- (optiune 13)
	?m <- (maxim ?max)
	(meci (echipaA ?echipaA) (echipaB ?echipaB)(scorA ?A)(scorB ?B) (data $?x))
	(test (= (+ ?A ?B) ?max))
	=>
	(printout t ?echipaA " " ?A "-" ?B " " ?echipaB crlf)
)
(defrule curatacalcmaximGoluriMeci
	?op <- (optiune 13)
	?m <- (maxim ?max)
	=>
	(retract ?op)
	(retract ?m)
)

;Nr maxim de goluri
(defrule maximGoluriCampionat
	?op <- (optiune 14)
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?j meci)) TRUE (bind ?sum (+ ?sum ?j:scorA ?j:scorB)))
	(printout t "Nr total de goluri in campionat este " ?sum  crlf)
	(retract ?op)
)


(defrule numeGrupaGoluri
	?op <-(optiune 15)
	=>
	(printout t "Introdu grupa cautata: ")
    (bind ?a (read))
    (assert (numegrupa ?a))
)
(defrule calculeazaGoluriEchipelor
	?op <-(optiune 15)
	?id <- (numegrupa ?n)
	(grupa (litera ?n) (echipe $? ?nume $?))
	=>
	(bind ?sum 0)
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaA ?nume) 0) (bind ?sum (+ ?sum ?m:scorA)) )
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaB ?nume) 0) (bind ?sum (+ ?sum ?m:scorB)) )
	(printout t "Echipa " ?nume " are " ?sum " goluri" crlf)
)
(defrule curataCalculeazaGoluriEchipelor
	?op <-(optiune 15)
	?id <- (numegrupa ?n)
	=>
	(retract ?op)
	(retract ?id)
)


;Comanda care adauga meciuri
(defrule ordineB
	(declare (salience -10)) 
	?op <-(optiune a)
	?o <- (ordine 1)
	=>
	(retract ?o)
	(assert (ordine 2))
)

(defrule ordineA
	?op <-(optiune a)
	(not (ordine ?))
	=>
	(assert (ordine 1))
)

(defrule adaugaMeciuri
	(ordine 1)
	?op <-(optiune a)
	(etapa ?e)
	?e1 <- (echipa (calificat ?e) (check 0) (nume ?n1))
	?e2 <- (echipa (calificat ?e) (check 0) (nume ?n2))
	(test(or (= (str-compare ?n1 ?n2) 1) (= (str-compare ?n1 ?n2) -1)))
	=>
	(printout t "Introdu scorul meciului: " ?n1 " - " ?n2 crlf)
	(bind ?s1 0)
	(bind ?s2 0)
	(while (= ?s1 ?s2)
		(printout t ?n1 ": ") 
		(bind ?s1 (read))
		(printout t ?n2 ": ") 
		(bind ?s2 (read))
		(if (= ?s1 ?s2) then 
		(printout t  crlf "Egalitate se mai joaca o data partida" crlf)
		)
	)
	(assert (meci (echipaA ?n1) (echipaB ?n2) (scorA ?s1) (scorB ?s2) (data 28 iunie) ))

	(if (> ?s1 ?s2) then
		(modify ?e1 (calificat (+ ?e 1)) (check 1))
		(modify ?e2 (check 1))
	)
	(if (> ?s2 ?s1) then
		(modify ?e2 (calificat (+ ?e 1)) (check 1))
		(modify ?e1 (check 1))
	)
)

(defrule decheckEchipe
	(ordine 2)
	?op <-(optiune a)
	?e1 <- (echipa (calificat ?) (check 1) (nume ?n))
	=>
	(bind ?goluri 0)
	(bind ?meciuri 0)
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaA ?n) 0) (bind ?goluri (+ ?goluri ?m:scorA)) (bind ?meciuri (+ ?meciuri 1)) )
	(modify ?e1 (check 0) (statistici (/ ?goluri ?meciuri) ) )
)
(defrule urmatoareaEtapa
	?et <- (etapa ?e)
	?op <- (optiune a)
	?o <- (ordine 2)
	=>
	(retract ?op)
	(retract ?et)
	(retract ?o)
	(assert (etapa (+ ?e 1)))
)

;Comanda care simuleaza meciurile

(defrule simordineB
	(declare (salience -20)) 
	?op <-(optiune b)
	?o <- (ordine 1)
	=>
	(retract ?o)
	(assert (ordine 2))
)

(defrule simordineA
	?op <-(optiune b)
	(not (ordine ?))
	=>
	(assert (ordine 1))
)

(defrule simuleazaEtapa
	?op <-(optiune b)
	(ordine 1)
	(etapa ?e)
	?e1 <- (echipa (calificat ?e) (check 0) (nume ?n1) (statistici ?st1))
	?e2 <- (echipa (calificat ?e) (check 0) (nume ?n2) (statistici ?st2)) 
	(test(or (= (str-compare ?n1 ?n2) 1) (= (str-compare ?n1 ?n2) -1)))
	=>
	(bind ?s1 0)
	(bind ?s2 0)
	(while (= ?s1 ?s2)
		(bind ?s1 (+ (mod (random) 2) (round ?st1)))
		(bind ?s2 (+ (mod (random) 2) (round ?st2)))
	)

	(assert (meci (echipaA ?n1) (echipaB ?n2) (scorA ?s1) (scorB ?s2) (data 28 iunie) ))
	(printout t ?n1 " " ?s1 " - " ?s2 " " ?n2 crlf) 

	(if (> ?s1 ?s2) then
		(modify ?e1 (calificat (+ ?e 1)) (check 1))
		(modify ?e2 (check 1))
	)
	(if (> ?s2 ?s1) then
		(modify ?e2 (calificat (+ ?e 1)) (check 1))
		(modify ?e1 (check 1))
	)
)

(defrule simdecheckEchipe
	(ordine 2)
	?op <-(optiune b)
	?e1 <- (echipa (calificat ?) (check 1) (nume ?n))
	=>
	(bind ?goluri 0)
	(bind ?meciuri 0)
	(do-for-all-facts ((?m meci)) (= (str-compare ?m:echipaA ?n) 0) (bind ?goluri (+ ?goluri ?m:scorA)) (bind ?meciuri (+ ?meciuri 1)) )
	(modify ?e1 (check 0) (statistici (/ ?goluri ?meciuri) ) )
)
(defrule simurmatoareaEtapa
	?et <- (etapa ?e)
	?op <- (optiune b)
	?o <- (ordine 2)
	=>
	(retract ?op)
	(retract ?et)
	(retract ?o)
	(assert (etapa (+ ?e 1)))
)

(defrule exit
    ?ex <- (optiune exit)
    =>
    (retract ?ex)
    (exit)
)