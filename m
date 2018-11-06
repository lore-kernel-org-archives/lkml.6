Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22557C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2A2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A2A2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbeKGHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:55:34 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:49234 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeKGHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:55:33 -0500
Received: from localhost.localdomain (85-76-84-88-nat.elisa-mobile.fi [85.76.84.88])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 0AB3240047;
        Wed,  7 Nov 2018 00:28:04 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Jarkko Lavinen <jarkko.lavinen@nokia.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v2] MAINTAINERS: update OMAP MMC entry
Date:   Wed,  7 Nov 2018 00:27:50 +0200
Message-Id: <20181106222750.12939-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko's e-mail address hasn't worked for a long time. We still want
to keep this driver working as it is critical for some of the OMAP boards.
I use and test this driver frequently, so change myself as a maintainer
with "Odd Fixes" status.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

	v2: Add Jarkko to CREDITS.

	v1: https://patchwork.kernel.org/patch/10369861/

diff --git a/CREDITS b/CREDITS
index 5befd2d714d0..84cbec4c6211 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2138,6 +2138,10 @@ E: paul@laufernet.com
 D: Soundblaster driver fixes, ISAPnP quirk
 S: California, USA
 
+N: Jarkko Lavinen
+E: jarkko.lavinen@nokia.com
+D: OMAP MMC support
+
 N: Jonathan Layes
 D: ARPD support
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..1c2badfec2ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10793,9 +10793,9 @@ F:	drivers/media/platform/omap3isp/
 F:	drivers/staging/media/omap4iss/
 
 OMAP MMC SUPPORT
-M:	Jarkko Lavinen <jarkko.lavinen@nokia.com>
+M:	Aaro Koskinen <aaro.koskinen@iki.fi>
 L:	linux-omap@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/mmc/host/omap.c
 
 OMAP POWER MANAGEMENT SUPPORT
-- 
2.17.0

