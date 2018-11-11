# Palvelinten Hallinta H3
Tehtävä tehty Xubuntu 18.04 käyttöjärjestelmällä

http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to-%e2%80%93-loppukevat-2018-5p

## b) MarkDown. Tee tämän tehtävän raportti MarkDownina. Helpointa on tehdä raportti samaan GitHub-varastoon kuin Salt-modulit. Tiedostoon .md-pääte. Tyhjä rivi tekee kappalejaon, risuaita ‘#’ tekee otsikon, sisennys merkitsee koodinpätkän.

## c) Laita /srv/salt/ gittiin. Tee uusi moduli. Kloonaa varastosi toiselle koneelle (tai poista /srv/salt ja palauta se kloonaamalla) ja jatka sillä.

Aloitin asentamalla salt masterin, minionin ja gitin.

	sudo apt-get install salt-master salt-minion -y

Sitten muokkasin /etc/salt/minion tiedostoa ensin tyhjentämällä sen.

	xubuntu@xubuntu:~$ echo asd
	asd
	xubuntu@xubuntu:~$ echo asd|sudo tee /etc/salt/minion
	asd
	xubuntu@xubuntu:~$ cat /etc/salt/minion
	asd

Sitten viellä lisäsin asd tilalle masterin ipn ja orjalle idn.

	master: ip-osoite
	id: OrjaLocal1

Käynnistin orjan uudelleen ja hyväksyin avaimen masterilla.

	sudo systemctl restart salt-minion.service
	sudo salt-key -A

Kun se oli tehty navigoin /srv/ hakemistoon ja tein sinne gitillä salt kansion.

	sudo git init salt

Aloitin uuden modulin rakentamisen tekemällä kansion saltin alle.

	sudo mkdir ssh

Kansioon ssh tein init.sls tiedoston.

	ssh:
	  pkg.installed

	openssh:
	  service.running:
	    - name: ssh

Lisäsin viellä /srv/salt alle top.sls tiedoston

	base:
  	  '*':
	    - ssh

Sitten kokeilin ajaa orjat high stateen.

	sudo salt '*' state.highstate

Kun uusi moduli oli toiminnassa kloonasin varastoni githubiin tekemällä ensin repositorin sinne.

Kopioin myös tämän README.md filun /srv/salt/ alle.

Koska srv hakemistossa tarvitsee pääkäyttäjän oikeuksia niin myös gitillä pitää käyttää sudoa

	sudo git add .
	sudo git commit -m "First Commit"

	
	*** Please tell me who you are.

	Run
	git config --global user.email "you@example.com"
	git config --global user.name "Your Name"

	to set your account's default identity.
	Omit --global to set the identity only in this repository.

	fatal: unable to auto-detect email address (got 'root@xubuntu.(none)')

Commit ei toiminut koska en ollut tehnyt lokaalia käyttäjää gittiin.

	git config --global user.email "Niko_hakala_94@hotmail.com"
	git config --global user.name "Niko Hakala"
	sudo git commit -m "First Commit"
	sudo git remote add origin https://github.com/NikoHakala/salt.git
	sudo git push -u origin master

Sitten poistin /srv/salt hakemiston ja kloonasin sen takaisin githubista.

	sudo rm -r /srv/salt
	sudo git clone https://github.com/NikoHakala/salt.git



## d) Näytä omalla salt-varastollasi esimerkit komennoista ‘git log’, ‘git diff’ ja ‘git blame’. Selitä tulokset.

Git logilla näkee kaikki muutokset mitä repositoriin on tehty.

	xubuntu@xubuntu:/srv/salt$ sudo git log
	commit e19a38e7a03f933e3ecac50d7af836b973c20040 (HEAD -> master, origin/master, origin/HEAD)
	Author: Niko Hakala <Niko_hakala_92@hotmail.com>
	Date:   Sun Nov 11 11:18:27 2018 +0000
	
	  Updated README
	
	commit d6d51bb108ef515a9d026420c2d7ad369974c7a7
	Author: Niko Hakala <Niko_hakala_92@hotmail.com>
	Date:   Sun Nov 11 10:59:49 2018 +0000
	
	  First Commit

Git diff näyttää mitä tiedostoihin on muutettu viime pullin jälkeen. + on lisäys ja - on poisto

	xubuntu@xubuntu:/srv/salt$ sudo git diff top.sls
	diff --git a/top.sls b/top.sls
	index d7d4703..294c0f9 100644
	--- a/top.sls
	+++ b/top.sls
	@@ -1,3 +1,5 @@
	 base:
	   '*':
	     - ssh
	+    - gitdifftest
	+

Git blame näyttää kuka on tehnyt muutoksia ja mihin riviin.

	xubuntu@xubuntu:/srv/salt$ sudo git blame top.sls
	^d6d51bb (Niko Hakala       2018-11-11 10:59:49 +0000 1) base:
	^d6d51bb (Niko Hakala       2018-11-11 10:59:49 +0000 2)   '*':
	^d6d51bb (Niko Hakala       2018-11-11 10:59:49 +0000 3)     - ssh
	00000000 (Not Committed Yet 2018-11-11 11:30:47 +0000 4)     - gitdifftest
	00000000 (Not Committed Yet 2018-11-11 11:30:47 +0000 5) 


## e) Tee tyhmä muutos gittiin, älä tee commit:tia. Tuhoa huonot muutokset ‘git reset –hard’. Huomaa, että tässä toiminnossa ei ole peruutusnappia.

Poistin README.md kokonaan. 

	xubuntu@xubuntu:/srv/salt$ sudo rm README.md 
	xubuntu@xubuntu:/srv/salt$ sudo git reset --hard
	HEAD is now at e19a38e Updated README



## f) Tee uusi salt-moduli. Voit asentaa ja konfiguroida minkä vain uuden ohjelman: demonin, työpöytäohjelman tai komentokehotteesta toimivan ohjelman. Käytä tarvittaessa ‘find -printf “%T+ %p\n”|sort’ löytääksesi uudet asetustiedostot.

### Tein tähän tehtävään moduleita ohjelmista ja asetuksista joita käytän kun teen koulutehtäviä.


#### Terminaalin asetukset

	sudo mkdir terminaltheme

Muutin jotain terminaalin asetuksia kuten tausta värin kun valitsee tekstiä ja fontti koon.

	find -printf "%T+ %p\n"|sort

Find komennolla löytyi mihin terminaalin asetukset menevät.

	.config/xfce4/terminal/terminalrc

Kopioin asetukset uuteen polkuun /src/salt/terminaltheme
 
	sudo cp /home/xubuntu/xfce4/terminal/terminalrc /srv/salt/terminaltheme/

Sitten tein init.sls tiedoston terminalthemeen

	/home/xubuntu/.config/xfce4/terminal/terminalrc:
  	  file.managed:
   	   - source: salt://terminaltheme/terminalrc
   	   - user: xubuntu
   	   - group: xubuntu
   	   - makedirs: True

#### Ohjelmia

	sudo mkdir programs

	xubuntu@xubuntu:/srv/salt/programs$ cat init.sls 
	inkscape:
	  pkg.installed
	
	curl:
	  pkg.installed
	
	chromium-browser:
	  pkg.installed
	
	leafpad:
	  pkg.installed
	
	git:
	  pkg.installed


# Lähteet

http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to-%e2%80%93-loppukevat-2018-5p

