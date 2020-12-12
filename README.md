# Batch PDF Compressor

Version 1.0 du 12/12/2020 - Par Tlem33  
https://github.com/Tlem33/Batch_PDF_Compressor

***

## DESCRIPTION :

Ce batch permet de compresser automatiquement un ou plusieurs fichiers PDF grâce au programme  
[Ghostscript](https://www.ghostscript.com/download) qui ce trouve dans le dossier \bin  
Pour faire fonctionner ce batch sur un système en 32 bits, vous devrez rajouter ou remplacer  
les programmes \bin\gswin64c.exe et \bin\gsdll64.dll par leur version 32 bits.  
 
Avant d'effectuer la compression, un menu vous indiquera le nombre de fichiers à compresser et vous  
aurez le choix entre les 5 profils de base de Ghostscript :  
 
	- screen   - Compression forte, qualité faible (Document pour lecture rapide sur écran uniquement).
	- ebook    - Compression forte, qualité moyenne (Document pour lecture électronique confortable).
	- default  - Compression bonne, qualité bonne (Peu d'écart visible avec l'original).
	- printer  - Compression moyenne, qualité bonne (Document de bonne qualité pour impression).
	- prepress - Compression faible, qualité haute (Document de très bonne qualité pour impression professionnelle).

Le profil "ebook" semble un bon compromis pour des documents avec des images de bonne qualité.  
Si vous constatez une dégradation trop importante des images, alors préférez le profil "default".  
	
Après avoir choisi le niveau de compression des documents, vous devrez choisir si vous gardez le  
document original ou si vous le remplacez par le fichier compressé.  
Si vous gardez l'original, le nom du document compressé comportera le nom du profil de compression.  

     Ex : MonFichier.pdf deviendra Monfichier_ebook.pdf  

### Voici quelques exemples de compression sur 3 fichiers de type différent :  

Doc1.pdf = Fichier composé uniquement d'images  
Doc2.pdf = fichier composé de texte et d'images monochrome  
Doc3.pdf = fichier composé de texte et d'images couleur  


   |          | Doc1.pdf   | Doc2.pdf  | Doc3.pdf   |  
   | -------  | ---------: | --------: | ---------: |  
   | Base     | 105 981 Ko | 50 681 Ko | 101 426 Ko |  
   | screen   |  71 473 Ko | 15 450 Ko |   3 665 Ko |  
   | ebook    |  78 370 Ko | 18 962 Ko |   8 288 Ko |  
   | default  | 105 825 Ko | 20 112 Ko |  75 865 Ko |  
   | printer  | 105 835 Ko | 20 606 Ko |  77 084 Ko |  
   | prepress | 105 825 Ko | 20 706 Ko |  79 060 Ko |  


## UTILISATION :

Faites un glisser/déposer de un ou plusieurs fichiers PDF sur le batch (Les dossiers et sous dossiers sont pris en compte).  
A l'affichage du menu principal, choisissez la compression désirée puis validez.  
Pour finir choisissez si vous conservez le fichier original.

*** 

## SYSTEME(S) :

Testé sous Windows 10

***

## LICENCE :

Licence [MIT](https://fr.wikipedia.org/wiki/Licence_MIT)  

Droit d'auteur (c) 2020 Tlem33  

Une autorisation est accordée, gratuitement, à toute personne obtenant une copie de ce logiciel  
et des fichiers de documentation associés (le «logiciel»), afin de traiter le logiciel sans restriction,  
y compris et sans s’y limiter, les droits d’utilisation, de copie, de modification, de fusion, publiez,  
distribuez, sous-licence et/ou vendez des copies du logiciel, et pour permettre aux personnes  
auxquelles le logiciel est fourni, selon les conditions suivantes:  

La notification du droit d’auteur ci-dessus et cette notification de permission doivent être incluses  
dans toutes les copies ou portions substantielles du Logiciel.  

LE LOGICIEL EST FOURNI « EN L’ÉTAT » SANS GARANTIE OU CONDITION D’AUCUNE SORTE, EXPLICITE OU IMPLICITE  
NOTAMMENT, MAIS SANS S’Y LIMITER LES GARANTIES OU CONDITIONS RELATIVES À SA QUALITÉ MARCHANDE,  
SON ADÉQUATION À UN BUT PARTICULIER OU AU RESPECT DES DROITS DE PARTIES TIERCES. EN AUCUN CAS LES  
AUTEURS OU LES TITULAIRES DES DROITS DE COPYRIGHT NE SAURAIENT ÊTRE TENUS RESPONSABLES POUR TOUT  
DÉFAUT, DEMANDE OU DOMMAGE, Y COMPRIS DANS LE CADRE D’UN CONTRAT OU NON, OU EN LIEN DIRECT OU  
INDIRECT AVEC L’UTILISATION DE CE LOGICIEL.

---

## HISTORIQUE :

12/12/2020 - Version 1.0  
    - Première version.  