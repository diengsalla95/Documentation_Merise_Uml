#------------------------------------------------------------------------------------------------------------
# 1.	Donnez le numéro, le nom de tous les médecins ayant la spécialité S1
SELECT id_med, nom_med
FROM `medecin`
WHERE specialite = "S1"
LIMIT 0 , 30

#-------------------------------------------------------------------------------------------------------------
# 2.	Donnez les différentes spécialités.
SELECT DISTINCT specialite
FROM medecin

#--------------------------------------------------------------------------------------------------------------
# 3.	Donnez le numéro, le nom et la date de naissance de tous les malades de sexe
#masculin par ordre croissant de l’âge
SELECT id_pat, Nom_pat, date_naiss
FROM `patient`
WHERE sexe = "M"
ORDER BY date_naiss DESC

#-------------------------------------------------------------------------------------------------------------
# 4.	Donnez le numéro, le nom et la date de naissance de tous les malades de sexe
#féminin dont l’adresse contient « p » par ordre croissant du nom.

SELECT id_pat, Nom_pat, date_naiss
FROM `patient`
WHERE sexe = "F"
AND adr LIKE '%p%'
ORDER BY Nom_pat ASC

#---------------------------------------------------------------------------------------------------------------
#5.	Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro, la catégorie 
# et le type de la chambre occupé par chaque malade.
SELECT patient.id_pat, patient.Nom_pat, patient.date_naiss, chambre.id_ch, chambre.categorie,chambre.type_ch
FROM patient,chambre,occuper,lit
WHERE patient.id_pat=occuper.id_pat
AND occuper.id_lit=lit.id_lit
AND lit.id_ch = chambre.id_ch

#---------------------------------------------------------------------------------------------------------------
#6.	Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro et 
#le des départements où le malade né le 22-4-2012 ont été internés. 
SELECT DISTINCT patient.id_pat, patient.Nom_pat, patient.date_naiss, departement.id_dep, departement.Nom_dep
FROM patient, departement, interner
WHERE patient.id_pat = interner.id_pat
AND departement.id_dep=interner.id_dep
AND patient.date_naiss = "2012-04-22"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#7.	Donnez le numéro, le nom et la date de naissance de tous les malades suivis par le médecin M3
SELECT DISTINCT patient.id_pat, patient.Nom_pat, patient.date_naiss
FROM patient, medecin, suivre
WHERE medecin.id_med=suivre.id_med
AND patient.id_pat=suivre.id_pat
AND medecin.Nom_med="M3"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#8.	Donnez le numéro, le nom et la date de naissance de tous les malades suivis par le médecin M3 et qui ont occupé le lit numéro 21.
SELECT DISTINCT patient.id_pat, patient.Nom_pat, patient.date_naiss
FROM patient, lit, occuper,suivre,medecin
WHERE patient.id_pat = occuper.id_pat
AND lit.id_lit = occuper.id_lit
AND suivre.id_med=medecin.id_med
AND suivre.id_pat=patient.id_pat
AND medecin.Nom_med="M3"
AND lit.id_lit=21
LIMIT 0 , 30


#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#9.	Donnez le numéro, le nom et la date de naissance de tous les malades qui ont occupé le lit numéro 21.

SELECT DISTINCT patient.id_pat, patient.Nom_pat, patient.date_naiss
FROM patient, lit, occuper
WHERE patient.id_pat = occuper.id_pat
AND lit.id_lit = occuper.id_lit
AND lit.id_lit=21
LIMIT 0 , 30


#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#10.Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro et la date pour le suivit de l’évolution du malade numéro 11.

SELECT patient.id_pat, patient.Nom_pat, patient.date_naiss,feuille.numFeu,feuille.dateF
FROM patient,feuille
WHERE patient.id_pat = feuille.id_pat
AND patient.Nom_pat ="Malade11"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
#11.	Donnez le nombre de malades internés dans chaque département.

SELECT COUNT( interner.id_dep ) AS nombre, Nom_dep
FROM interner, departement
WHERE interner.id_dep = departement.id_dep
GROUP BY Nom_dep

##------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 12 Donnez le numéro, le nom, l’adresse du malade ainsi que le nom du médecin de tous les malades suivis par un médecin du département D2.

