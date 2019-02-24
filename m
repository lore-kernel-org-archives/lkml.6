Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B13C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12A20651
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="j59k4OGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfBXUF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:05:58 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:49794 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfBXUF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:05:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 4757D4124C;
        Sun, 24 Feb 2019 21:05:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1551038742; x=1552853143;
         bh=87hvGbVqeZUXCYTjHGYkGsDsaTkSR8JYlpf3cnDjn+o=; b=j59k4OGfvU9X
        N5bxk5HfliC7O9helT6346AHT5z5nuMxyQohUwBNdR0xSbJGxKVLvG/dZnk87Q1w
        WwBX4NbWhhG+eAwEwBY9VZjMluEkeUM+ZfLwmeCP+xWGH2rEtPhGrhTn2Hr463Cc
        Ce1iMtAlKY3pndfQezQf1AQ+R1JY2kTRGC/MN8fTAwL2Fa00kDYfVW+3cn0Bzvcu
        9sh8WhF7suawGr+okyH88y6yFR23t4aE3/bCwpP/bSZNT70wYJjAB2fS/SiUMJvM
        5wzN4Cu2diLf70hsD0Jmmx5VyAwx8Ok6RmgnEkleWbvCjLw9s25/F9BsIg2Irp13
        uxp0E7Gtmmqh8H3ng7LAf6aZGutVHzv9ox4R4LnHtAg1ZcSukvM541SrPIQtrlbc
        +buIRTUykOEnMGnH6UeUEh3t2bsC7wUJ/ndpDY5vs2l2On8BnO/nMRgSu8hc+C3L
        83HWBJSLekjM3hVURwfQpVk3/mBaCc/+EIOMRTn2eWIqoXmXrzS3XUYriFEb1yDH
        2oPRDpwc2D34V4N8mPN+/NRSTKAwx5LZomp0ho4bKpkOdlLnHNPW3DyfrD0CXhH+
        crtk1r3E69uVe1+HOcV5/oWpJq6KBg6D6CiOb0DOQjfY9rFOVYTFqaSvAaibim/h
        EshOx2IvWCsYLJVVr263EF1efX3nhKs=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1gVJD0sJZ3W0; Sun, 24 Feb 2019 21:05:42 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 35B3E40D33;
        Sun, 24 Feb 2019 21:05:42 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id E4B24B88;
        Sun, 24 Feb 2019 21:05:41 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: translations for documents in process/
Date:   Sun, 24 Feb 2019 21:05:27 +0100
Message-Id: <20190224200527.17435-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translated documents:
- stable-kernel-rules.rst
- deprecated.rst
- kernel-enforcement-statement.rst
- license-rules.rst

Added document to have valid links
- netdev-FAQ.rst

Modifications to main documentation
- add label in deprecated.rst

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/process/deprecated.rst          |   2 +
 Documentation/translations/it_IT/index.rst    |   8 +-
 .../it_IT/networking/netdev-FAQ.rst           |  13 +
 .../translations/it_IT/process/deprecated.rst | 129 +++++
 .../process/kernel-enforcement-statement.rst  | 168 ++++++-
 .../it_IT/process/license-rules.rst           | 452 ++++++++++++++++++
 .../it_IT/process/stable-kernel-rules.rst     | 194 +++++++-
 7 files changed, 954 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/translations/it_IT/networking/netdev-FAQ.rst
 create mode 100644 Documentation/translations/it_IT/process/deprecated.rst
 create mode 100644 Documentation/translations/it_IT/process/license-rules.rst

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 0ef5a63c06ba..49e0f64a3427 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _deprecated:
+
 =====================================================================
 Deprecated Interfaces, Language Features, Attributes, and Conventions
 =====================================================================
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
index ea9b2916b3e4..02432b97a43e 100644
--- a/Documentation/translations/it_IT/index.rst
+++ b/Documentation/translations/it_IT/index.rst
@@ -47,9 +47,7 @@ I seguenti documenti descrivono la licenza usata nei sorgenti del kernel Linux
 (GPLv2), come licenziare i singoli file; inoltre troverete i riferimenti al
 testo integrale della licenza.
 
-.. warning::
-
-    TODO ancora da tradurre
+* :ref:`it_kernel_licensing`
 
 Documentazione per gli utenti
 -----------------------------
@@ -90,10 +88,6 @@ vostre modifiche molto più semplice
    doc-guide/index
    kernel-hacking/index
 
-.. warning::
-
-    TODO ancora da tradurre
-
 Documentazione della API del kernel
 -----------------------------------
 
