Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39484C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEF52080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEEF52080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbeKLFxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51654 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeKLFxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:48 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000l6-Bm; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001XC-Pq; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>,
        "Imre Deak" <imre.deak@intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.722255284@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 128/366] video/omap: add module license tags
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 1bde9f2cf142b726412fa5b0e3cb557ff46952b0 upstream.

I got a bunch of warnings in a randconfig build:

WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_ams_delta.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_inn1510.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmte.o
WARNING: modpost: missing MODULE_LICENSE() in drivers/video/fbdev/omap/lcd_palmtt.o

These come from an earlier patch of mine that turned all display drivers
into separate modules. The fix is to add a MODULE_LICENSE tag. Since I'm
doing that, adding a description and author field also makes sense. I
went by the authors listed in the comment at the top of each file, but
removed Imre's Nokia email address that I assume is not valid any more,
since Imre is working at Intel these days.

Fixes: 81c44c2b2ce3 ("video/omap: fix modular build")
Cc: Imre Deak <imre.deak@intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[b.zolnierkie: minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/omap/lcd_ams_delta.c | 4 ++++
 drivers/video/fbdev/omap/lcd_h3.c        | 4 ++++
 drivers/video/fbdev/omap/lcd_htcherald.c | 4 ++++
 drivers/video/fbdev/omap/lcd_inn1510.c   | 4 ++++
 drivers/video/fbdev/omap/lcd_inn1610.c   | 4 ++++
 drivers/video/fbdev/omap/lcd_osk.c       | 4 ++++
 drivers/video/fbdev/omap/lcd_palmte.c    | 4 ++++
 drivers/video/fbdev/omap/lcd_palmtt.c    | 4 ++++
 drivers/video/fbdev/omap/lcd_palmz71.c   | 4 ++++
 9 files changed, 36 insertions(+)

--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -223,3 +223,7 @@ static struct platform_driver ams_delta_
 };
 
 module_platform_driver(ams_delta_panel_driver);
+
+MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
+MODULE_DESCRIPTION("LCD panel support for the Amstrad E3 (Delta) videophone");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -125,3 +125,7 @@ static struct platform_driver h3_panel_d
 };
 
 module_platform_driver(h3_panel_driver);
+
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP H3 board");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_htcherald.c
+++ b/drivers/video/fbdev/omap/lcd_htcherald.c
@@ -116,3 +116,7 @@ static struct platform_driver htcherald_
 };
 
 module_platform_driver(htcherald_panel_driver);
+
+MODULE_AUTHOR("Cory Maccarrone");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD panel support for the HTC Herald");
--- a/drivers/video/fbdev/omap/lcd_inn1510.c
+++ b/drivers/video/fbdev/omap/lcd_inn1510.c
@@ -111,3 +111,7 @@ static struct platform_driver innovator1
 };
 
 module_platform_driver(innovator1510_panel_driver);
+
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP1510 Innovator board");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_inn1610.c
+++ b/drivers/video/fbdev/omap/lcd_inn1610.c
@@ -132,3 +132,7 @@ static struct platform_driver innovator1
 };
 
 module_platform_driver(innovator1610_panel_driver);
+
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP1610 Innovator board");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_osk.c
+++ b/drivers/video/fbdev/omap/lcd_osk.c
@@ -131,3 +131,7 @@ static struct platform_driver osk_panel_
 };
 
 module_platform_driver(osk_panel_driver);
+
+MODULE_AUTHOR("Imre Deak");
+MODULE_DESCRIPTION("LCD panel support for the TI OMAP OSK board");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_palmte.c
+++ b/drivers/video/fbdev/omap/lcd_palmte.c
@@ -108,3 +108,7 @@ static struct platform_driver palmte_pan
 };
 
 module_platform_driver(palmte_panel_driver);
+
+MODULE_AUTHOR("Romain Goyet <r.goyet@gmail.com>, Laurent Gonzalez <palmte.linux@free.fr>");
+MODULE_DESCRIPTION("LCD panel support for the Palm Tungsten E");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_palmtt.c
+++ b/drivers/video/fbdev/omap/lcd_palmtt.c
@@ -114,3 +114,7 @@ static struct platform_driver palmtt_pan
 };
 
 module_platform_driver(palmtt_panel_driver);
+
+MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
+MODULE_DESCRIPTION("LCD panel support for Palm Tungsten|T");
+MODULE_LICENSE("GPL");
--- a/drivers/video/fbdev/omap/lcd_palmz71.c
+++ b/drivers/video/fbdev/omap/lcd_palmz71.c
@@ -110,3 +110,7 @@ static struct platform_driver palmz71_pa
 };
 
 module_platform_driver(palmz71_panel_driver);
+
+MODULE_AUTHOR("Romain Goyet, Laurent Gonzalez, Marek Vasut");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LCD panel support for the Palm Zire71");

