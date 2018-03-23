Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+im+JhNIHbohRiUE/vD19BtVgkS7lYIxtiCrzYSqgvOxdglHstv8uFg+MOFhlyH+zgdGpx
ARC-Seal: i=1; a=rsa-sha256; t=1521802838; cv=none;
        d=google.com; s=arc-20160816;
        b=i5VwoMtyijXX0aSJvLXBicSAZ+RAYKk/VFJH75b3fj3c3GhDLXtU0NPm4LbZqBU0BU
         tUBi6d7awITA4akPMdZ+RnDr/qzOBrNyGK2mQj+lHdwNuTU/2EYATCeo24NIEQy7xwwS
         QFavjg6WXQtrCvs7v6d+iAn9it0YvW9I80e+XjEOwKQ4ptsZObiWU1NegtUhLSlR2mBj
         M7+MlO0pYNwQUT4rWA26IrEjzTo/Ak39bTbz34LhvTw6jdjzA7KAQBiCVH6IE+4DRWNw
         0xNJUqigP6NOA2nQvOzKsJm9Ekrc/4S6gcb4gTsaQe69ZaAmSSfK3n6Iv27uYn5760RA
         WjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qKR0HU8VYDBXm9UgRCb4ENJSygL2FGy40HUaSUBuhLo=;
        b=CJWiHH1p3oUCtW2Jrr6mBEAOsWssTx9Q8s94mxuHY2YxrmOTPLrPH3o7SntMCfQn0O
         Gf6jIVbGQuSBZdVEsRl3i1sMIAEMdqHJt8Df6yBFA8YkWt6kS0kqCjC0xChtZ9dpq8HD
         S2WHzyYYUvj31DOYcjj2H2dfYOIpciPx7fxMddYESUb2A30yDU8RUny1dmt0WWEjPUzJ
         sgEjkj8sPzZpGnJtZ+4xln6mOAMJ0ypucb0O/gtu1yoIcvzEt1Xbs2NPBmvZ7iiG6ROA
         M59zRa8/5m1d7CgUr75cV7U5YYVR99VENjMDFGeo7HBfYhpdCGCK+0KVgEAVZt4gOIyw
         8/mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 07/11] MAINTAINERS: Add myself as the I3C subsystem maintainer
Date: Fri, 23 Mar 2018 12:00:16 +0100
Message-Id: <20180323110020.19080-8-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180323110020.19080-1-boris.brezillon@bootlin.com>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725933444719555?=
X-GMAIL-MSGID: =?utf-8?q?1595725933444719555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Create an entry for the I3C subsystem and mark it as maintained by me.
There's no official git repository, patchwork instance, mailing list or
website yet, but this will be added after the subsystem has been
accepted.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3bdc260e36b7..f323864131ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6669,6 +6669,15 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/i2c-stub.c
 
+I3C SUBSYSTEM
+M:	Boris Brezillon <boris.brezillon@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/
+F:	Documentation/driver-api/i3c
+F:	drivers/i3c/
+F:	include/linux/i3c/
+F:	include/dt-bindings/i3c/
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.14.1