diff --git a/Documentation/translations/it_IT/networking/netdev-FAQ.rst b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
new file mode 100644
index 000000000000..8489ead7cff1
--- /dev/null
+++ b/Documentation/translations/it_IT/networking/netdev-FAQ.rst
@@ -0,0 +1,13 @@
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+
+.. _it_netdev-FAQ:
+
+==========
+netdev FAQ
+==========
+
+.. warning::
+
+    TODO ancora da tradurre
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
new file mode 100644
index 000000000000..776f26732a94
--- /dev/null
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/process/deprecated.rst <deprecated>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_deprecated:
+
+==============================================================================
+Interfacce deprecate, caratteristiche del linguaggio, attributi, e convenzioni
+==============================================================================
+
+In un mondo perfetto, sarebbe possibile prendere tutti gli usi di
+un'interfaccia deprecata e convertirli in quella nuova, e così sarebbe
+possibile rimuovere la vecchia interfaccia in un singolo ciclo di sviluppo.
+Tuttavia, per via delle dimensioni del kernel, la gerarchia dei manutentori e
+le tempistiche, non è sempre possibile fare questo tipo di conversione tutta
+in una volta. Questo significa che nuove istanze di una vecchia interfaccia
+potrebbero aggiungersi al kernel proprio quando si sta cercando di rimuoverle,
+aumentando così il carico di lavoro. Al fine di istruire gli sviluppatori su
+cosa è considerato deprecato (e perché), è stata create la seguente lista a cui
+fare riferimento quando qualcuno propone modifiche che usano cose deprecate.
+
+__deprecated
+------------
+Nonostante questo attributo marchi visibilmente un interfaccia come deprecata,
+`non produce più alcun avviso durante la compilazione
+<https://git.kernel.org/linus/771c035372a036f83353eef46dbb829780330234>`_
+perché uno degli obiettivi del kernel è quello di compilare senza avvisi;
+inoltre, nessuno stava agendo per rimuovere queste interfacce. Nonostante l'uso
+di `__deprecated` in un file d'intestazione sia opportuno per segnare una
+interfaccia come 'vecchia', questa non è una soluzione completa. L'interfaccia
+deve essere rimossa dal kernel, o aggiunta a questo documento per scoraggiarne
+l'uso.
+
+Calcoli codificati negli argomenti di un allocatore
+----------------------------------------------------
+Il calcolo dinamico delle dimensioni (specialmente le moltiplicazioni) non
+dovrebbero essere fatto negli argomenti di funzioni di allocazione di memoria
+(o simili) per via del rischio di overflow. Questo può portare a valori più
+piccoli di quelli che il chiamante si aspettava. L'uso di questo modo di
+allocare può portare ad un overflow della memoria di heap e altri
+malfunzionamenti. (Si fa eccezione per valori numerici per i quali il
+compilatore può generare avvisi circa un potenziale overflow. Tuttavia usare
+i valori numerici come suggerito di seguito è innocuo).
+
+Per esempio, non usate ``count * size`` come argomento::
+
+	foo = kmalloc(count * size, GFP_KERNEL);
+
+Al suo posto, si dovrebbe usare l'allocatore a due argomenti::
+
+	foo = kmalloc_array(count, size, GFP_KERNEL);
+
+Se questo tipo di allocatore non è disponibile, allora dovrebbero essere usate
+le funzioni del tipo *saturate-on-overflow*::
+
+	bar = vmalloc(array_size(count, size));
+
+Un altro tipico caso da evitare è quello di calcolare la dimensione di una
+struttura seguita da un vettore di altre strutture, come nel seguente caso::
+
+	header = kzalloc(sizeof(*header) + count * sizeof(*header->item),
+			 GFP_KERNEL);
+
+Invece, usate la seguente funzione::
+
+	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
+
+Per maggiori dettagli fate riferimento a :c:func:`array_size`,
+:c:func:`array3_size`, e :c:func:`struct_size`, così come la famiglia di
+funzioni :c:func:`check_add_overflow` e :c:func:`check_mul_overflow`.
+
+simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
+----------------------------------------------------------------------
+Le funzioni :c:func:`simple_strtol`, :c:func:`simple_strtoll`,
+:c:func:`simple_strtoul`, e :c:func:`simple_strtoull` ignorano volutamente
+i possibili overflow, e questo può portare il chiamante a generare risultati
+inaspettati. Le rispettive funzioni :c:func:`kstrtol`, :c:func:`kstrtoll`,
+:c:func:`kstrtoul`, e :c:func:`kstrtoull` sono da considerarsi le corrette
+sostitute; tuttavia va notato che queste richiedono che la stringa sia
+terminata con il carattere NUL o quello di nuova riga.
+
+strcpy()
+--------
+La funzione :c:func:`strcpy` non fa controlli agli estremi del buffer
+di destinazione. Questo può portare ad un overflow oltre i limiti del
+buffer e generare svariati tipi di malfunzionamenti. Nonostante l'opzione
+`CONFIG_FORTIFY_SOURCE=y` e svariate opzioni del compilatore aiutano
+a ridurne il rischio, non c'è alcuna buona ragione per continuare ad usare
+questa funzione. La versione sicura da usare è :c:func:`strscpy`.
+
+strncpy() su stringe terminate con NUL
+--------------------------------------
+L'utilizzo di :c:func:`strncpy` non fornisce alcuna garanzia sul fatto che
+il buffer di destinazione verrà terminato con il carattere NUL. Questo
+potrebbe portare a diversi overflow di lettura o altri malfunzionamenti
+causati, appunto, dalla mancanza del terminatore. Questa estende la
+terminazione nel buffer di destinazione quando la stringa d'origine è più
+corta; questo potrebbe portare ad una penalizzazione delle prestazioni per
+chi usa solo stringe terminate. La versione sicura da usare è
+:c:func:`strscpy`. (chi usa :c:func:`strscpy` e necessita di estendere la
+terminazione con NUL deve aggiungere una chiamata a :c:func:`memset`)
+
+Se il chiamate no usa stringhe terminate con NUL, allore :c:func:`strncpy()`
+può continuare ad essere usata, ma i buffer di destinazione devono essere
+marchiati con l'attributo `__nonstring <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
+per evitare avvisi durante la compilazione.
+
+strlcpy()
+---------
+La funzione :c:func:`strlcpy`, per prima cosa, legge interamente il buffer di
+origine, magari leggendo più di quanto verrà effettivamente copiato. Questo
+è inefficiente e può portare a overflow di lettura quando la stringa non è
+terminata con NUL. La versione sicura da usare è :c:func:`strscpy`.
+
+Vettori a dimensione variabile (VLA)
+------------------------------------
+
+Usare VLA sullo stack produce codice molto peggiore rispetto a quando si usano
+vettori a dimensione fissa. Questi `problemi di prestazioni <https://git.kernel.org/linus/02361bc77888>`_,
+tutt'altro che banali, sono già un motivo valido per eliminare i VLA; in
+aggiunta sono anche un problema per la sicurezza. La crescita dinamica di un
+vettore nello stack potrebbe eccedere la memoria rimanente in tale segmento.
+Questo può portare a dei malfunzionamenti, potrebbe sovrascrivere
+dati importanti alla fine dello stack (quando il kernel è compilato senza
+`CONFIG_THREAD_INFO_IN_TASK=y`), o sovrascrivere un pezzo di memoria adiacente
+allo stack (quando il kernel è compilato senza `CONFIG_VMAP_STACK=y`).
diff --git a/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst b/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
index 4ddf5a35b270..1f62da622e26 100644
--- a/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
+++ b/Documentation/translations/it_IT/process/kernel-enforcement-statement.rst
@@ -1,13 +1,175 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/kernel-enforcement-statement.rst <process_statement_kernel>`
-
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_process_statement_kernel:
 
 Applicazione della licenza sul kernel Linux
 ===========================================
 
-.. warning::
+Come sviluppatori del kernel Linux, abbiamo un certo interessa su come il
+nostro software viene usato e su come la sua licenza viene fatta rispettare.
+Il rispetto reciproco degli obblighi di condivisione della GPL-2.0 è
+fondamentale per la sostenibilità di lungo periodo del nostro software e
+della nostra comunità.
+
+Benché ognuno abbia il diritto a far rispettare il diritto d'autore per i
+propri contributi alla nostra comunità, condividiamo l'interesse a far si che
+ogni azione individuale nel far rispettare i propri diritti sia condotta in
+modo da portare beneficio alla comunità e che non abbia, involontariamente,
+impatti negativi sulla salute e la crescita del nostro ecosistema software.
+Al fine di scoraggiare l'esecuzione di azioni inutili, concordiamo che è nel
+migliore interesse della nostra comunità di sviluppo di impegnarci nel
+rispettare i seguenti obblighi nei confronti degli utenti del kernel Linux
+per conto nostro e di qualsiasi successore ai nostri interessi sul diritto
+d'autore:
+
+    Malgrado le clausole di risoluzione della licenza GPL-2.0, abbiamo
+    concordato che è nel migliore interesse della nostra comunità di sviluppo
+    adottare le seguenti disposizioni della GPL-3.0 come permessi aggiuntivi
+    alla nostra licenza nei confronti di qualsiasi affermazione non difensiva
+    di diritti sulla licenza.
+
+	In ogni caso, se cessano tutte le violazioni di questa Licenza, allora
+	la tua licenza da parte di un dato detentore del copyright viene
+	ripristinata (a) in via cautelativa, a meno che e fino a quando il
+	detentore del copyright non cessa esplicitamente e definitivamente
+	la tua licenza, e (b) in via permanente se il detentore del copyright
+	non ti notifica in alcun modo la violazione entro 60 giorni dalla
+	cessazione della licenza.
+
+	Inoltre, la tua licenza da parte di un dato detentore del copyright
+	viene ripristinata in maniera permanente se il detentore del copyright
+	ti notifica la violazione in maniera adeguata, se questa è la prima
+	volta che ricevi una notifica di violazione di questa Licenza (per
+	qualunque Programma) dallo stesso detentore di copyright, e se rimedi
+	alla violazione entro 30 giorni dalla data di ricezione della notifica
+	di violazione.
+
+Fornendo queste garanzie, abbiamo l'intenzione di incoraggiare l'uso del
+software.  Vogliamo che le aziende e le persone usino, modifichino e
+distribuiscano a questo software.  Vogliamo lavorare con gli utenti in modo
+aperto e trasparente per eliminare ogni incertezza circa le nostre aspettative
+sul rispetto o l'ottemperanza alla licenza che possa limitare l'uso del nostro
+software.  Vediamo l'azione legale come ultima spiaggia, da avviare solo quando
+gli altri sforzi della comunità hanno fallito nel risolvere il problema.
+
+Per finire, una volta che un problema di non rispetto della licenza viene
+risolto, speriamo che gli utenti si sentano i benvenuti ad aggregarsi a noi
+nello sviluppo di questo progetto.  Lavorando assieme, saremo più forti.
+
+Ad eccezione deve specificato, parliamo per noi stessi, e non per una qualsiasi
+azienda per la quale lavoriamo oggi, o per cui abbiamo lavorato in passato, o
+lavoreremo in futuro.
+
 
-    TODO ancora da tradurre
+  - Laura Abbott
+  - Bjorn Andersson (Linaro)
+  - Andrea Arcangeli
+  - Neil Armstrong
+  - Jens Axboe
+  - Pablo Neira Ayuso
+  - Khalid Aziz
+  - Ralf Baechle
+  - Felipe Balbi
+  - Arnd Bergmann
+  - Ard Biesheuvel
+  - Tim Bird
+  - Paolo Bonzini
+  - Christian Borntraeger
+  - Mark Brown (Linaro)
+  - Paul Burton
+  - Javier Martinez Canillas
+  - Rob Clark
+  - Kees Cook (Google)
+  - Jonathan Corbet
+  - Dennis Dalessandro
+  - Vivien Didelot (Savoir-faire Linux)
+  - Hans de Goede
+  - Mel Gorman (SUSE)
+  - Sven Eckelmann
+  - Alex Elder (Linaro)
+  - Fabio Estevam
+  - Larry Finger
+  - Bhumika Goyal
+  - Andy Gross
+  - Juergen Gross
+  - Shawn Guo
+  - Ulf Hansson
+  - Stephen Hemminger (Microsoft)
+  - Tejun Heo
+  - Rob Herring
+  - Masami Hiramatsu
+  - Michal Hocko
+  - Simon Horman
+  - Johan Hovold (Hovold Consulting AB)
+  - Christophe JAILLET
+  - Olof Johansson
+  - Lee Jones (Linaro)
+  - Heiner Kallweit
+  - Srinivas Kandagatla
+  - Jan Kara
+  - Shuah Khan (Samsung)
+  - David Kershner
+  - Jaegeuk Kim
+  - Namhyung Kim
+  - Colin Ian King
+  - Jeff Kirsher
+  - Greg Kroah-Hartman (Linux Foundation)
+  - Christian König
+  - Vinod Koul
+  - Krzysztof Kozlowski
+  - Viresh Kumar
+  - Aneesh Kumar K.V
+  - Julia Lawall
+  - Doug Ledford
+  - Chuck Lever (Oracle)
+  - Daniel Lezcano
+  - Shaohua Li
+  - Xin Long
+  - Tony Luck
+  - Catalin Marinas (Arm Ltd)
+  - Mike Marshall
+  - Chris Mason
+  - Paul E. McKenney
+  - Arnaldo Carvalho de Melo
+  - David S. Miller
+  - Ingo Molnar
+  - Kuninori Morimoto
+  - Trond Myklebust
+  - Martin K. Petersen (Oracle)
+  - Borislav Petkov
+  - Jiri Pirko
+  - Josh Poimboeuf
+  - Sebastian Reichel (Collabora)
+  - Guenter Roeck
+  - Joerg Roedel
+  - Leon Romanovsky
+  - Steven Rostedt (VMware)
+  - Frank Rowand
+  - Ivan Safonov
+  - Anna Schumaker
+  - Jes Sorensen
+  - K.Y. Srinivasan
+  - David Sterba (SUSE)
+  - Heiko Stuebner
+  - Jiri Kosina (SUSE)
+  - Willy Tarreau
+  - Dmitry Torokhov
+  - Linus Torvalds
+  - Thierry Reding
+  - Rik van Riel
+  - Luis R. Rodriguez
+  - Geert Uytterhoeven (Glider bvba)
+  - Eduardo Valentin (Amazon.com)
+  - Daniel Vetter
+  - Linus Walleij
+  - Richard Weinberger
+  - Dan Williams
+  - Rafael J. Wysocki
+  - Arvind Yadav
+  - Masahiro Yamada
+  - Wei Yongjun
+  - Lv Zheng
+  - Marc Zyngier (Arm Ltd)
diff --git a/Documentation/translations/it_IT/process/license-rules.rst b/Documentation/translations/it_IT/process/license-rules.rst
new file mode 100644
index 000000000000..91a8794ffd79
--- /dev/null
+++ b/Documentation/translations/it_IT/process/license-rules.rst
@@ -0,0 +1,452 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-ita.rst
+
+:Original: :ref:`Documentation/process/license-rules.rst <kernel_licensing>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
+
+.. _it_kernel_licensing:
+
+Regole per licenziare il kernel Linux
+=====================================
+
+Il kernel Linux viene rilasciato sotto i termini definiti dalla seconda
+versione della licenza *GNU General Public License* (GPL-2.0), di cui una
+copia è disponibile nel file LICENSES/preferred/GPL-2.0; a questo si
+aggiunge eccezione per le chiamate di sistema come descritto in
+LICENSES/exceptions/Linux-syscall-note; tutto ciò è descritto nel file COPYING.
+
+Questo documento fornisce una descrizione su come ogni singolo file sorgente
+debba essere licenziato per far si che sia chiaro e non ambiguo. Questo non
+sostituisce la licenza del kernel.
+
+La licenza descritta nel file COPYING si applica ai sorgenti del kernel nella
+loro interezza, quindi i singoli file sorgenti possono avere diverse licenze ma
+devono essere compatibili con la GPL-2.0::
+
+    GPL-1.0+  :  GNU General Public License v1.0 o successiva
+    GPL-2.0+  :  GNU General Public License v2.0 o successiva
+    LGPL-2.0  :  GNU Library General Public License v2
+    LGPL-2.0+ :  GNU Library General Public License v2 o successiva
+    LGPL-2.1  :  GNU Lesser General Public License v2.1
+    LGPL-2.1+ :  GNU Lesser General Public License v2.1 o successiva
+
+A parte questo, i singolo file possono essere forniti con una doppia licenza,
+per esempio con una delle varianti compatibili della GPL e alternativamente con
+una licenza permissiva come BSD, MIT eccetera.
+
+I file d'intestazione per l'API verso lo spazio utente (UAPI) descrivono
+le interfacce usate dai programmi, e per questo sono un caso speciale.
+Secondo le note nel file COPYING, le chiamate di sistema sono un chiaro
+confine oltre il quale non si estendono i requisiti della GPL per quei
+programmi che le usano per comunicare con il kernel.  Dato che i file
+d'intestazione UAPI devono poter essere inclusi nei sorgenti di un
+qualsiasi programma eseguibile sul kernel Linux, questi meritano
+un'eccezione documentata da una clausola speciale.
+
+Il modo più comune per indicare la licenza dei file sorgenti è quello di
+aggiungere il corrispondente blocco di testo come commento in testa a detto
+file.  Per via della formattazione, dei refusi, eccetera, questi blocchi di
+testo sono difficili da identificare dagli strumenti usati per verificare il
+rispetto delle licenze.
+
+Un'alternativa ai blocchi di testo è data dall'uso degli identificatori
+*Software Package Data Exchange* (SPDX) in ogni file sorgente.  Gli
+identificatori di licenza SPDX sono analizzabili dalle macchine e sono precisi
+simboli stenografici che identificano la licenza sotto la quale viene
+licenziato il file che lo include.  Gli identificatori di licenza SPDX sono
+gestiti del gruppo di lavoro SPDX presso la Linux Foundation e sono stati
+concordati fra i soci nell'industria, gli sviluppatori di strumenti, e i
+rispettivi gruppi legali. Per maggiori informazioni, consultate
+https://spdx.org/
+
+Il kernel Linux richiede un preciso identificatore SPDX in tutti i file
+sorgenti.  Gli identificatori validi verranno spiegati nella sezione
+`Identificatori di licenza`_ e sono stati copiati dalla lista ufficiale di
+licenze SPDX assieme al rispettivo testo come mostrato in
+https://spdx.org/licenses/.
+
+Sintassi degli identificatori di licenza
+----------------------------------------
+
+1. Posizionamento:
+
+   L'identificativo di licenza SPDX dev'essere posizionato come prima riga
+   possibile di un file che possa contenere commenti.  Per la maggior parte
+   dei file questa è la prima riga, fanno eccezione gli script che richiedono
+   come prima riga '#!PATH_TO_INTERPRETER'.  Per questi script l'identificativo
+   SPDX finisce nella seconda riga.
+
+|
+
+2. Stile:
+
+   L'identificativo di licenza SPDX viene aggiunto sotto forma di commento.
+   Lo stile del commento dipende dal tipo di file::
+
+      sorgenti C:	// SPDX-License-Identifier: <SPDX License Expression>
+      intestazioni C:	/* SPDX-License-Identifier: <SPDX License Expression> */
+      ASM:	/* SPDX-License-Identifier: <SPDX License Expression> */
+      scripts:	# SPDX-License-Identifier: <SPDX License Expression>
+      .rst:	.. SPDX-License-Identifier: <SPDX License Expression>
+      .dts{i}:	// SPDX-License-Identifier: <SPDX License Expression>
+
+   Se un particolare programma non dovesse riuscire a gestire lo stile
+   principale per i commenti, allora dev'essere usato il meccanismo accettato
+   dal programma.  Questo è il motivo per cui si ha "/\* \*/" nei file
+   d'intestazione C.  Notammo che 'ld' falliva nell'analizzare i commenti del
+   C++ nei file .lds che venivano prodotti.  Oggi questo è stato corretto,
+   ma ci sono in giro ancora vecchi programmi che non sono in grado di
+   gestire lo stile dei commenti del C++.
+
+|
+
+3. Sintassi:
+
+   Una <espressione di licenza SPDX> può essere scritta usando l'identificatore
+   SPDX della licenza come indicato nella lista di licenze SPDX, oppure la
+   combinazione di due identificatori SPDX separati da "WITH" per i casi
+   eccezionali. Quando si usano più licenze l'espressione viene formata da
+   sottoespressioni separate dalle parole chiave "AND", "OR" e racchiuse fra
+   parentesi tonde "(", ")".
+
+   Gli identificativi di licenza per licenze come la [L]GPL che si avvalgono
+   dell'opzione 'o successive' si formano aggiungendo alla fine il simbolo "+"
+   per indicare l'opzione 'o successive'.::
+
+      // SPDX-License-Identifier: GPL-2.0+
+      // SPDX-License-Identifier: LGPL-2.1+
+
+   WITH dovrebbe essere usato quando sono necessarie delle modifiche alla
+   licenza.  Per esempio, la UAPI del kernel linux usa l'espressione::
+
+      // SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+      // SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note
+
+   Altri esempi di usi di WITH all'interno del kernel sono::
+
+      // SPDX-License-Identifier: GPL-2.0 WITH mif-exception
+      // SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Le eccezioni si possono usare solo in combinazione con identificatori di
+   licenza. Gli identificatori di licenza riconosciuti sono elencati nei
+   corrispondenti file d'eccezione. Per maggiori dettagli consultate
+   `Eccezioni`_ nel capitolo `Identificatori di licenza`_
+
+   La parola chiave OR dovrebbe essere usata solo quando si usa una doppia
+   licenza e solo una dev'essere scelta.  Per esempio, alcuni file dtsi sono
+   disponibili con doppia licenza::
+
+      // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+
+   Esempi dal kernel di espressioni per file licenziati con doppia licenza
+   sono::
+
+      // SPDX-License-Identifier: GPL-2.0 OR MIT
+      // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+      // SPDX-License-Identifier: GPL-2.0 OR Apache-2.0
+      // SPDX-License-Identifier: GPL-2.0 OR MPL-1.1
+      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR MIT
+      // SPDX-License-Identifier: GPL-1.0+ OR BSD-3-Clause OR OpenSSL
+
+   La parola chiave AND dovrebbe essere usata quando i termini di più licenze
+   si applicano ad un file. Per esempio, quando il codice viene preso da
+   un altro progetto il quale da i permessi per aggiungerlo nel kernel ma
+   richiede che i termini originali della licenza rimangano intatti::
+
+      // SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) AND MIT
+
+   Di seguito, un altro esempio dove entrambe i termini di licenza devono
+   essere rispettati::
+
+      // SPDX-License-Identifier: GPL-1.0+ AND LGPL-2.1+
+
+Identificatori di licenza
+-------------------------
+
+Le licenze attualmente in uso, così come le licenze aggiunte al kernel, possono
+essere categorizzate in:
+
+1. _`Licenze raccomandate`:
+
+   Ovunque possibile le licenze qui indicate dovrebbero essere usate perché
+   pienamente compatibili e molto usate.  Queste licenze sono disponibile nei
+   sorgenti del kernel, nella cartella::
+
+     LICENSES/preferred/
+
+   I file in questa cartella contengono il testo completo della licenza e i
+   `Metatag`_.  Il nome di questi file è lo stesso usato come identificatore
+   di licenza SPDX e che deve essere usato nei file sorgenti.
+
+   Esempi::
+
+     LICENSES/preferred/GPL-2.0
+
+   Contiene il testo della seconda versione della licenza GPL e i metatag
+   necessari::
+
+     LICENSES/preferred/MIT
+
+   Contiene il testo della licenza MIT e i metatag necessari.
+
+   _`Metatag`:
+
+   I seguenti metatag devono essere presenti in un file di licenza:
+
+   - Valid-License-Identifier:
+
+     Una o più righe che dichiarano quali identificatori di licenza sono validi
+     all'interno del progetto per far riferimento alla licenza in questione.
+     Solitamente, questo è un unico identificatore valido, ma per esempio le
+     licenze che permettono l'opzione 'o successive' hanno due identificatori
+     validi.
+
+   - SPDX-URL:
+
+     L'URL della pagina SPDX che contiene informazioni aggiuntive riguardanti
+     la licenza.
+
+   - Usage-Guidance:
+
+     Testo in formato libero per dare suggerimenti agli utenti. Il testo deve
+     includere degli esempi su come usare gli identificatori di licenza SPDX
+     in un file sorgente in conformità con le linea guida in
+     `Sintassi degli identificatori di licenza`_.
+
+   - License-Text:
+
+     Tutto il testo che compare dopo questa etichetta viene trattato
+     come se fosse parte del testo originale della licenza.
+
+   Esempi::
+
+      Valid-License-Identifier: GPL-2.0
+      Valid-License-Identifier: GPL-2.0+
+      SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+      Usage-Guide:
+        To use this license in source code, put one of the following SPDX
+	tag/value pairs into a comment according to the placement
+	guidelines in the licensing rules documentation.
+	For 'GNU General Public License (GPL) version 2 only' use:
+	  SPDX-License-Identifier: GPL-2.0
+	For 'GNU General Public License (GPL) version 2 or any later version' use:
+	  SPDX-License-Identifier: GPL-2.0+
+      License-Text:
+        Full license text
+
+   ::
+
+      SPDX-License-Identifier: MIT
+      SPDX-URL: https://spdx.org/licenses/MIT.html
+      Usage-Guide:
+	To use this license in source code, put the following SPDX
+	tag/value pair into a comment according to the placement
+	guidelines in the licensing rules documentation.
+	  SPDX-License-Identifier: MIT
+      License-Text:
+        Full license text
+
+|
+
+2. Licenze non raccomandate:
+
+   Questo tipo di licenze dovrebbero essere usate solo per codice già esistente
+   o quando si prende codice da altri progetti.  Le licenze sono disponibili
+   nei sorgenti del kernel nella cartella::
+
+     LICENSES/other/
+
+   I file in questa cartella contengono il testo completo della licenza e i
+   `Metatag`_.  Il nome di questi file è lo stesso usato come identificatore
+   di licenza SPDX e che deve essere usato nei file sorgenti.
+
+   Esempi::
+
+     LICENSES/other/ISC
+
+   Contiene il testo della licenza Internet System Consortium e i suoi
+   metatag::
+
+     LICENSES/other/ZLib
+
+   Contiene il testo della licenza ZLIB e i suoi metatag.
+
+   Metatag:
+
+   I metatag necessari per le 'altre' ('other') licenze sono gli stessi
+   di usati per le `Licenze raccomandate`_.
+
+   Esempio del formato del file::
+
+      Valid-License-Identifier: ISC
+      SPDX-URL: https://spdx.org/licenses/ISC.html
+      Usage-Guide:
+        Usage of this license in the kernel for new code is discouraged
+        and it should solely be used for importing code from an already
+        existing project.
+        To use this license in source code, put the following SPDX
+        tag/value pair into a comment according to the placement
+        guidelines in the licensing rules documentation.
+          SPDX-License-Identifier: ISC
+      License-Text:
+        Full license text
+
+|
+
+3. _`Eccezioni`:
+
+   Alcune licenze possono essere corrette con delle eccezioni che forniscono
+   diritti aggiuntivi.  Queste eccezioni sono disponibili nei sorgenti del
+   kernel nella cartella::
+
+     LICENSES/exceptions/
+
+   I file in questa cartella contengono il testo completo dell'eccezione e i
+   `Metatag per le eccezioni`_.
+
+   Esempi::
+
+      LICENSES/exceptions/Linux-syscall-note
+
+   Contiene la descrizione dell'eccezione per le chiamate di sistema Linux
+   così come documentato nel file COPYING del kernel Linux; questo viene usato
+   per i file d'intestazione per la UAPI.  Per esempio
+   /\* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note \*/::
+
+      LICENSES/exceptions/GCC-exception-2.0
+
+   Contiene la 'eccezione di linking' che permette di collegare qualsiasi
+   binario, indipendentemente dalla sua licenza, con un compilato il cui file
+   sorgente è marchiato con questa eccezione. Questo è necessario per creare
+   eseguibili dai sorgenti che non sono compatibili con la GPL.
+
+   _`Metatag per le eccezioni`:
+
+   Un file contenente un'eccezione deve avere i seguenti metatag:
+
+   - SPDX-Exception-Identifier:
+
+     Un identificatore d'eccezione che possa essere usato in combinazione con
+     un identificatore di licenza SPDX.
+
+   - SPDX-URL:
+
+     L'URL della pagina SPDX che contiene informazioni aggiuntive riguardanti
+     l'eccezione.
+
+   - SPDX-Licenses:
+
+     Una lista di licenze SPDX separate da virgola, che possono essere usate
+     con l'eccezione.
+
+   - Usage-Guidance:
+
+     Testo in formato libero per dare suggerimenti agli utenti. Il testo deve
+     includere degli esempi su come usare gli identificatori di licenza SPDX
+     in un file sorgente in conformità con le linea guida in
+     `Sintassi degli identificatori di licenza`_.
+
+   - Exception-Text:
+
+     Tutto il testo che compare dopo questa etichetta viene trattato
+     come se fosse parte del testo originale della licenza.
+
+   Esempi::
+
+      SPDX-Exception-Identifier: Linux-syscall-note
+      SPDX-URL: https://spdx.org/licenses/Linux-syscall-note.html
+      SPDX-Licenses: GPL-2.0, GPL-2.0+, GPL-1.0+, LGPL-2.0, LGPL-2.0+, LGPL-2.1, LGPL-2.1+
+      Usage-Guidance:
+        This exception is used together with one of the above SPDX-Licenses
+	to mark user-space API (uapi) header files so they can be included
+	into non GPL compliant user-space application code.
+        To use this exception add it with the keyword WITH to one of the
+	identifiers in the SPDX-Licenses tag:
+	  SPDX-License-Identifier: <SPDX-License> WITH Linux-syscall-note
+      Exception-Text:
+        Full exception text
+
+   ::
+
+      SPDX-Exception-Identifier: GCC-exception-2.0
+      SPDX-URL: https://spdx.org/licenses/GCC-exception-2.0.html
+      SPDX-Licenses: GPL-2.0, GPL-2.0+
+      Usage-Guidance:
+        The "GCC Runtime Library exception 2.0" is used together with one
+	of the above SPDX-Licenses for code imported from the GCC runtime
+	library.
+        To use this exception add it with the keyword WITH to one of the
+	identifiers in the SPDX-Licenses tag:
+	  SPDX-License-Identifier: <SPDX-License> WITH GCC-exception-2.0
+      Exception-Text:
+        Full exception text
+
+Per ogni identificatore di licenza SPDX e per le eccezioni dev'esserci un file
+nella sotto-cartella LICENSES.  Questo è necessario per permettere agli
+strumenti di effettuare verifiche (come checkpatch.pl), per avere le licenze
+disponibili per la lettura e per estrarre i diritti dai sorgenti, così come
+raccomandato da diverse organizzazioni FOSS, per esempio l'`iniziativa FSFE
+REUSE <https://reuse.software/>`_.
+
+_`MODULE_LICENSE`
+-----------------
+
+   I moduli del kernel necessitano di un'etichetta MODULE_LICENSE(). Questa
+   etichetta non sostituisce le informazioni sulla licenza del codice sorgente
+   (SPDX-License-Identifier) né fornisce informazioni che esprimono o
+   determinano l'esatta licenza sotto la quale viene rilasciato.
+
+   Il solo scopo di questa etichetta è quello di fornire sufficienti
+   informazioni al caricatore di moduli del kernel, o agli strumenti in spazio
+   utente, per capire se il modulo è libero o proprietario.
+
+   Le stringe di licenza valide per MODULE_LICENSE() sono:
+
+    ============================= =============================================
+    "GPL"			  Il modulo è licenziato con la GPL versione 2.
+				  Questo non fa distinzione fra GPL'2.0-only o
+				  GPL-2.0-or-later. L'esatta licenza può essere
+				  determinata solo leggendo i corrispondenti
+				  file sorgenti.
+
+    "GPL v2"			  Stesso significato di "GPL". Esiste per
+				  motivi storici.
+
+    "GPL and additional rights"   Questa è una variante che esiste per motivi
+				  storici che indica che i sorgenti di un
+				  modulo sono rilasciati sotto una variante
+				  della licenza GPL v2 e quella MIT. Per favore
+				  non utilizzatela per codice nuovo.
+
+    "Dual MIT/GPL"		  Questo è il modo corretto per esprimere il
+				  il fatto che il modulo è rilasciato con
+				  doppia licenza a scelta fra: una variante
+				  della GPL v2 o la licenza MIT.
+
+    "Dual BSD/GPL"		  Questo modulo è rilasciato con doppia licenza
+				  a scelta fra: una variante della GPL v2 o la
+				  licenza BSD. La variante esatta della licenza
+				  BSD può essere determinata solo attraverso i
+				  corrispondenti file sorgenti.
+
+    "Dual MPL/GPL"		  Questo modulo è rilasciato con doppia licenza
+				  a scelta fra: una variante della GPL v2 o la
+				  Mozilla Public License (MPL). La variante
+				  esatta della licenza MPL può essere
+				  determinata solo attraverso i corrispondenti
+				  file sorgenti.
+
+    "Proprietary"		  Questo modulo è rilasciato con licenza
+				  proprietaria. Questa stringa è solo per i
+				  moduli proprietari di terze parti e non può
+				  essere usata per quelli che risiedono nei
+				  sorgenti del kernel. I moduli etichettati in
+				  questo modo stanno contaminando il kernel e
+				  gli viene assegnato un flag 'P'; quando
+				  vengono caricati, il caricatore di moduli del
+				  kernel si rifiuterà di collegare questi
+				  moduli ai simboli che sono stati esportati
+				  con EXPORT_SYMBOL_GPL().
+
+    ============================= =============================================
diff --git a/Documentation/translations/it_IT/process/stable-kernel-rules.rst b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
index 6fa5ce9c3572..48e88e5ad2c5 100644
--- a/Documentation/translations/it_IT/process/stable-kernel-rules.rst
+++ b/Documentation/translations/it_IT/process/stable-kernel-rules.rst
@@ -1,12 +1,202 @@
 .. include:: ../disclaimer-ita.rst
 
 :Original: :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`
+:Translator: Federico Vaga <federico.vaga@vaga.pv.it>
 
 .. _it_stable_kernel_rules:
 
 Tutto quello che volevate sapere sui rilasci -stable di Linux
 ==============================================================
 
-.. warning::
+Regole sul tipo di patch che vengono o non vengono accettate nei sorgenti
+"-stable":
 
-    TODO ancora da tradurre
+ - Ovviamente dev'essere corretta e verificata.
+ - Non dev'essere più grande di 100 righe, incluso il contesto.
+ - Deve correggere una cosa sola.
+ - Deve correggere un baco vero che sta disturbando gli utenti (non cose del
+   tipo "Questo potrebbe essere un problema ...").
+ - Deve correggere un problema di compilazione (ma non per cose già segnate
+   con CONFIG_BROKEN), un kernel oops, un blocco, una corruzione di dati,
+   un vero problema di sicurezza, o problemi del tipo "oh, questo non va bene".
+   In pratica, qualcosa di critico.
+ - Problemi importanti riportati dagli utenti di una distribuzione potrebbero
+   essere considerati se correggono importanti problemi di prestazioni o di
+   interattività.  Dato che questi problemi non sono così ovvi e la loro
+   correzione ha un'alta probabilità d'introdurre una regressione, dovrebbero
+   essere sottomessi solo dal manutentore della distribuzione includendo un
+   link, se esiste, ad un rapporto su bugzilla, e informazioni aggiuntive
+   sull'impatto che ha sugli utenti.
+ - Non deve correggere problemi relativi a una "teorica sezione critica",
+   a meno che non venga fornita anche una spiegazione su come questa si
+   possa verificare.
+ - Non deve includere alcuna correzione "banale" (correzioni grammaticali,
+   pulizia dagli spazi bianchi, eccetera).
+ - Deve rispettare le regole scritte in
+   :ref:`Documentation/translation/it_IT/process/submitting-patches.rst <it_submittingpatches>`
+ - Questa patch o una equivalente deve esistere già nei sorgenti principali di
+   Linux
+
+
+Procedura per sottomettere patch per i sorgenti -stable
+-------------------------------------------------------
+
+ - Se la patch contiene modifiche a dei file nelle cartelle net/ o drivers/net,
+   allora seguite le linee guida descritte in
+   :ref:`Documentation/translation/it_IT/networking/netdev-FAQ.rst <it_netdev-FAQ>`;
+   ma solo dopo aver verificato al seguente indirizzo che la patch non sia
+   già in coda:
+   https://patchwork.ozlabs.org/bundle/davem/stable/?series=&submitter=&state=*&q=&archive=
+ - Una patch di sicurezza non dovrebbero essere gestite (solamente) dal processo
+   di revisione -stable, ma dovrebbe seguire le procedure descritte in
+   :ref:`Documentation/translations/it_IT/admin-guide/security-bugs.rst <it_securitybugs>`.
+
+
+Per tutte le altre sottomissioni, scegliere una delle seguenti procedure
+------------------------------------------------------------------------
+
+.. _it_option_1:
+
+Opzione 1
+*********
+
+Per far sì che una patch venga automaticamente inclusa nei sorgenti stabili,
+aggiungete l'etichetta
+
+.. code-block:: none
+
+     Cc: stable@vger.kernel.org
+
+nell'area dedicata alla firme. Una volta che la patch è stata inclusa, verrà
+applicata anche sui sorgenti stabili senza che l'autore o il manutentore
+del sottosistema debba fare qualcosa.
+
+.. _it_option_2:
+
+Opzione 2
+*********
+
+Dopo che la patch è stata inclusa nei sorgenti Linux, inviate una mail a
+stable@vger.kernel.org includendo: il titolo della patch, l'identificativo
+del commit, il perché pensate che debba essere applicata, e in quale versione
+del kernel la vorreste vedere.
+
+.. _it_option_3:
+
+Opzione 3
+*********
+
+Inviata la patch, dopo aver verificato che rispetta le regole descritte in
+precedenza, a stable@vger.kernel.org.  Dovete annotare nel changelog
+l'identificativo del commit nei sorgenti principali, così come la versione
+del kernel nel quale vorreste vedere la patch.
+
+L':ref:`it_option_1` è fortemente raccomandata; è il modo più facile e usato.
+L':ref:`it_option_2` e l':ref:`it_option_3` sono più utili quando, al momento
+dell'inclusione dei sorgenti principali, si ritiene che non debbano essere
+incluse anche in quelli stabili (per esempio, perché si crede che si dovrebbero
+fare più verifiche per eventuali regressioni). L':ref:`it_option_3` è
+particolarmente utile se la patch ha bisogno di qualche modifica per essere
+applicata ad un kernel più vecchio (per esempio, perché nel frattempo l'API è
+cambiata).
+
+Notate che per l':ref:`it_option_3`, se la patch è diversa da quella nei
+sorgenti principali (per esempio perché è stato necessario un lavoro di
+adattamento) allora dev'essere ben documentata e giustificata nella descrizione
+della patch.
+
+L'identificativo del commit nei sorgenti principali dev'essere indicato sopra
+al messaggio della patch, così:
+
+.. code-block:: none
+
+    commit <sha1> upstream.
+
+In aggiunta, alcune patch inviate attraverso l':ref:`it_option_1` potrebbero
+dipendere da altre che devo essere incluse. Questa situazione può essere
+indicata nel seguente modo nell'area dedicata alle firme:
+
+.. code-block:: none
+
+     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
+     Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
+     Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
+     Cc: <stable@vger.kernel.org> # 3.3.x
+     Signed-off-by: Ingo Molnar <mingo@elte.hu>
+
+La sequenza di etichette ha il seguente significato:
+
+.. code-block:: none
+
+     git cherry-pick a1f84a3
+     git cherry-pick 1b9508f
+     git cherry-pick fd21073
+     git cherry-pick <this commit>
+
+Inoltre, alcune patch potrebbero avere dei requisiti circa la versione del
+kernel. Questo può essere indicato usando il seguente formato nell'area
+dedicata alle firme:
+
+.. code-block:: none
+
+     Cc: <stable@vger.kernel.org> # 3.3.x
+
+L'etichetta ha il seguente significato:
+
+.. code-block:: none
+
+     git cherry-pick <this commit>
+
+per ogni sorgente "-stable" che inizia con la versione indicata.
+
+Dopo la sottomissione:
+
+ - Il mittente riceverà un ACK quando la patch è stata accettata e messa in
+   coda, oppure un NAK se la patch è stata rigettata.  A seconda degli impegni
+   degli sviluppatori, questa risposta potrebbe richiedere alcuni giorni.
+ - Se accettata, la patch verrà aggiunta alla coda -stable per essere
+   revisionata dal altri sviluppatori e dal principale manutentore del
+   sottosistema.
+
+
+Ciclo di una revisione
+----------------------
+
+ - Quando i manutentori -stable decidono di fare un ciclo di revisione, le
+   patch vengono mandate al comitato per la revisione, ai manutentori soggetti
+   alle modifiche delle patch (a meno che il mittente non sia anche il
+   manutentore di quell'area del kernel) e in CC: alla lista di discussione
+   linux-kernel.
+ - La commissione per la revisione ha 48 ore per dare il proprio ACK o NACK
+   alle patch.
+ - Se una patch viene rigettata da un membro della commissione, o un membro
+   della lista linux-kernel obietta la bontà della patch, sollevando problemi
+   che i manutentori ed i membri non avevano compreso, allora la patch verrà
+   rimossa dalla coda.
+ - Alla fine del ciclo di revisione tutte le patch che hanno ricevuto l'ACK
+   verranno aggiunte per il prossimo rilascio -stable, e successivamente
+   questo nuovo rilascio verrà fatto.
+ - Le patch di sicurezza verranno accettate nei sorgenti -stable direttamente
+   dalla squadra per la sicurezza del kernel, e non passerà per il normale
+   ciclo di revisione. Contattate la suddetta squadra per maggiori dettagli
+   su questa procedura.
+
+Sorgenti
+--------
+
+ - La coda delle patch, sia quelle già applicate che in fase di revisione,
+   possono essere trovate al seguente indirizzo:
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
+
+ - Il rilascio definitivo, e marchiato, di tutti i kernel stabili può essere
+   trovato in rami distinti per versione al seguente indirizzo:
+
+	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
+
+
+Comitato per la revisione
+-------------------------
+
+ - Questo comitato è fatto di sviluppatori del kernel che si sono offerti
+   volontari per questo lavoro, e pochi altri che non sono proprio volontari.
-- 
2.20.1


