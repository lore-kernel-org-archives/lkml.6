Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2127EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CD524F3C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 14:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8CD524F3C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeFXOBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 10:01:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751876AbeFXOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 10:01:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F236FAD31;
        Sun, 24 Jun 2018 14:01:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Liau <thomas.liau@actions-semi.com>,
        Jeff Chen <jeff.chen@actions-semi.com>,
        =?UTF-8?q?=E5=BC=A0=E4=B8=9C=E9=A3=8E?= <zhangdf@actions-semi.com>,
        =?UTF-8?q?=E5=88=98=E7=82=9C?= <liuwei@actions-semi.com>,
        =?UTF-8?q?=E5=BC=A0=E5=A4=A9=E7=9B=8A?= <tyzhang@actions-semi.com>,
        =?UTF-8?q?=E6=A2=85=E5=88=A9?= <harrymei@actions-semi.com>,
        support@cubietech.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: actions: Update SPS help text for S700
Date:   Sun, 24 Jun 2018 16:01:08 +0200
Message-Id: <20180624140108.13505-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
References: <62ef1835-8db9-f1e8-53b9-4cd74b5d416d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ad85b08f7789d51e6aad0f535296d1c31e319b9 (soc: actions: sps: Add S700)
added S700 support to the SPS driver but forget to update Kconfig help.

Add missing S700 mention, in preparation for further SoCs.

Fixes: 3ad85b08f778 ("soc: actions: sps: Add S700")
Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/soc/actions/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/actions/Kconfig b/drivers/soc/actions/Kconfig
index 9d68b5a771c3..56064f8859a0 100644
--- a/drivers/soc/actions/Kconfig
+++ b/drivers/soc/actions/Kconfig
@@ -10,7 +10,7 @@ config OWL_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	help
 	  Say 'y' here to enable support for Smart Power System (SPS)
-	  power-gating on Actions Semiconductor S500 SoC.
+	  power-gating on Actions Semiconductor S500 and S700 SoCs.
 	  If unsure, say 'n'.
 
 endif
-- 
2.16.4

