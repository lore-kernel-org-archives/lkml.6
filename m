Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932139AbeFEWuL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 18:50:11 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:60842 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeFEWuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 18:50:07 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 5/6] doc: add Italian language skeleton
Date: Wed,  6 Jun 2018 00:49:02 +0200
Message-Id: <20180605224903.9483-6-federico.vaga@vaga.pv.it>
In-Reply-To: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
References: <20180605224903.9483-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/index.rst               |   1 +
 .../translations/it_IT/disclaimer-ita.rst          |  13 +++
 Documentation/translations/it_IT/index.rst         | 112 +++++++++++++++++++++
 MAINTAINERS                                        |   6 ++
 4 files changed, 132 insertions(+)
 create mode 100644 Documentation/translations/it_IT/disclaimer-ita.rst
 create mode 100644 Documentation/translations/it_IT/index.rst

diff --git a/Documentation/translations/index.rst b/Documentation/translations/index.rst
index 4969c58920ef..7f77c52d33aa 100644
--- a/Documentation/translations/index.rst
+++ b/Documentation/translations/index.rst
@@ -8,5 +8,6 @@ Translations
    :maxdepth: 1
 
    zh_CN/index
+   it_IT/index
    ko_KR/index
    ja_JP/index
diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
new file mode 100644
index 000000000000..d68e52de6a5d
--- /dev/null
+++ b/Documentation/translations/it_IT/disclaimer-ita.rst
@@ -0,0 +1,13 @@
+:orphan:
+
+.. note::
+   This document is maintained by Federico Vaga <federico.vaga@vaga.pv.it>.
+   If you find any difference between this document and the original file or a
+   problem with the translation, please contact the maintainer of this file.
+   Following people helped to translate or review:
+   Alessia Mantegazza <amantegazza@vaga.pv.it>
+
+.. warning::
+   The purpose of this file is to be easier to read and understand for Italian
+   speakers and is not intended as a fork. So, if you have any comments or
+   updates for this file please try to update the original English file first.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
new file mode 100644
index 000000000000..7613a9f9e6f9
--- /dev/null
+++ b/Documentation/translations/it_IT/index.rst
@@ -0,0 +1,112 @@
+.. _it_linux_doc:
+
+===================
+Traduzione italiana
+===================
+
+L'obiettivo di questa traduzione è di rendere più facile la lettura e
+la comprensione per chi preferisce leggere in lingua italiana.
+Tenete presente che la documentazione di riferimento rimane comunque
+quella in lingua inglese: :ref:`linux_doc`
+
+Questa traduzione cerca di essere il più fedele possibile all'originale ma
+è ovvio che alcune frasi vadano trasformate: non aspettatevi una traduzione
+letterale. Quando possibile, si eviteranno gli inglesismi ed al loro posto
+verranno utilizzate le corrispettive parole italiane.
+
+Se notate che la traduzione non è più aggiornata potete contattare
+direttamente il manutentore della traduzione italiana.
+
+Se notate che la documentazione contiene errori o dimenticanze, allora
+verificate la documentazione di riferimento in lingua inglese. Se il problema
+è presente anche nella documentazione di riferimento, contattate il suo
+manutentore. Se avete problemi a scrivere in inglese, potete comunque
+riportare il problema al manutentore della traduzione italiana.
+
+Manutentore della traduzione italiana: Federico Vaga <federico.vaga@vaga.pv.it>
+
+La documentazione del kernel Linux
+==================================
+
+Questo è il livello principale della documentazione del kernel in
+lingua italiana. La traduzione è incompleta, noterete degli avvisi
+che vi segnaleranno la mancanza di una traduzione o di un gruppo di
+traduzioni.
+
+Più in generale, la documentazione, come il kernel stesso, sono in
+costante sviluppo; particolarmente vero in quanto stiamo lavorando
+alla riorganizzazione della documentazione in modo più coerente.
+I miglioramenti alla documentazione sono sempre i benvenuti; per cui,
+se vuoi aiutare, iscriviti alla lista di discussione linux-doc presso
+vger.kernel.org.
+
+Documentazione sulla licenza dei sorgenti
+-----------------------------------------
+
+I seguenti documenti descrivono la licenza usata nei sorgenti del kernel Linux
+(GPLv2), come licenziare i singoli file; inoltre troverete i riferimenti al
+testo integrale della licenza.
+
+.. warning::
+
+    TODO ancora da tradurre
+
+Documentazione per gli utenti
+-----------------------------
+
+I seguenti manuali sono scritti per gli *utenti* del kernel - ovvero,
+coloro che cercano di farlo funzionare in modo ottimale su un dato sistema
+
+.. warning::
+
+    TODO ancora da tradurre
+
+Documentazione per gli sviluppatori di applicazioni
+---------------------------------------------------
+
+Il manuale delle API verso lo spazio utente è una collezione di documenti
+che descrivono le interfacce del kernel viste dagli sviluppatori
+di applicazioni.
+
+.. warning::
+
+    TODO ancora da tradurre
+
+
+Introduzione allo sviluppo del kernel
+-------------------------------------
+
+Questi manuali contengono informazioni su come contribuire allo sviluppo
+del kernel.
+Attorno al kernel Linux gira una comunità molto grande con migliaia di
+sviluppatori che contribuiscono ogni anno. Come in ogni grande comunità,
+sapere come le cose vengono fatte renderà il processo di integrazione delle
+vostre modifiche molto più semplice
+
+.. warning::
+
+    TODO ancora da tradurre
+
+Documentazione della API del kernel
+-----------------------------------
+
+Questi manuali forniscono dettagli su come funzionano i sottosistemi del
+kernel dal punto di vista degli sviluppatori del kernel. Molte delle
+informazioni contenute in questi manuali sono prese direttamente dai
+file sorgenti, informazioni aggiuntive vengono aggiunte solo se necessarie
+(o almeno ci proviamo — probabilmente *non* tutto quello che è davvero
+necessario).
+
+.. warning::
+
+    TODO ancora da tradurre
+
+Documentazione specifica per architettura
+-----------------------------------------
+
+Questi manuali forniscono dettagli di programmazione per le diverse
+implementazioni d'architettura.
+
+.. warning::
+
+    TODO ancora da tradurre
diff --git a/MAINTAINERS b/MAINTAINERS
index ca4afd68530c..0ee4ba5b4ca1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4367,6 +4367,12 @@ X:	Documentation/spi
 X:	Documentation/media
 T:	git git://git.lwn.net/linux.git docs-next
 
+DOCUMENTATION/ITALIAN
+M:	Federico Vaga <federico.vaga@vaga.pv.it>
+L:	linux-doc@vger.kernel.org
+S:	Maintained
+F:	Documentation/translations/it_IT
+
 DONGWOON DW9714 LENS VOICE COIL DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.14.4
