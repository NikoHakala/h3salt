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



## d) Näytä omalla salt-varastollasi esimerkit komennoista ‘git log’, ‘git diff’ ja ‘git blame’. Selitä tulokset.


## e) Tee tyhmä muutos gittiin, älä tee commit:tia. Tuhoa huonot muutokset ‘git reset –hard’. Huomaa, että tässä toiminnossa ei ole peruutusnappia.


## f) Tee uusi salt-moduli. Voit asentaa ja konfiguroida minkä vain uuden ohjelman: demonin, työpöytäohjelman tai komentokehotteesta toimivan ohjelman. Käytä tarvittaessa ‘find -printf “%T+ %p\n”|sort’ löytääksesi uudet asetustiedostot.

# Lähteet

http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to-%e2%80%93-loppukevat-2018-5p