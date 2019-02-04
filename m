Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73353C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54292082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 21:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="CRUxGCzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfBDVbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 16:31:17 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:62598 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfBDVbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 16:31:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id EA88B13BA;
        Mon,  4 Feb 2019 22:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1549315866; x=1551130267;
         bh=jYWYx9FhfZj7WPUQ9J76RVrFV/m47seskCCG524s3Pg=; b=CRUxGCzYXjjd
        0m/Uye5yz6GFOtUdpKEfhcxcbVRIjmfH0cJ6GYpZmVFOmV4BycSR71cn6BzBVjAx
        788g5eCWfiwruYIba9PJeJ7OhXaG8BGOUKQZP0VX3q+lyKvLzB7dfueI2JzPFDdo
        SWId663sR08FlHRdLnmv0EQzCPYDCeKkIEscLDM3Ybe41TJMn943NtiW1Qj/Xqs7
        IS+on7JewjJsIpXHJvtGFLFGfUwmOc6dqPmJ96HhTWDfqyiMMtlymXN76EyVhzgf
        C6/n3dfOlg2mTyEiY+dIPvosGC4P3LYw+TH9iB22DpktxAJ5Ui+XMk1M/ZcHNUUs
        XOCa3jMDrHW/1KwmX7DYTSK73qYbc3dhAMVt6qkx5d63PQl4UP/EzNcNl1vgiDQw
        U+43i9aNxaUb7mVZzOcNU9yrq72n0fGXGdztXYY2H6/rS7MwTjJ54OtPNVeR2HWD
        0OJICgpJfC9KD68VMkIRQRzGyggHuuqR6zHH2bBI3bptUXIBTjf2324q9J+MBg/M
        yY46cvRUP63RQHjVkx3vjUhgxoRlFzR3J+/jaoJqou8/nT3i6xohAVIUg04m6wRj
        oSwmKGb1dz9kh8+z+zYonSiUvc69DOYEWoC45XosIl/x4GwhlMbD+mJLgvDIeEjz
        AWnOOfSFzHtTMSo1quhdQ8NduiXhs+A=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hqviSYg7bl0z; Mon,  4 Feb 2019 22:31:06 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id AB2E1DCD;
        Mon,  4 Feb 2019 22:31:06 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
        by int-mx002.mykolab.com (Postfix) with ESMTPS id B81A92546;
        Mon,  4 Feb 2019 22:31:04 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        federico.vaga@vaga.pv.it
Subject: [PATCH V3] doc:it_IT: add translations in process/
Date:   Mon,  4 Feb 2019 22:30:47 +0100
Message-Id: <20190204213047.10494-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the Italian translation for the following documents
in Documentation/process:

- applying-patches
- submit-checklist
- submitting-drivers
- changes
- stable api nonsense

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---

V3 - update according to recent change

8f7e6d134bda (doc/docs-next) doc: process: GPL -> GPL-compatible


 .../translations/it_IT/doc-guide/sphinx.rst   |   2 +
 .../it_IT/process/applying-patches.rst        |  12 +-
 .../translations/it_IT/process/changes.rst    | 487 +++++++++++++++++-
 .../it_IT/process/stable-api-nonsense.rst     | 202 +++++++-
 .../it_IT/process/submit-checklist.rst        | 127 ++++-
 .../it_IT/process/submitting-drivers.rst      |   8 +-
 6 files changed, 822 insertions(+), 16 deletions(-)

diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst b/Documentation/translations/it_IT/doc-guide/sphinx.rst
index 474b7e127893..793b5cc33403 100644
--- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
+++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
@@ -3,6 +3,8 @@
 .. note:: Per leggere la documentazione originale in inglese:
 	  :ref:`Documentation/doc-guide/index.rst <doc_guide>`
 
+.. _it_sphinxdoc:
+
 Introduzione
 ============
 
