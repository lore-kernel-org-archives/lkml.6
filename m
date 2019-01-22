Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82669C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C01521019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfAVODL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:03:11 -0500
Received: from mail.thorsis.com ([92.198.35.195]:44902 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728584AbfAVODK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:03:10 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Jan 2019 09:03:08 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id D15BF51E4;
        Tue, 22 Jan 2019 14:56:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2HVXmYjoQKfP; Tue, 22 Jan 2019 14:56:17 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id B2E81520F; Tue, 22 Jan 2019 14:56:17 +0100 (CET)
Received: from adahl by ada.ifak-system.com with local (Exim 4.89)
        (envelope-from <ada@thorsis.com>)
        id 1glwWk-0006py-Sk; Tue, 22 Jan 2019 14:55:42 +0100
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-can@vger.kernel.org
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] can: usb: Kconfig: Remove duplicate menu entry
Date:   Tue, 22 Jan 2019 14:55:42 +0100
Message-Id: <20190122135542.26166-1-ada@thorsis.com>
In-Reply-To: <20181214093508.4825-1-ada@thorsis.com>
References: <20181214093508.4825-1-ada@thorsis.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to have slipped in by accident when sorting the entries.

Fixes: ffbdd9172ee2f53020f763574b4cdad8d9760a4f
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    v1 -> v2:
      * rebase onto v5.0-rc3 (was v4.20-rc6)

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

