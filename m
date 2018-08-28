Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09362C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98BE20833
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BE20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbeH1RZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:25:05 -0400
Received: from albert.telenet-ops.be ([195.130.137.90]:36766 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeH1RZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:25:05 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id UdZP1y0023XaVaC06dZPcA; Tue, 28 Aug 2018 15:33:23 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fue7W-0008Ba-V6; Tue, 28 Aug 2018 15:33:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fue7W-0000Uh-Sx; Tue, 28 Aug 2018 15:33:22 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] MAINTAINERS: Move entry for Cirrus Logic Madera codecs
Date:   Tue, 28 Aug 2018 15:33:20 +0200
Message-Id: <20180828133320.1831-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To preserve alphabetical sort order.

Fixes: 97c2b5cba2044f1c ("mfd: madera: Add register definitions for Cirrus Logic Madera codecs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39be98..4b0ce55dd7c2413d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3557,6 +3557,22 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/cirrus/ep93xx_eth.c
 
+CIRRUS LOGIC MADERA CODEC DRIVERS
+M:	Charles Keepax <ckeepax@opensource.cirrus.com>
+M:	Richard Fitzgerald <rf@opensource.cirrus.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+L:	patches@opensource.cirrus.com
+T:	git https://github.com/CirrusLogic/linux-drivers.git
+W:	https://github.com/CirrusLogic/linux-drivers/wiki
+S:	Supported
+F:	Documentation/devicetree/bindings/mfd/madera.txt
+F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+F:	include/linux/mfd/madera/*
+F:	drivers/gpio/gpio-madera*
+F:	drivers/mfd/madera*
+F:	drivers/mfd/cs47l*
+F:	drivers/pinctrl/cirrus/*
+
 CISCO FCOE HBA DRIVER
 M:	Satish Kharat <satishkh@cisco.com>
 M:	Sesidhar Baddela <sebaddel@cisco.com>
@@ -3584,22 +3600,6 @@ M:	Christian Benvenuti <benve@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
-CIRRUS LOGIC MADERA CODEC DRIVERS
-M:	Charles Keepax <ckeepax@opensource.cirrus.com>
-M:	Richard Fitzgerald <rf@opensource.cirrus.com>
-L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-L:	patches@opensource.cirrus.com
-T:	git https://github.com/CirrusLogic/linux-drivers.git
-W:	https://github.com/CirrusLogic/linux-drivers/wiki
-S:	Supported
-F:	Documentation/devicetree/bindings/mfd/madera.txt
-F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
-F:	include/linux/mfd/madera/*
-F:	drivers/gpio/gpio-madera*
-F:	drivers/mfd/madera*
-F:	drivers/mfd/cs47l*
-F:	drivers/pinctrl/cirrus/*
-
 CLANG-FORMAT FILE
 M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
 S:	Maintained
-- 
2.17.1

