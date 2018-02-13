Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513052-2-7798750027017629518
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.67', Host='mail-pg0-f67.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513052; b=HzGncdMzYq8Qfj2PA00YEPwD7TcbBwYU56Mcyem02u0NOb4
    JIZmOAVacLt3zUHVrQ6i04TDX9D49/BnS5I3qGHYi9iXDpdMywhe5hcc7kXmlACs
    tryc1ea7lcdNAe2F3hzEOpFvbrgX+4gxrAYPTBqKeh6hiFs1k+JfuEjm0C8JBtx/
    63nYUZlWDgshJxQaxTi2hDH/j3vVEyHE3XsRjhFjrUBHw1xA6J79RW9km4gEfo3t
    qmXQzbdTC5DRvlPEOnc1XCHLNuX0Mh+uIBBk7f5H7Ua8/bgHhVCgvtjILUGccpXs
    qSZgScJEXI1Kc5lv/UxX7LMMbAz9L1dIjKZZFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513052; bh=3gYNA8/mhR+JQjjCSGOzhD4w5eyIUs+EfNP5nYRS1l4=; b=c
    Rctsop0OW20M/Wd+xe516b1k1PQxcngeH98SgggFANS5m7GMDvdmAuCkURmCsGP/
    5RspLK3EKyMfwrOy6yT4u9ljmR36EVDipgKDsgJt1FxvYLbyRoBZVHiAgUsRnKHb
    VxxD/ej/vZt2ipyNKmNtd8tx0mJaoWcKeiP12IUjTRNoDThvyUiv50Fa7t0aEo6k
    eypfu3MCNqBPmHJYNUyo1TKTX0lespmWZg2cYynlCXP+uYSstJYBHUfbS8IWcUWV
    rmsRLthm7TZuZmSg1CXq0hMfvh/wJ0KvlSHLIuTkoa2JEg68r+UEisc0mrTfA+aa
    O0ehcx1GZgzhl9+w8AcSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FZ6Vfzms x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j5bIHKVv;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FZ6Vfzms x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.67 (mail-pg0-f67.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j5bIHKVv;
    x-ptr=pass x-ptr-helo=mail-pg0-f67.google.com x-ptr-lookup=mail-pg0-f67.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x22782C6P3Q/YDT+PSC8xlPJ+Zj2oy19KzG0773oDNCB78/yGqRut2stWU27U2oQwHfLip8iWjA==
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
Subject: [PATCH v7 02/37] asm-generic/io.h: move ioremap_nocache/ioremap_uc/ioremap_wc/ioremap_wt out of ifndef CONFIG_MMU
Date: Tue, 13 Feb 2018 17:09:06 +0800
Message-Id: <ff404658ececd53f1bf111067c587c4e3eb695af.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It allows some architectures to use this generic macro instead of
defining theirs.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/io.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b4531e3b2120..7c6a39e64749 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -852,7 +852,16 @@ static inline void __iomem *__ioremap(phys_addr_t offset, size_t size,
 }
 #endif
 
+#ifndef iounmap
+#define iounmap iounmap
+
+static inline void iounmap(void __iomem *addr)
+{
+}
+#endif
+#endif /* CONFIG_MMU */
 #ifndef ioremap_nocache
+void __iomem *ioremap(phys_addr_t phys_addr, size_t size);
 #define ioremap_nocache ioremap_nocache
 static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 {
@@ -884,15 +893,6 @@ static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
 }
 #endif
 
-#ifndef iounmap
-#define iounmap iounmap
-
-static inline void iounmap(void __iomem *addr)
-{
-}
-#endif
-#endif /* CONFIG_MMU */
-
 #ifdef CONFIG_HAS_IOPORT_MAP
 #ifndef CONFIG_GENERIC_IOMAP
 #ifndef ioport_map
-- 
2.16.1