diff --git a/Documentation/translations/it_IT/process/applying-patches.rst b/Documentation/translations/it_IT/process/applying-patches.rst
index f5e9c7d0b16d..1d30e5cd2a3d 100644
--- a/Documentation/translations/it_IT/process/applying-patches.rst
+++ b/Documentation/translations/it_IT/process/applying-patches.rst
@@ -1,13 +1,15 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/applying-patches.rst <applying_patches>`
-
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_applying_patches:
 
-Applicare modifiche al kernel Linux
-===================================
+Applicare patch al kernel Linux
++++++++++++++++++++++++++++++++
 
-.. warning::
+.. note::
 
-    TODO ancora da tradurre
+   Questo documento è obsoleto.  Nella maggior parte dei casi, piuttosto
+   che usare ``patch`` manualmente, vorrete usare Git.  Per questo motivo
+   il documento non verrà tradotto.
diff --git a/Documentation/translations/it_IT/process/changes.rst b/Documentation/translations/it_IT/process/changes.rst
index 956cf95a1214..d0874327f301 100644
--- a/Documentation/translations/it_IT/process/changes.rst
+++ b/Documentation/translations/it_IT/process/changes.rst
@@ -1,12 +1,495 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/changes.rst <changes>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_changes:
 
 Requisiti minimi per compilare il kernel
 ++++++++++++++++++++++++++++++++++++++++
 
-.. warning::
+Introduzione
+============
 
-    TODO ancora da tradurre
+Questo documento fornisce una lista dei software necessari per eseguire i
+kernel 4.x.
+
+Questo documento è basato sul file "Changes" del kernel 2.0.x e quindi le
+persone che lo scrissero meritano credito (Jared Mauch, Axel Boldt,
+Alessandro Sigala, e tanti altri nella rete).
+
+Requisiti minimi correnti
+*************************
+
+Prima di pensare d'avere trovato un baco, aggiornate i seguenti programmi
+**almeno** alla versione indicata!  Se non siete certi della versione che state
+usando, il comando indicato dovrebbe dirvelo.
+
+Questa lista presume che abbiate già un kernel Linux funzionante.  In aggiunta,
+non tutti gli strumenti sono necessari ovunque; ovviamente, se non avete un
+modem ISDN, per esempio, probabilmente non dovreste preoccuparvi di
+isdn4k-utils.
+
+====================== =================  ========================================
+        Programma       Versione minima       Comando per verificare la versione
+====================== =================  ========================================
+GNU C                  4.6                gcc --version
+GNU make               3.81               make --version
+binutils               2.20               ld -v
+flex                   2.5.35             flex --version
+bison                  2.0                bison --version
+util-linux             2.10o              fdformat --version
+kmod                   13                 depmod -V
+e2fsprogs              1.41.4             e2fsck -V
+jfsutils               1.1.3              fsck.jfs -V
+reiserfsprogs          3.6.3              reiserfsck -V
+xfsprogs               2.6.0              xfs_db -V
+squashfs-tools         4.0                mksquashfs -version
+btrfs-progs            0.18               btrfsck
+pcmciautils            004                pccardctl -V
+quota-tools            3.09               quota -V
+PPP                    2.4.0              pppd --version
+isdn4k-utils           3.1pre1            isdnctrl 2>&1|grep version
+nfs-utils              1.0.5              showmount --version
+procps                 3.2.0              ps --version
+oprofile               0.9                oprofiled --version
+udev                   081                udevd --version
+grub                   0.93               grub --version || grub-install --version
+mcelog                 0.6                mcelog --version
+iptables               1.4.2              iptables -V
+openssl & libcrypto    1.0.0              openssl version
+bc                     1.06.95            bc --version
+Sphinx\ [#f1]_         1.3                sphinx-build --version
+====================== =================  ========================================
+
+.. [#f1] Sphinx è necessario solo per produrre la documentazione del Kernel
+
+Compilazione del kernel
+***********************
+
+GCC
+---
+
+La versione necessaria di gcc potrebbe variare a seconda del tipo di CPU nel
+vostro calcolatore.
+
+Make
+----
+
+Per compilare il kernel vi servirà GNU make 3.81 o successivo.
+
+Binutils
+--------
+
+Il sistema di compilazione, dalla versione 4.13,  per la produzione dei passi
+intermedi, si è convertito all'uso di *thin archive* (`ar T`) piuttosto che
+all'uso del *linking* incrementale (`ld -r`). Questo richiede binutils 2.20 o
+successivo.
+
+pkg-config
+----------
+
+Il sistema di compilazione, dalla versione 4.18, richiede pkg-config per
+verificare l'esistenza degli strumenti kconfig e per determinare le
+impostazioni da usare in 'make {g,x}config'.  Precedentemente pkg-config
+veniva usato ma non verificato o documentato.
+
+Flex
+----
+
+Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
+un analizzatore lessicale.  Questo richiede flex 2.5.35 o successivo.
+
+Bison
+-----
+
+Dalla versione 4.16, il sistema di compilazione, durante l'esecuzione, genera
+un parsificatore.  Questo richiede bison 2.0 o successivo.
+
+Perl
+----
+
+Per compilare il kernel vi servirà perl 5 e i seguenti moduli ``Getopt::Long``,
+``Getopt::Std``, ``File::Basename``, e ``File::Find``.
+
+BC
+--
+
+Vi servirà bc per compilare i kernel dal 3.10 in poi.
+
+OpenSSL
+-------
+
+Il programma OpenSSL e la libreria crypto vengono usati per la firma dei moduli
+e la gestione dei certificati; sono usati per la creazione della chiave e
+la generazione della firma.
+
+Se la firma dei moduli è abilitata, allora vi servirà openssl per compilare il
+kernel 3.7 e successivi.  Vi serviranno anche i pacchetti di sviluppo di
+openssl per compilare il kernel 4.3 o successivi.
+
+
+Strumenti di sistema
+********************
+
+Modifiche architetturali
+------------------------
+
+DevFS è stato reso obsoleto da udev
+(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
+
+Il supporto per UID a 32-bit è ora disponibile.  Divertitevi!
+
+La documentazione delle funzioni in Linux è una fase di transizione
+verso una documentazione integrata nei sorgenti stessi usando dei commenti
+formattati in modo speciale e posizionati vicino alle funzioni che descrivono.
+Al fine di arricchire la documentazione, questi commenti possono essere
+combinati con i file ReST presenti in Documentation/; questi potranno
+poi essere convertiti in formato PostScript, HTML, LaTex, ePUB o PDF.
+Per convertire i documenti da ReST al formato che volete, avete bisogno di
+Sphinx.
+
+Util-linux
+----------
+
+Le versioni più recenti di util-linux: forniscono il supporto a ``fdisk`` per
+dischi di grandi dimensioni; supportano le nuove opzioni di mount; riconoscono
+più tipi di partizioni; hanno un fdformat che funziona con i kernel 2.4;
+e altre chicche.  Probabilmente vorrete aggiornarlo.
+
+Ksymoops
+--------
+
+Se l'impensabile succede e il kernel va in oops, potrebbe servirvi lo strumento
+ksymoops per decodificarlo, ma nella maggior parte dei casi non vi servirà.
+Generalmente è preferibile compilare il kernel con l'opzione ``CONFIG_KALLSYMS``
+cosicché venga prodotto un output più leggibile che può essere usato così com'è
+(produce anche un output migliore di ksymoops).  Se per qualche motivo il
+vostro kernel non è stato compilato con ``CONFIG_KALLSYMS`` e non avete modo di
+ricompilarlo e riprodurre l'oops con quell'opzione abilitata, allora potete
+usare ksymoops per decodificare l'oops.
+
+Mkinitrd
+--------
+
+I cambiamenti della struttura in ``/lib/modules`` necessita l'aggiornamento di
+mkinitrd.
+
+E2fsprogs
+---------
+
+L'ultima versione di ``e2fsprogs`` corregge diversi bachi in fsck e debugfs.
+Ovviamente, aggiornarlo è una buona idea.
+
+JFSutils
+--------
+
+Il pacchetto ``jfsutils`` contiene programmi per il file-system JFS.
+Sono disponibili i seguenti strumenti:
+
+- ``fsck.jfs`` - avvia la ripetizione del log delle transizioni, e verifica e
+  ripara una partizione formattata secondo JFS
+
+- ``mkfs.jfs`` - crea una partizione formattata secondo JFS
+
+- sono disponibili altri strumenti per il file-system.
+
+Reiserfsprogs
+-------------
+
+Il pacchetto reiserfsprogs dovrebbe essere usato con reiserfs-3.6.x (Linux
+kernel 2.4.x).  Questo è un pacchetto combinato che contiene versioni
+funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
+``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e alpha.
+
+Xfsprogs
+--------
+
+L'ultima versione di ``xfsprogs`` contiene, fra i tanti, i programmi
+``mkfs.xfs``, ``xfs_db`` e ``xfs_repair`` per il file-system XFS.
+Dipendono dell'architettura e qualsiasi versione dalla 2.0.0 in poi
+dovrebbe funzionare correttamente con la versione corrente del codice
+XFS nel kernel (sono raccomandate le versioni 2.6.0 o successive per via
+di importanti miglioramenti).
+
+PCMCIAutils
+-----------
+
+PCMCIAutils sostituisce ``pcmica-cs``.  Serve ad impostare correttamente i
+connettori PCMCIA all'avvio del sistema e a caricare i moduli necessari per
+i dispositivi a 16-bit se il kernel è stato modularizzato e il sottosistema
+hotplug è in uso.
+
+Quota-tools
+-----------
+
+Il supporto per uid e gid a 32 bit richiedono l'uso della versione 2 del
+formato quota.  La versione 3.07 e successive di quota-tools supportano
+questo formato.  Usate la versione raccomandata nella lista qui sopra o una
+successiva.
+
+Micro codice per Intel IA32
+---------------------------
+
+Per poter aggiornare il micro codice per Intel IA32, è stato aggiunto un
+apposito driver; il driver è accessibile come un normale dispositivo a
+caratteri (misc).  Se non state usando udev probabilmente sarà necessario
+eseguire i seguenti comandi come root prima di poterlo aggiornare::
+
+  mkdir /dev/cpu
+  mknod /dev/cpu/microcode c 10 184
+  chmod 0644 /dev/cpu/microcode
+
+Probabilmente, vorrete anche il programma microcode_ctl da usare con questo
+dispositivo.
+
+udev
+----
+
+``udev`` è un programma in spazio utente il cui scopo è quello di popolare
+dinamicamente la cartella ``/dev`` coi dispositivi effettivamente presenti.
+``udev`` sostituisce le funzionalità base di devfs, consentendo comunque
+nomi persistenti per i dispositivi.
+
+FUSE
+----
+
+Serve libfuse 2.4.0 o successiva.  Il requisito minimo assoluto è 2.3.0 ma
+le opzioni di mount ``direct_io`` e ``kernel_cache`` non funzioneranno.
+
+
+Rete
+****
+
+Cambiamenti generali
+--------------------
+
+Se per quanto riguarda la configurazione di rete avete esigenze di un certo
+livello dovreste prendere in considerazione l'uso degli strumenti in ip-route2.
+
+Filtro dei pacchetti / NAT
+--------------------------
+
+Il codice per filtraggio dei pacchetti e il NAT fanno uso degli stessi
+strumenti come nelle versioni del kernel antecedenti la 2.4.x (iptables).
+Include ancora moduli di compatibilità per 2.2.x ipchains e 2.0.x ipdwadm.
+
+PPP
+---
+
+Il driver per PPP è stato ristrutturato per supportare collegamenti multipli e
+per funzionare su diversi livelli.  Se usate PPP, aggiornate pppd almeno alla
+versione 2.4.0.
+
+Se non usate udev, dovete avere un file /dev/ppp che può essere creato da root
+col seguente comando::
+
+  mknod /dev/ppp c 108 0
+
+Isdn4k-utils
+------------
+
+Per via della modifica del campo per il numero di telefono, il pacchetto
+isdn4k-utils dev'essere ricompilato o (preferibilmente) aggiornato.
+
+NFS-utils
+---------
+
+Nei kernel più antichi (2.4 e precedenti), il server NFS doveva essere
+informato sui clienti ai quali si voleva fornire accesso via NFS.  Questa
+informazione veniva passata al kernel quando un cliente montava un file-system
+mediante ``mountd``, oppure usando ``exportfs`` all'avvio del sistema.
+exportfs prende le informazioni circa i clienti attivi da ``/var/lib/nfs/rmtab``.
+
+Questo approccio è piuttosto delicato perché dipende dalla correttezza di
+rmtab, che non è facile da garantire, in particolare quando si cerca di
+implementare un *failover*.  Anche quando il sistema funziona bene, ``rmtab``
+ha il problema di accumulare vecchie voci inutilizzate.
+
+Sui kernel più recenti il kernel ha la possibilità di informare mountd quando
+arriva una richiesta da una macchina sconosciuta, e mountd può dare al kernel
+le informazioni corrette per l'esportazione.  Questo rimuove la dipendenza con
+``rmtab`` e significa che il kernel deve essere al corrente solo dei clienti
+attivi.
+
+Per attivare questa funzionalità, dovete eseguire il seguente comando prima di
+usare exportfs o mountd::
+
+  mount -t nfsd nfsd /proc/fs/nfsd
+
+Dove possibile, raccomandiamo di proteggere tutti i servizi NFS dall'accesso
+via internet mediante un firewall.
+
+mcelog
+------
+
+Quando ``CONFIG_x86_MCE`` è attivo, il programma mcelog processa e registra
+gli eventi *machine check*.  Gli eventi *machine check* sono errori riportati
+dalla CPU.  Incoraggiamo l'analisi di questi errori.
+
+
+Documentazione del kernel
+*************************
+
+Sphinx
+------
+
+Per i dettaglio sui requisiti di Sphinx, fate riferimento a :ref:`it_sphinx_install`
+in :ref:`Documentation/translations/it_IT/doc-guide/sphinx.rst <it_sphinxdoc>`
+
+Ottenere software aggiornato
+============================
+
+Compilazione del kernel
+***********************
+
+gcc
+---
+
+- <ftp://ftp.gnu.org/gnu/gcc/>
+
+Make
+----
+
+- <ftp://ftp.gnu.org/gnu/make/>
+
+Binutils
+--------
+
+- <https://www.kernel.org/pub/linux/devel/binutils/>
+
+Flex
+----
+
+- <https://github.com/westes/flex/releases>
+
+Bison
+-----
+
+- <ftp://ftp.gnu.org/gnu/bison/>
+
+OpenSSL
+-------
+
+- <https://www.openssl.org/>
+
+Strumenti di sistema
+********************
+
+Util-linux
+----------
+
+- <https://www.kernel.org/pub/linux/utils/util-linux/>
+
+Kmod
+----
+
+- <https://www.kernel.org/pub/linux/utils/kernel/kmod/>
+- <https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git>
+
+Ksymoops
+--------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4/>
+
+Mkinitrd
+--------
+
+- <https://code.launchpad.net/initrd-tools/main>
+
+E2fsprogs
+---------
+
+- <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+
+JFSutils
+--------
+
+- <http://jfs.sourceforge.net/>
+
+Reiserfsprogs
+-------------
+
+- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
+
+Xfsprogs
+--------
+
+- <ftp://oss.sgi.com/projects/xfs/>
+
+Pcmciautils
+-----------
+
+- <https://www.kernel.org/pub/linux/utils/kernel/pcmcia/>
+
+Quota-tools
+-----------
+
+- <http://sourceforge.net/projects/linuxquota/>
+
+
+Microcodice Intel P6
+--------------------
+
+- <https://downloadcenter.intel.com/>
+
+udev
+----
+
+- <http://www.freedesktop.org/software/systemd/man/udev.html>
+
+FUSE
+----
+
+- <https://github.com/libfuse/libfuse/releases>
+
+mcelog
+------
+
+- <http://www.mcelog.org/>
+
+Rete
+****
+
+PPP
+---
+
+- <ftp://ftp.samba.org/pub/ppp/>
+
+Isdn4k-utils
+------------
+
+- <ftp://ftp.isdn4linux.de/pub/isdn4linux/utils/>
+
+NFS-utils
+---------
+
+- <http://sourceforge.net/project/showfiles.php?group_id=14>
+
+Iptables
+--------
+
+- <http://www.iptables.org/downloads.html>
+
+Ip-route2
+---------
+
+- <https://www.kernel.org/pub/linux/utils/net/iproute2/>
+
+OProfile
+--------
+
+- <http://oprofile.sf.net/download/>
+
+NFS-Utils
+---------
+
+- <http://nfs.sourceforge.net/>
+
+Documentazione del kernel
+*************************
+
+Sphinx
+------
+
+- <http://www.sphinx-doc.org/>
diff --git a/Documentation/translations/it_IT/process/stable-api-nonsense.rst b/Documentation/translations/it_IT/process/stable-api-nonsense.rst
index d4fa4abf8dd3..cdfc509b8566 100644
--- a/Documentation/translations/it_IT/process/stable-api-nonsense.rst
+++ b/Documentation/translations/it_IT/process/stable-api-nonsense.rst
@@ -1,13 +1,209 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/stable-api-nonsense.rst <stable_api_nonsense>`
-
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_stable_api_nonsense:
 
 L'interfaccia dei driver per il kernel Linux
 ============================================
 
