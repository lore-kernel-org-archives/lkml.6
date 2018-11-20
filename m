Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339BC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8ED2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8ED2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeKUCCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:02:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58995 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKUCCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:02:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 778F22074F; Tue, 20 Nov 2018 16:33:06 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4E692206A1;
        Tue, 20 Nov 2018 16:33:06 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ranganathan Desikan <ravi@jetztechnologies.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "Arvind R ." <arvino55@gmail.com>, Borislav Petkov <bp@alien8.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] edac: i82975x: fix spelling mistake "reserverd" -> "reserved"
Date:   Tue, 20 Nov 2018 16:33:04 +0100
Message-Id: <20181120153304.1218-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling mistake in a register layout description.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/edac/i82975x_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i82975x_edac.c b/drivers/edac/i82975x_edac.c
index 892815eaa97b..40249e9c9d26 100644
--- a/drivers/edac/i82975x_edac.c
+++ b/drivers/edac/i82975x_edac.c
@@ -104,7 +104,7 @@ NOTE: Only ONE of the three must be enabled
 					 *
 					 * 31:14 Base Addr of 16K memory-mapped
 					 *	configuration space
-					 * 13:1  reserverd
+					 * 13:1  reserved
 					 *  0    mem-mapped config space enable
 					 */
 
-- 
2.19.1

