Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDB7C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89A42087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="AB6Kl1F8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbfASWOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:14:34 -0500
Received: from mx.kolabnow.com ([95.128.36.42]:32064 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfASWOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:14:33 -0500
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 51D9C4096E;
        Sat, 19 Jan 2019 23:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1547936069; x=1549750470;
         bh=zHFnMDyZIxNoE+ed2rs2uO2cxPB4wAjjtdRPvpo3nUw=; b=AB6Kl1F8USEV
        ZJ9xUrsj7tbBB8TzTkFjimQxHTQ0bWD+qDo4vj8D6phkvIwW62pwXuhunSllGJmb
        egw46zOSaeS44GzYfyJ7Y+Ew/WW7kyQFp6KP9AofUFsS9oP4LZz7bYs7izqdvxyc
        L/VBMI71ECZ0HKOSmjl0PHSw93YCsJdvGB/OpXBQS2a20bNPfXcKSURms0RcNX8p
        NrUyYKYdweu156OR+LvY8wwj7Mzp1bZS//IQUkOrsB5Ax9WwjiG/1ggQDtuSDW89
        Oye/Be3if0FcrvOSJgHdTemFXCAQtLv08kjpwsk5NH9gdYqTq37hg+UkFwrDI5Hg
        zjr+bsZXRYbumF701ayPC65b1hTHvifM5gqp9hhGrSE/zbV/q8INcrVhf4fO4RwA
        Zv+yCq5yDNhh/+gsz2dzuMMbkOJduorCSx87TmNc4f75KZzn/6ZyG+k5iJbsWQaF
        F2KeDYfHSYtKDhGksMkH6AgQLZE7xhtIT2zi9tGWxu1tZ7bUgd5+EOJgXaMxUgKZ
        4R2FMn0uUMMi1yu6rC9KrVXMUAuys5orjbKUknhJ11FeKmA22VR0NB70lYQ+MAe8
        wwEQbqZXJxTZm2JWyF1+48cuuSxXmyGbYzPsT0EtOmgrUF4VCbiGEZRzDUbmEqBk
        L/XKlvaL6Rm5pkMw72f812Nhb6kncrQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2susRot6k9LE; Sat, 19 Jan 2019 23:14:29 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 9FAC140497;
        Sat, 19 Jan 2019 23:14:29 +0100 (CET)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 2B4A7B55;
        Sat, 19 Jan 2019 23:14:29 +0100 (CET)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:it_IT: documentation alignment
Date:   Sat, 19 Jan 2019 23:14:22 +0100
Message-Id: <20190119221422.3685-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It aligns the italian translation with the latest changes:

ae67ee6c5e1d docs: fix Co-Developed-by docs
3fe5dbfef47e Documentation/process/coding-style.rst: don't use "extern" with function prototypes

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/translations/it_IT/process/coding-style.rst     | 3 +++
 .../translations/it_IT/process/submitting-patches.rst         | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/it_IT/process/coding-style.rst b/Documentation/translations/it_IT/process/coding-style.rst
index 67c6d9ea7257..dfdefb951b89 100644
--- a/Documentation/translations/it_IT/process/coding-style.rst
+++ b/Documentation/translations/it_IT/process/coding-style.rst
@@ -449,6 +449,9 @@ Nonostante questo non sia richiesto dal linguaggio C, in Linux viene preferito
 perché è un modo semplice per aggiungere informazioni importanti per il
 lettore.
 
+Non usate la parola chiave ``extern`` coi prototipi di funzione perché
+rende le righe più lunghe e non è strettamente necessario.
+
 7) Centralizzare il ritorno delle funzioni
 ------------------------------------------
 
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index b6368a45a8e4..2ab9c1401aa1 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -534,7 +534,7 @@ alle persone che vogliono seguire i vostri sorgenti, e quelle che cercano
 dei bachi.
 
 
-12) Quando utilizzare Acked-by:, Cc:, e Co-Developed-by:
+12) Quando utilizzare Acked-by:, Cc:, e Co-developed-by:
 --------------------------------------------------------
 
 L'etichetta Signed-off-by: indica che il firmatario è stato coinvolto nello
@@ -567,7 +567,7 @@ alcunché - ma dovrebbe indicare che la persona ha ricevuto una copia della
 patch.  Questa etichetta documenta che terzi potenzialmente interessati sono
 stati inclusi nella discussione.
 
-L'etichetta Co-Developed-by: indica che la patch è stata scritta dall'autore in
+L'etichetta Co-developed-by: indica che la patch è stata scritta dall'autore in
 collaborazione con un altro sviluppatore.  Qualche volta questo è utile quando
 più persone lavorano sulla stessa patch.  Notate, questa persona deve avere
 nella patch anche una riga Signed-off-by:.
-- 
2.20.1

