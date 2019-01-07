Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B22087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbfAGP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:57:16 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37849 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfAGP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:57:16 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ggXH8-0002NS-S4; Mon, 07 Jan 2019 16:57:14 +0100
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: use include/linux/reset for reset controller related headers
Date:   Mon,  7 Jan 2019 16:57:07 +0100
Message-Id: <20190107155707.7782-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The include/linux/reset directory currently contains one header with
helper functions for Broadcom BCM63xx PMB, which can control reset
lines to on-chip peripherals. Even though that driver doesn't use the
reset controller framework, the the directory can be shared with other
reset controller drivers that do.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
See for example https://patchwork.kernel.org/patch/10728595/
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..826f7ea03f80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12954,6 +12954,7 @@ F:	drivers/reset/
 F:	Documentation/devicetree/bindings/reset/
 F:	include/dt-bindings/reset/
 F:	include/linux/reset.h
+F:	include/linux/reset/
 F:	include/linux/reset-controller.h
 
 RESTARTABLE SEQUENCES SUPPORT
-- 
2.20.1

