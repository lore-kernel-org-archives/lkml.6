Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032709AbeE0PHO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:07:14 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:22002 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032592AbeE0PHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:07:13 -0400
X-Spam-Flag: NO
X-Spam-Score: -1
From: Federico Vaga <federico.vaga@vaga.pv.it>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH 3/5] doc: add Italian translation skeleton
Date: Sun, 27 May 2018 16:55:58 +0200
Message-Id: <20180527145559.16411-4-federico.vaga@vaga.pv.it>
In-Reply-To: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
References: <20180527145559.16411-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
---
 Documentation/index.rst                            |   8 ++
 .../translations/it_IT/disclaimer-ita.rst          |  11 +++
 Documentation/translations/it_IT/index.rst         | 101 +++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 Documentation/translations/it_IT/disclaimer-ita.rst
 create mode 100644 Documentation/translations/it_IT/index.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 8f11fccb9744..e6075bdacbbd 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,6 +113,14 @@ Japanese translations
 
    translations/ja_JP/index
 
+Italian translations
+---------------------
+
+.. toctree::
+   :maxdepth: 1
+
+   translations/it_IT/index
+
 Indices and tables
 ==================
 
diff --git a/Documentation/translations/it_IT/disclaimer-ita.rst b/Documentation/translations/it_IT/disclaimer-ita.rst
new file mode 100644
index 000000000000..0c439117ed7f
--- /dev/null
+++ b/Documentation/translations/it_IT/disclaimer-ita.rst
@@ -0,0 +1,11 @@
+:orphan:
+
+.. note::
+   This document is maintained by Federico Vaga <federico.vaga@vaga.pv.it>.
+   If you find any difference between this document and the original file or a
+   problem with the translation, please contact the maintainer of this file.
+
+.. warning::
+   The purpose of this file is to be easier to read and understand for Italian
+   speakers and is not intended as a fork. So, if you have any comments or
+   updates for this file please try to update the original English file first.
diff --git a/Documentation/translations/it_IT/index.rst b/Documentation/translations/it_IT/index.rst
new file mode 100644
index 000000000000..e688c06fd9a4
--- /dev/null
+++ b/Documentation/translations/it_IT/index.rst
@@ -0,0 +1,101 @@
+﻿.. _it_linux_doc:
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
-- 
2.14.3