SELECT patient.id_pat, patient.Nom_pat, patient.adr, medecin.Nom_med
FROM patient, medecin, departement, suivre
WHERE suivre.id_med = medecin.id_med
AND patient.id_pat = suivre.id_pat
AND medecin.id_dep = departement.id_dep
AND departement.Nom_dep ="M2"

#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# 13 Donnez le numéro, le nom, l’adresse de tous les malades qui ont été internés au mois de février ou au mois de décembre.

SELECT DISTINCT patient.id_pat, patient.Nom_pat, patient.adr
FROM patient, interner,feuille
WHERE patient.id_pat = interner.id_pat
AND patient.id_pat=feuille.id_pat
AND (MONTH( feuille.DateF ) =12 OR MONTH( feuille.DateF ) =02)

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# 14  Donnez toutes les informations de la chambre ayant accueilli le plus de malade.

SELECT COUNT( chambre.id_ch ) AS nombre, chambre.id_ch, chambre.categorie, chambre.type_ch,chambre.id_dep
FROM lit, chambre, patient, occuper
WHERE lit.id_ch = chambre.id_ch
AND occuper.id_pat = patient.id_pat
AND occuper.id_lit = lit.id_lit
GROUP BY chambre.id_ch
ORDER BY nombre DESC
LIMIT 1

#
#15.Donnez toutes les informations du département ayant accueilli le plus de malade.

SELECT departement.id_dep,departement.Nom_dep, COUNT(patient.Nom_pat) AS NOMBRE 
FROM departement JOIN interner on interner.id_dep=departement.id_dep JOIN patient ON patient.id_pat=interner.id_pat 
group by interner.id_dep order by NOMBRE DESC LIMIT 1 

#2é methode
SELECT departement.id_dep,departement.Nom_dep, COUNT(patient.id_pat) AS NOMBRE 
FROM departement,interner,patient WHERE interner.id_dep=departement.id_dep 
AND patient.id_pat=interner.id_pat 
group by interner.id_dep order by NOMBRE DESC LIMIT 1 


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#16.Donnez toutes les informations de la chambre ayant accueilli le plus de malade.

SELECT COUNT( lit.id_lit ) AS nombre, lit.id_lit, lit.id_ch
FROM lit, patient, occuper
WHERE occuper.id_pat = patient.id_pat
AND occuper.id_lit = lit.id_lit
GROUP BY lit.id_lit
ORDER BY nombre DESC
LIMIT 1

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#17.Donnez toutes les informations du médecin ayant suivi le plus de malade.
SELECT COUNT( medecin.id_med ) AS nombre, medecin.id_med, Nom_med, specialite, departement.id_dep
FROM departement, medecin, patient, suivre
WHERE medecin.id_dep = departement.id_dep
AND suivre.id_pat = patient.id_pat
AND suivre.id_med = medecin.id_med
GROUP BY medecin.id_med
ORDER BY nombre DESC
LIMIT 1

#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# 18.Donnez le numéro, le nom et la date de naissance du malade, le numéro de la chambre et le numéro du lit des patients 
#qui son suivi par un médecin avec la spécialité S2

SELECT patient.id_pat, patient.Nom_pat, patient.date_naiss, chambre.id_ch, lit.id_lit
FROM patient, lit, chambre, suivre, medecin, occuper
WHERE suivre.id_med = medecin.id_med
AND suivre.id_pat = patient.id_pat
AND occuper.id_lit = lit.id_lit
AND occuper.id_pat = patient.id_pat
AND medecin.specialite = "S2"
AND lit.id_ch=chambre.id_ch
LIMIT 0 , 30


#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#19.Donnez l’évolution du premier malade qui à été interné au département D2 en juin 2020
SELECT numFeu, DateF
FROM feuille, interner, departement, patient
WHERE departement.NOM_dep = "D2"
AND departement.id_dep = feuille.id_dep
AND patient.id_pat = feuille.id_pat
AND interner.id_pat = patient.id_pat
AND interner.id_dep = departement.id_dep
AND (MONTH( feuille.DateF ) =06 AND YEAR( feuille.DateF ) =2020)
ORDER BY DateF ASC LIMIT 1

##-----------------------------------------------------------------------------------------------------------------------------------------------------------------
# 20.	Donnez le numéro des lits qui n’ont pas été occupés au mois de mars.

SELECT DISTINCT lit.id_lit FROM lit, occuper WHERE lit.id_lit NOT IN (SELECT occuper.id_lit FROM occuper WHERE MONTH(occuper.DateOcc)=3)










