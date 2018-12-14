Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158F1C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6255A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6255A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thorsis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeLNJoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:44:21 -0500
Received: from mail.thorsis.com ([92.198.35.195]:48400 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbeLNJoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:44:21 -0500
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Dec 2018 04:44:20 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id AEF4F4FD7;
        Fri, 14 Dec 2018 10:35:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YaIt7YGv5yPa; Fri, 14 Dec 2018 10:35:28 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 8F2D15056; Fri, 14 Dec 2018 10:35:28 +0100 (CET)
Received: from adahl by ada.ifak-system.com with local (Exim 4.89)
        (envelope-from <ada@thorsis.com>)
        id 1gXjsC-0001GU-NJ; Fri, 14 Dec 2018 10:35:08 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] can: usb: Kconfig: Remove duplicate menu entry
Date:   Fri, 14 Dec 2018 10:35:08 +0100
Message-Id: <20181214093508.4825-1-ada@thorsis.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have slipped in by accident when sorting the entries.

Fixes: ffbdd9172ee2f53020f763574b4cdad8d9760a4f
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/net/can/usb/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index 750d04d9e2ae..928bf083f8d2 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -101,12 +101,6 @@ config CAN_PEAK_USB
 
 	  (see also http://www.peak-system.com).
 
-config CAN_MCBA_USB
-	tristate "Microchip CAN BUS Analyzer interface"
-	---help---
-	  This driver supports the CAN BUS Analyzer interface
-	  from Microchip (http://www.microchip.com/development-tools/).
-
 config CAN_UCAN
 	tristate "Theobroma Systems UCAN interface"
 	---help---
-- 
2.11.0

