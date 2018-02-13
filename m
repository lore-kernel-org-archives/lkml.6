Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513110-2-604837628382336132
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.67', Host='mail-pg0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513109; b=Itg+Jp4vmQagOu+hvoGJB8N6tRpbwhIstkFIazN1z2yzvcK
    cp/XF8+kpbSXNnwqGPxLYj6dON2bSdOgqz98VIpdFTrT4+C3cPrM18sgVUEBgGN6
    DbplcweL/F2BA+nzVyUq/3861zyM200IveVnc/xgpX4WbpT1pvf+bMC2FEqt3oRm
    JS/hZj8uk4RsNNFfmaaC4RfH4RNw9gWz6W7ZwmEN7sPMT8KdwevrcDBCGQmlSRhN
    5hF1ScLL/mHliGXelHyaSMQUqEqLpaw9VKRF5N3BaO9gSGKSxj3G7BDVNvsOeJZE
    XKZlO3JMzCw5whhUl0mdov/Ueks8oVQTiN25xbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513109; bh=sjR19UQyJ2ZTYpZJotf8QSWLtZFpuOScFEDhDaH78JU=; b=O
    ifUclEbIYTjb9pCF9LII82igdpGrnXVV9v5d3Od1pqpHliJItF8to99NQDEcNDb5
    QDPa38Rbr+mm+T9u5ononvRYfl+/xdRNdIUR8rR/S0e36pOHMDdqGSAtsmEJ75vQ
    GDn4I4pYHDV9NX8g2L2bKkRJNq2TFMIEnLkRT/Gqx8S6XjlSNQj0bWUsF7M4/eN1
    Kocad3hoLWt42apk8ia/Aady1ZuHmux1svzZhpzlLpTMeEM4M5XU6AU+bQmtCxp7
    g3OIxQpSQkQ0m/itHtyEr7kT45Ep9QFjUpMed8flYcJSMNvFLaE8E+SjcgGO9Xxb
    danWjN68Gsh+XS4Yz3oZg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aEF+/ORr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zr8hLr+E;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=aEF+/ORr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zr8hLr+E;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224jJwgNszKg1Go8Hpxs3erV7z6rPWooHQ9Zz9Vq8Pz0HMrFHT2eGiToovSrdKr5IJ7zzkx7bg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-arch@vger.kernel.org,
	tglx@linutronix.de,
	jason@lakedaemon.net,
	marc.zyngier@arm.com,
	robh+dt@kernel.org,
	netdev@vger.kernel.org,
	deanbo422@gmail.com,
	devicetree@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	dhowells@redhat.com,
	will.deacon@arm.com,
	daniel.lezcano@linaro.org,
	linux-serial@vger.kernel.org,
	geert.uytterhoeven@gmail.com,
	linus.walleij@linaro.org,
	mark.rutland@arm.com,
	greg@kroah.com,
	ren_guo@c-sky.com,
	rdunlap@infradead.org,
	davem@davemloft.net,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com
Cc: green.hu@gmail.com,
	Vincent Chen <vincentc@andestech.com>
Subject: [PATCH v7 14/37] nds32: IRQ handling
Date: Tue, 13 Feb 2018 17:09:18 +0800
Message-Id: <ffdd80d006a15f572efdad859f332241b5ce2f73.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch includes irq related functions and irqchip_init().

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nds32/include/asm/irqflags.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/nds32/kernel/irq.c           |  9 +++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/nds32/include/asm/irqflags.h
 create mode 100644 arch/nds32/kernel/irq.c

diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
new file mode 100644
index 000000000000..2bfd00f8bc48
--- /dev/null
+++ b/arch/nds32/include/asm/irqflags.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <asm/nds32.h>
+#include <nds32_intrinsic.h>
+
+#define arch_local_irq_disable()	\
+	GIE_DISABLE();
+
+#define arch_local_irq_enable()	\
+	GIE_ENABLE();
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags;
+	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
+	GIE_DISABLE();
+	return flags;
+}
+
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	flags = __nds32__mfsr(NDS32_SR_PSW) & PSW_mskGIE;
+	return flags;
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	if(flags)
+		GIE_ENABLE();
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return !flags;
+}
diff --git a/arch/nds32/kernel/irq.c b/arch/nds32/kernel/irq.c
new file mode 100644
index 000000000000..6ff5a672be27
--- /dev/null
+++ b/arch/nds32/kernel/irq.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <linux/irqchip.h>
+
+void __init init_IRQ(void)
+{
+	irqchip_init();
+}
-- 
2.16.1
