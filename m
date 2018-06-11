Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id oXw3MdqQHluKCwAAmS7hNA
	; Mon, 11 Jun 2018 15:10:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9C98607BB; Mon, 11 Jun 2018 15:10:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5A66C60351;
	Mon, 11 Jun 2018 15:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A66C60351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ltec.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeFKPKQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:10:16 -0400
Received: from mail.ltec.ch ([95.143.48.181]:44960 "EHLO mail.ltec.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932313AbeFKPKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:10:15 -0400
X-Greylist: delayed 1388 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Jun 2018 11:10:14 EDT
Received: from nebula.ltec ([172.27.11.2] helo=vm64.ltec)
        by mail.ltec.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.89)
        (envelope-from <fb@ltec.ch>)
        id 1fSO60-0000Pe-Cm; Mon, 11 Jun 2018 16:47:00 +0200
From: Felix Brack <fb@ltec.ch>
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, fb@ltec.ch
Subject: [PATCH] ARM: dts: am33xx: Fix syntax of alias names
Date: Mon, 11 Jun 2018 16:45:53 +0200
Message-Id: <1528728353-5889-1-git-send-email-fb@ltec.ch>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT specifications do not allow the underscore character in alias names.
Replace all underscores in alias names by dashes.

Signed-off-by: Felix Brack <fb@ltec.ch>
---
 arch/arm/boot/dts/am33xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2..d3dd6a1 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -29,8 +29,8 @@
 		serial3 = &uart3;
 		serial4 = &uart4;
 		serial5 = &uart5;
-		d_can0 = &dcan0;
-		d_can1 = &dcan1;
+		d-can0 = &dcan0;
+		d-can1 = &dcan1;
 		usb0 = &usb0;
 		usb1 = &usb1;
 		phy0 = &usb0_phy;
-- 
2.7.4