-.. warning::
+(tutte le risposte alle vostre domande e altro)
+
+Greg Kroah-Hartman <greg@kroah.com>
+
+Questo è stato scritto per cercare di spiegare perché Linux **non ha
+un'interfaccia binaria, e non ha nemmeno un'interfaccia stabile**.
+
+.. note::
+
+   Questo articolo parla di interfacce **interne al kernel**, non delle
+   interfacce verso lo spazio utente.
+
+   L'interfaccia del kernel verso lo spazio utente è quella usata dai
+   programmi, ovvero le chiamate di sistema.  Queste interfacce sono **molto**
+   stabili nel tempo e non verranno modificate.  Ho vecchi programmi che sono
+   stati compilati su un kernel 0.9 (circa) e tuttora funzionano sulle versioni
+   2.6 del kernel.  Queste interfacce sono quelle che gli utenti e i
+   programmatori possono considerare stabili.
+
+Riepilogo generale
+------------------
+
+Pensate di volere un'interfaccia del kernel stabile, ma in realtà non la
+volete, e nemmeno sapete di non volerla.  Quello che volete è un driver
+stabile che funzioni, e questo può essere ottenuto solo se il driver si trova
+nei sorgenti del kernel.  Ci sono altri vantaggi nell'avere il proprio driver
+nei sorgenti del kernel, ognuno dei quali hanno reso Linux un sistema operativo
+robusto, stabile e maturo; questi sono anche i motivi per cui avete scelto
+Linux.
+
+Introduzione
+------------
+
+Solo le persone un po' strambe vorrebbero scrivere driver per il kernel con
+la costante preoccupazione per i cambiamenti alle interfacce interne.  Per il
+resto del mondo, queste interfacce sono invisibili o non di particolare
+interesse.
+
+Innanzitutto, non tratterò **alcun** problema legale riguardante codice
+chiuso, nascosto, avvolto, blocchi binari, o qualsia altra cosa che descrive
+driver che non hanno i propri sorgenti rilasciati con licenza GPL.  Per favore
+fate riferimento ad un avvocato per qualsiasi questione legale, io sono un
+programmatore e perciò qui vi parlerò soltanto delle questioni tecniche (non
+per essere superficiali sui problemi legali, sono veri e dovete esserne a
+conoscenza in ogni circostanza).
+
+Dunque, ci sono due tematiche principali: interfacce binarie del kernel e
+interfacce stabili nei sorgenti.  Ognuna dipende dall'altra, ma discuteremo
+prima delle cose binarie per toglierle di mezzo.
+
+Interfaccia binaria del kernel
+------------------------------
+
+Supponiamo d'avere un'interfaccia stabile nei sorgenti del kernel, di
+conseguenza un'interfaccia binaria dovrebbe essere anche'essa stabile, giusto?
+Sbagliato.  Prendete in considerazione i seguenti fatti che riguardano il
+kernel Linux:
+
+  - A seconda della versione del compilatore C che state utilizzando, diverse
+    strutture dati del kernel avranno un allineamento diverso, e possibilmente
+    un modo diverso di includere le funzioni (renderle inline oppure no).
+    L'organizzazione delle singole funzioni non è poi così importante, ma la
+    spaziatura (*padding*) nelle strutture dati, invece, lo è.
+
+  - In base alle opzioni che sono state selezionate per generare il kernel,
+    un certo numero di cose potrebbero succedere:
+
+      - strutture dati differenti potrebbero contenere campi differenti
+      - alcune funzioni potrebbero non essere implementate (per esempio,
+        alcuni *lock* spariscono se compilati su sistemi mono-processore)
+      - la memoria interna del kernel può essere allineata in differenti modi
+        a seconda delle opzioni di compilazione.
+
+  - Linux funziona su una vasta gamma di architetture di processore. Non esiste
+    alcuna possibilità che il binario di un driver per un'architettura funzioni
+    correttamente su un'altra.
+
+Alcuni di questi problemi possono essere risolti compilando il proprio modulo
+con la stessa identica configurazione del kernel, ed usando la stessa versione
+del compilatore usato per compilare il kernel.  Questo è sufficiente se volete
+fornire un modulo per uno specifico rilascio su una specifica distribuzione
+Linux.  Ma moltiplicate questa singola compilazione per il numero di
+distribuzioni Linux e il numero dei rilasci supportati da quest'ultime e vi
+troverete rapidamente in un incubo fatto di configurazioni e piattaforme
+hardware (differenti processori con differenti opzioni); dunque, anche per il
+singolo rilascio di un modulo, dovreste creare differenti versioni dello
+stesso.
+
+Fidatevi, se tenterete questa via, col tempo, diventerete pazzi; l'ho imparato
+a mie spese molto tempo fa...
+
+
+Interfaccia stabile nei sorgenti del kernel
+-------------------------------------------
+
+Se parlate con le persone che cercano di mantenere aggiornato un driver per
+Linux ma che non si trova nei sorgenti, allora per queste persone l'argomento
+sarà "ostico".
+
+Lo sviluppo del kernel Linux è continuo e viaggia ad un ritmo sostenuto, e non
+rallenta mai.  Perciò, gli sviluppatori del kernel trovano bachi nelle
+interfacce attuali, o trovano modi migliori per fare le cose.  Se le trovano,
+allora le correggeranno per migliorarle.  In questo frangente, i nomi delle
+funzioni potrebbero cambiare, le strutture dati potrebbero diventare più grandi
+o più piccole, e gli argomenti delle funzioni potrebbero essere ripensati.
+Se questo dovesse succedere, nello stesso momento, tutte le istanze dove questa
+interfaccia viene utilizzata verranno corrette, garantendo che tutto continui
+a funzionare senza problemi.
+
+Portiamo ad esempio l'interfaccia interna per il sottosistema USB che ha subito
+tre ristrutturazioni nel corso della sua vita.  Queste ristrutturazioni furono
+fatte per risolvere diversi problemi:
+
+  - È stato fatto un cambiamento da un flusso di dati sincrono ad uno
+    asincrono.  Questo ha ridotto la complessità di molti driver e ha
+    aumentato la capacità di trasmissione di tutti i driver fino a raggiungere
+    quasi la velocità massima possibile.
+  - È stato fatto un cambiamento nell'allocazione dei pacchetti da parte del
+    sottosistema USB per conto dei driver, cosicché ora i driver devono fornire
+    più informazioni al sottosistema USB al fine di correggere un certo numero
+    di stalli.
+
+Questo è completamente l'opposto di quello che succede in alcuni sistemi
+operativi proprietari che hanno dovuto mantenere, nel tempo, il supporto alle
+vecchie interfacce USB.  I nuovi sviluppatori potrebbero usare accidentalmente
+le vecchie interfacce e sviluppare codice nel modo sbagliato, portando, di
+conseguenza, all'instabilità del sistema.
+
+In entrambe gli scenari, gli sviluppatori hanno ritenuto che queste importanti
+modifiche erano necessarie, e quindi le hanno fatte con qualche sofferenza.
+Se Linux avesse assicurato di mantenere stabile l'interfaccia interna, si
+sarebbe dovuto procedere alla creazione di una nuova, e quelle vecchie, e
+mal funzionanti, avrebbero dovuto ricevere manutenzione, creando lavoro
+aggiuntivo per gli sviluppatori del sottosistema USB.  Dato che gli
+sviluppatori devono dedicare il proprio tempo a questo genere di lavoro,
+chiedergli di dedicarne dell'altro, senza benefici, magari gratuitamente, non
+è contemplabile.
+
+Le problematiche relative alla sicurezza sono molto importanti per Linux.
+Quando viene trovato un problema di sicurezza viene corretto in breve tempo.
+A volte, per prevenire il problema di sicurezza, si sono dovute cambiare
+delle interfacce interne al kernel.  Quando è successo, allo stesso tempo,
+tutti i driver che usavano quelle interfacce sono stati aggiornati, garantendo
+la correzione definitiva del problema senza doversi preoccupare di rivederlo
+per sbaglio in futuro.  Se non si fossero cambiate le interfacce interne,
+sarebbe stato impossibile correggere il problema e garantire che non si sarebbe
+più ripetuto.
+
+Nel tempo le interfacce del kernel subiscono qualche ripulita.  Se nessuno
+sta più usando un'interfaccia, allora questa verrà rimossa.  Questo permette
+al kernel di rimanere il più piccolo possibile, e garantisce che tutte le
+potenziali interfacce sono state verificate nel limite del possibile (le
+interfacce inutilizzate sono impossibili da verificare).
+
+
+Cosa fare
+---------
+
+Dunque, se avete un driver per il kernel Linux che non si trova nei sorgenti
+principali del kernel, come sviluppatori, cosa dovreste fare?  Rilasciare un
+file binario del driver per ogni versione del kernel e per ogni distribuzione,
+è un incubo; inoltre, tenere il passo con tutti i cambiamenti del kernel è un
+brutto lavoro.
+
+Semplicemente, fate sì che il vostro driver per il kernel venga incluso nei
+sorgenti principali (ricordatevi, stiamo parlando di driver rilasciati secondo
+una licenza compatibile con la GPL; se il vostro codice non ricade in questa
+categoria: buona fortuna, arrangiatevi, siete delle sanguisughe)
+
+Se il vostro driver è nei sorgenti del kernel e un'interfaccia cambia, il
+driver verrà corretto immediatamente dalla persona che l'ha modificata.  Questo
+garantisce che sia sempre possibile compilare il driver, che funzioni, e tutto
+con un minimo sforzo da parte vostra.
+
+Avere il proprio driver nei sorgenti principali del kernel ha i seguenti
+vantaggi:
+
+  - La qualità del driver aumenterà e i costi di manutenzione (per lo
+    sviluppatore originale) diminuiranno.
+  - Altri sviluppatori aggiungeranno nuove funzionalità al vostro driver.
+  - Altri persone troveranno e correggeranno bachi nel vostro driver.
+  - Altri persone troveranno degli aggiustamenti da fare al vostro driver.
+  - Altri persone aggiorneranno il driver quando è richiesto da un cambiamento
+    di un'interfaccia.
+  - Il driver sarà automaticamente reso disponibile in tutte le distribuzioni
+    Linux senza dover chiedere a nessuna di queste di aggiungerlo.
+
+Dato che Linux supporta più dispositivi di qualsiasi altro sistema operativo,
+e che girano su molti più tipi di processori di qualsiasi altro sistema
+operativo; ciò dimostra che questo modello di sviluppo qualcosa di giusto,
+dopo tutto, lo fa :)
+
+
+
+------
 
