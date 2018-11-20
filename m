Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14FEC41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0111020831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0111020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeKUCnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:43:42 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36616 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeKUCnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:43:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B81D20DB0; Tue, 20 Nov 2018 17:13:48 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E539212BE;
        Tue, 20 Nov 2018 17:10:33 +0100 (CET)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Arvind R ." <arvino55@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] MAINTAINERS: edac: drop bouncing email
Date:   Tue, 20 Nov 2018 17:10:32 +0100
Message-Id: <20181120161032.3417-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jetztechnologies.com doesn't exist anymore and emails to Ranganathan are
bouncing.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..424ae080b38a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5292,7 +5292,6 @@ S:	Maintained
 F:	drivers/edac/i82443bxgx_edac.c
 
 EDAC-I82975X
-M:	Ranganathan Desikan <ravi@jetztechnologies.com>
 M:	"Arvind R." <arvino55@gmail.com>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
-- 
2.19.1

