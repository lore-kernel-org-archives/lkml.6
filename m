Return-Path: <green.hu@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-3695236-1518513217-2-3896390033486830682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FROM 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.66', Host='mail-pg0-f66.google.com', Country='US',
  FromHeader='com', MailFrom='com'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: green.hu@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513217; b=FxpZh72f7srWbB5fhPA+ssnScnOkv8U6L0CxK2FUUoW74xH
    prSs9gsJ8+eSZC+RyfLe1gEgZ+E8gnR0C7RaHe9mwVdHC25CWzvXVAvRy40CQRf9
    p6+LUo+Jpo2MtOlMo+hHFst6cvugG/aXYGVijZOr77l3tmICMuLqlXohfkwWZx6a
    QixYQLg7qwH8bQcv2gik2y4QxziDtkR3RpLAb05rKvXkfQTfKgX9WUFFYr2avGGB
    mMK/7QVTivXtieLDPdj7Q/JHpUz65/ELwjJDN30HyAJ7MigqTPSY2oOupZ0zIm74
    eQGeD3RJq5F60KbM78K1KJveuRUFtPWGNZ+sbFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references; s=arctest; t=
    1518513217; bh=YJgRvMpBMRbtogvQfqSpBg4v/w4QgSrJtehAAr2zUMw=; b=J
    uHYKZxsjx4oMDBZLtu6ypRDR3clwhaqYrfPZUAU+m4xd/rC2CeKSJMFrxsSp0C/o
    3/3JOt4N2nAuMT+ZXRhVTzuMj5z+CFSE+sMROHsNkd6YmYcVpaeBVda5wwN+SsAa
    0tJffqydtEyNhzyU8qJ8VvRkgUfP096R5tfBHnR3Cs98mMSOIxANNWPvvQWfkZJy
    5SvrHeYV/UDZqK9oM5EJSiGeBDeEDZA7nggA1So5/KKQ8vkWG94ck3WzI7vP0TEV
    rpXfvHaTLkOHQ67NFrRKs1bvBVI6TWwwf4TXii0BNV+35rDDKLZt3MqsLOhcC6/G
    4CIWexusblcl0At+ugkCw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vy/ppfME x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BEn5WDSH;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vy/ppfME x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=green.hu@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BEn5WDSH;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227N5zHYP4m+ooJLa5FXG1+JtTun58jBAVD8dVWD3nKM/TMxpKq0Yes/0P+R3uJdyqbLbGUXnw==
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
Cc: green.hu@gmail.com
Subject: [PATCH v7 37/37] net: faraday add nds32 support.
Date: Tue, 13 Feb 2018 17:09:41 +0800
Message-Id: <7375613a6c84c31d2dd5c6c1feb3294c2716eb93.1518505384.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
In-Reply-To: <cover.1518505384.git.greentime@andestech.com>
References: <cover.1518505384.git.greentime@andestech.com>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch is used to support nds32 architecture to use these faraday
mac IP.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/faraday/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 040c7f163325..0fb8df656677 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -18,7 +18,8 @@ if NET_VENDOR_FARADAY
 
 config FTMAC100
 	tristate "Faraday FTMAC100 10/100 Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
+	depends on !64BIT || BROKEN
 	select MII
 	---help---
 	  This driver supports the FTMAC100 10/100 Ethernet controller
@@ -27,7 +28,8 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM
+	depends on ARM || NDS32 || COMPILE_TEST
+	depends on !64BIT || BROKEN
 	select PHYLIB
 	---help---
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
-- 
2.16.1