-    TODO ancora da tradurre
+Dei ringraziamenti vanno a Randy Dunlap, Andrew Morton, David Brownell,
+Hanna Linder, Robert Love, e Nishanth Aravamudan per la loro revisione
+e per i loro commenti sulle prime bozze di questo articolo.
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index b6b4dd94a660..70e65a7b3620 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -1,12 +1,131 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_submitchecklist:
 
-Lista delle cose da fare per inviare una modifica al kernel Linux
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Lista delle verifiche da fare prima di inviare una patch per il kernel Linux
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. warning::
+Qui troverete una lista di cose che uno sviluppatore dovrebbe fare per
+vedere le proprie patch accettate più rapidamente.
 
-    TODO ancora da tradurre
+Tutti questi punti integrano la documentazione fornita riguardo alla
+sottomissione delle patch, in particolare
+:ref:`Documentation/translations/it_IT/process/submitting-patches.rst <it_submittingpatches>`.
+
+1) Se state usando delle funzionalità del kernel allora includete (#include)
+   i file che le dichiarano/definiscono.  Non dipendente dal fatto che un file
+   d'intestazione include anche quelli usati da voi.
+
+2) Compilazione pulita:
+
+  a) con le opzioni ``CONFIG`` negli stati ``=y``, ``=m`` e ``=n``. Nessun
+     avviso/errore di ``gcc`` e nessun avviso/errore dal linker.
+
+  b) con ``allnoconfig``, ``allmodconfig``
+
+  c) quando si usa ``O=builddir``
+
+3) Compilare per diverse architetture di processore usando strumenti per
+   la cross-compilazione o altri.
+
+4) Una buona architettura per la verifica della cross-compilazione è la ppc64
+   perché tende ad usare ``unsigned long`` per le quantità a 64-bit.
+
+5) Controllate lo stile del codice della vostra patch secondo le direttive
+   scritte in :ref:`Documentation/translations/it_IT/process/coding-style.rst <it_codingstyle>`.
+   Prima dell'invio della patch, usate il verificatore di stile
+   (``script/checkpatch.pl``) per scovare le violazioni più semplici.
+   Dovreste essere in grado di giustificare tutte le violazioni rimanenti nella
+   vostra patch.
+
+6) Le opzioni ``CONFIG``, nuove o modificate, non scombussolano il menu
+   di configurazione e sono preimpostate come disabilitate a meno che non
+   soddisfino i criteri descritti in ``Documentation/kbuild/kconfig-language.txt``
+   alla punto "Voci di menu: valori predefiniti".
+
+7) Tutte le nuove opzioni ``Kconfig`` hanno un messaggio di aiuto.
+
+8) La patch è stata accuratamente revisionata rispetto alle più importanti
+   configurazioni ``Kconfig``.  Questo è molto difficile da fare
+   correttamente - un buono lavoro di testa sarà utile.
+
+9) Verificare con sparse.
+
+10) Usare ``make checkstack`` e ``make namespacecheck`` e correggere tutti i
+    problemi rilevati.
+
+    .. note::
+
+       ``checkstack`` non evidenzia esplicitamente i problemi, ma una funzione
+       che usa più di 512 byte sullo stack è una buona candidata per una
+       correzione.
+
+11) Includete commenti :ref:`kernel-doc <kernel_doc>` per documentare API
+    globali del kernel.  Usate ``make htmldocs`` o ``make pdfdocs`` per
+    verificare i commenti :ref:`kernel-doc <kernel_doc>` ed eventualmente
+    correggerli.
+
+12) La patch è stata verificata con le seguenti opzioni abilitate
+    contemporaneamente: ``CONFIG_PREEMPT``, ``CONFIG_DEBUG_PREEMPT``,
+    ``CONFIG_DEBUG_SLAB``, ``CONFIG_DEBUG_PAGEALLOC``, ``CONFIG_DEBUG_MUTEXES``,
+    ``CONFIG_DEBUG_SPINLOCK``, ``CONFIG_DEBUG_ATOMIC_SLEEP``,
+    ``CONFIG_PROVE_RCU`` e ``CONFIG_DEBUG_OBJECTS_RCU_HEAD``.
+
+13) La patch è stata compilata e verificata in esecuzione con, e senza,
+    le opzioni ``CONFIG_SMP`` e ``CONFIG_PREEMPT``.
+
+14) Se la patch ha effetti sull'IO dei dischi, eccetera: allora dev'essere
+    verificata con, e senza, l'opzione ``CONFIG_LBDAF``.
+
+15) Tutti i percorsi del codice sono stati verificati con tutte le funzionalità
+    di lockdep abilitate.
+
+16) Tutti i nuovi elementi in ``/proc`` sono documentati in ``Documentation/``.
+
+17) Tutti i nuovi parametri d'avvio del kernel sono documentati in
+    ``Documentation/admin-guide/kernel-parameters.rst``.
+
+18) Tutti i nuovi parametri dei moduli sono documentati con ``MODULE_PARM_DESC()``.
+
+19) Tutte le nuove interfacce verso lo spazio utente sono documentate in
+    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README`` per maggiori
+    informazioni.  Le patch che modificano le interfacce utente dovrebbero
+    essere inviate in copia anche a linux-api@vger.kernel.org.
+
+20) Verifica che il kernel passi con successo ``make headers_check``
+
+21) La patch è stata verificata con l'iniezione di fallimenti in slab e
+    nell'allocazione di pagine.  Vedere ``Documentation/fault-injection/``.
+
+    Se il nuovo codice è corposo, potrebbe essere opportuno aggiungere
+    l'iniezione di fallimenti specifici per il sottosistema.
+
+22) Il nuovo codice è stato compilato con ``gcc -W`` (usate
+    ``make EXTRA_CFLAGS=-W``).  Questo genererà molti avvisi, ma è ottimo
+    per scovare bachi come  "warning: comparison between signed and unsigned".
+
+23) La patch è stata verificata dopo essere stata inclusa nella serie di patch
+    -mm; questo al fine di assicurarsi che continui a funzionare assieme a
+    tutte le altre patch in coda e i vari cambiamenti nei sottosistemi VM, VFS
+    e altri.
+
+24) Tutte le barriere di sincronizzazione {per esempio, ``barrier()``,
+    ``rmb()``, ``wmb()``} devono essere accompagnate da un commento nei
+    sorgenti che ne spieghi la logica: cosa fanno e perché.
+
+25) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
+    ``Documentation/ioctl/ioctl-number.txt``.
+
+26) Se il codice che avete modificato dipende o usa una qualsiasi interfaccia o
+    funzionalità del kernel che è associata a uno dei seguenti simboli
+    ``Kconfig``, allora verificate che il kernel compili con diverse
+    configurazioni dove i simboli sono disabilitati e/o ``=m`` (se c'è la
+    possibilità) [non tutti contemporaneamente, solo diverse combinazioni
+    casuali]:
+
+    ``CONFIG_SMP``, ``CONFIG_SYSFS``, ``CONFIG_PROC_FS``, ``CONFIG_INPUT``,
+    ``CONFIG_PCI``, ``CONFIG_BLOCK``, ``CONFIG_PM``, ``CONFIG_MAGIC_SYSRQ``,
+    ``CONFIG_NET``, ``CONFIG_INET=n`` (ma l'ultimo con ``CONFIG_NET=y``).
diff --git a/Documentation/translations/it_IT/process/submitting-drivers.rst b/Documentation/translations/it_IT/process/submitting-drivers.rst
index 16df950ef808..dadd77e47613 100644
--- a/Documentation/translations/it_IT/process/submitting-drivers.rst
+++ b/Documentation/translations/it_IT/process/submitting-drivers.rst
@@ -1,12 +1,16 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_submittingdrivers:
 
 Sottomettere driver per il kernel Linux
 =======================================
 
-.. warning::
+.. note::
 
-    TODO ancora da tradurre
+   Questo documento è vecchio e negli ultimi anni non è stato più aggiornato;
+   dovrebbe essere aggiornato, o forse meglio, rimosso.  La maggior parte di
+   quello che viene detto qui può essere trovato anche negli altri documenti
+   dedicati allo sviluppo.  Per questo motivo il documento non verrà tradotto.
-- 
2.20.1

