Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63072C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD4120857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfBHLyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:54:17 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58299 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfBHLyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:54:16 -0500
X-Originating-IP: 90.88.22.177
Received: from localhost (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8FB636000F;
        Fri,  8 Feb 2019 11:54:14 +0000 (UTC)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] MAINTAINERS: drop Hoan Tran, e-mail is bouncing
Date:   Fri,  8 Feb 2019 12:54:11 +0100
Message-Id: <20190208115411.7675-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hoan Tran's e-mail is bouncing:

<hotran@apm.com>: host ASPMX.L.GOOGLE.COM[64.233.167.26] said: 550-5.2.1 The
    email account that you tried to reach is disabled. Learn more at 550 5.2.1
    https://support.google.com/mail/?p=DisabledUser q194si1780402wme.147 -
    gsmtp (in reply to RCPT TO command)

So let's remove this e-mail address from the MAINTAINERS file, and
update the status of the driver he was maintaining.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aee591104b5f..7bb92924757d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14479,9 +14479,8 @@ S:	Maintained
 F:	drivers/tty/serial/8250/8250_dw.c
 
 SYNOPSYS DESIGNWARE APB GPIO DRIVER
-M:	Hoan Tran <hotran@apm.com>
 L:	linux-gpio@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	drivers/gpio/gpio-dwapb.c
 F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
 
-- 
2.20.1

