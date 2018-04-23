Return-Path: <Yixun.Lan@amlogic.com>
X-Google-Smtp-Source: AIpwx49WCUnYNdQ0m3IZUpVEa3RriHVfmzXcAxaG2JyxvSEcH4D5T6cALcC3BYFpxTyZ/oHJGtzJ
ARC-Seal: i=1; a=rsa-sha256; t=1524468642; cv=none;
        d=google.com; s=arc-20160816;
        b=T/Py78XfQUsd23J7u4mqasm6yn2aG0AoWHpS9Ut3uB8W/FB/RaodH036J2C4K09tnN
         npOKxM8fyzR8Hp9V8xwkLYsu7hgz5Wc5J1MLnvt95aedmoEwtITc4P/CjtLdxiWjo3Gp
         Fw3IrCgs/58+8ghZofDK6fXT0Y3dPCF0r2tuTXrd4Pm54o0RfGV0UnNOAWu9A9Ic6S6i
         e+/0VNmATeZjXiRM6JUX35DEwIvu3qxlgaFyGWKYX/i3AW7s9argcO63M6p+XM0OLTH1
         BawH9xlVca8Q6cLgXThViBGn826lKwS8UtzoYQsG06c5Zkpw2B3A1AwKj2h4Yrz4uzUn
         71zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=/Yz7azvjiw1pHXV7nh6S076Om9cFCSoPG+zPz1onWXY=;
        b=XQ464bgHviKShR5MF1d09D1cA/cCloXN1M0/D34/YbckDBWhBqJJKd9PcWAv+/YGuU
         KWKJoAGv2gCLnmTKH46PogaYp1A7Lz6O/1P4SazF+AYHTyDjTcfPDRyKtcrRXlKoPJL3
         STEETXjgxpX62zS5M31V9JhwbVuePio7BUDxv8GQR4D40iZZ+oTyUha66umeuMX9VewQ
         /ClpsdLkLRUH7NMnXSJIefhK9eZNzeZQMuoaplV29JOqWOvvXytvUVyWS+09nVAaGMMC
         AjpP+58rQ54hbqSa1dBekFXCBQg9rp0VckbH7Fx/anegbawj3CVMtzRsIpdAQgKTxUcD
         bLUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yixun.lan@amlogic.com designates 58.32.228.45 as permitted sender) smtp.mailfrom=Yixun.Lan@amlogic.com
From: Yixun Lan <yixun.lan@amlogic.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
CC: Yixun Lan <yixun.lan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>,
	Carlo Caione <carlo@caione.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>,
	<linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: reset: fix invalid SPDX license identifier
Date: Mon, 23 Apr 2018 15:29:07 +0000
Message-ID: <20180423152907.5113-1-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.250]
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598521231346509320?=
X-GMAIL-MSGID: =?utf-8?q?1598521231346509320?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This fix invalid SPDX license indentifier, also move it to
first top line according to documentation.

Link: https://lkml.org/lkml/2018/4/22/713
Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
index ad6f55dabd6d..4a8e52f68fb7 100644
--- a/include/dt-bindings/reset/amlogic,meson-axg-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
 /*
  *
  * Copyright (c) 2016 BayLibre, SAS.
@@ -5,8 +6,6 @@
  *
  * Copyright (c) 2017 Amlogic, inc.
  * Author: Yixun Lan <yixun.lan@amlogic.com>
- *
- * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
  */
 
 #ifndef _DT_BINDINGS_AMLOGIC_MESON_AXG_RESET_H
-- 
2.17.0
