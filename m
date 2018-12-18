Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BAC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2323D21841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLRQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:08:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36494 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbeLRQIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:08:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8E253207D9; Tue, 18 Dec 2018 17:08:08 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 628B520824;
        Tue, 18 Dec 2018 17:07:58 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [RESEND PATCH v2] MAINTAINERS: Add a maintainer for MSCC MIPS SoCs
Date:   Tue, 18 Dec 2018 17:07:47 +0100
Message-Id: <20181218160750.6766-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
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

