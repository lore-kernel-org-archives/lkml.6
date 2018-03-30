Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4/ZoClTPJfoU3qPr9Wh78TDlSs+dzp8X5/FYW/eES8dhIuNzgc4GO8rVTfQ/ZSvhFwIvjFm
ARC-Seal: i=1; a=rsa-sha256; t=1522396079; cv=none;
        d=google.com; s=arc-20160816;
        b=lKVSBEVlLoxIwbgb5xqB8+b9gJXMr/S5m0S3Ewpk2K+6xDvO2cof9cpiJX0UdxdULQ
         PS1GxelU+D6e+euCW92RflqWCNkUpkNafIodE8Me/D018ajQ6dG9Ep6ilu3yCfDxJpEd
         be3QESsIDa3yAg5eeSIrmWVAkFlOuCOL330DdTrLgKT4ua0HuJpX3/G7NV3/f3ftqxW9
         EvMJRMCzBpLL8fuFlQzdZp94y7M/A7IHtlFi6TTzBODgna5Q1wTPE5TWo5nIs8aHyANv
         ycNPiYV/6PaHrS8PNHcgDtSQDr25I4nVlnVg3w3J9a0F9Yi5QbG5zWRCaojlb03lCBh9
         mxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qKR0HU8VYDBXm9UgRCb4ENJSygL2FGy40HUaSUBuhLo=;
        b=nb3DthDjAjcBcOCqDLV5uKUuu4Yr8R8I25K/BRgj1WAj/RFOKSPDCqj+jegy/6co/N
         rf06tvTYeb/Bwt/XTM+0Y0zH8J7aJ9zhgqVHbv86NGIUlcB0BynK+dRlfFJCq31hIAE6
         pThTTXYu/CY0EvvVZ10XbHAnaztmXmrA3BObF/NgV9IMuu4fP/3Nsl9rY5RJE1qELnLE
         JGokP0PAXUCywXkjzYL7vf19V5E1F3RvwOOByCRzU+vAD3l2Mu8tQG6lkEVRg1Bw4n2W
         n+fplCiNuRyZe1cz5H8FjSDmBT0UuUDhPPLy5q6evykK8D/KjF00e1oBbRYQLZBts61Z
         RuvQ==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
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
Subject: [PATCH v4 06/10] MAINTAINERS: Add myself as the I3C subsystem maintainer
Date: Fri, 30 Mar 2018 09:47:47 +0200
Message-Id: <20180330074751.25987-7-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347991175328662?=
X-GMAIL-MSGID: =?utf-8?q?1596347991175328662?=
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
