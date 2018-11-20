Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B0AC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE67206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE67206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeKUBmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:42:10 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58308 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbeKUBmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:42:09 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68EFB2074F; Tue, 20 Nov 2018 16:12:32 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F3B8206D8;
        Tue, 20 Nov 2018 16:12:32 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
Date:   Tue, 20 Nov 2018 16:12:30 +0100
Message-Id: <20181120151230.32159-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling mistake in a register description.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/powerpc/sysdev/fsl_rio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.h b/arch/powerpc/sysdev/fsl_rio.h
index 12dd18fd4795..6c13d9a7b7b2 100644
--- a/arch/powerpc/sysdev/fsl_rio.h
+++ b/arch/powerpc/sysdev/fsl_rio.h
@@ -41,7 +41,7 @@
 #define DOORBELL_ROWAR_PCI	0x02000000 /* PCI window */
 #define DOORBELL_ROWAR_NREAD	0x00040000 /* NREAD */
 #define DOORBELL_ROWAR_MAINTRD	0x00070000  /* maintenance read */
-#define DOORBELL_ROWAR_RES	0x00002000 /* wrtpy: reserverd */
+#define DOORBELL_ROWAR_RES	0x00002000 /* wrtpy: reserved */
 #define DOORBELL_ROWAR_MAINTWD	0x00007000
 #define DOORBELL_ROWAR_SIZE	0x0000000b /* window size is 4k */
 
-- 
2.19.1

