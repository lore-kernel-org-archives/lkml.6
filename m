Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1691C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C915F21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLRO0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:26:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60149 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbeLRO0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:26:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6314D207B2; Tue, 18 Dec 2018 15:26:38 +0100 (CET)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 184CE2072C;
        Tue, 18 Dec 2018 15:26:38 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Date:   Tue, 18 Dec 2018 15:26:36 +0100
Message-Id: <20181218142636.1134-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microsemi has been bought by Microchip and Microchip is supporting those
SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..50223cba6ddb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9801,8 +9801,9 @@ F:	drivers/dma/at_xdmac.c
 
 MICROSEMI MIPS SOCS
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 L:	linux-mips@linux-mips.org
-S:	Maintained
+S:	Supported
 F:	arch/mips/generic/board-ocelot.c
 F:	arch/mips/configs/generic/board-ocelot.config
 F:	arch/mips/boot/dts/mscc/
-- 
2.20.0

