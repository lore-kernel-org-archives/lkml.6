Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB2EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F3721473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="GBWZMvfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfA3RsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:48:19 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:56710 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfA3RsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:48:19 -0500
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2357B24E096E;
        Wed, 30 Jan 2019 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548870499; bh=u+7rKHYnuXjx40KGiN6ttBD50059Hc8O9yiA6VbbLo0=;
        h=From:To:Cc:Subject:Date:From;
        b=GBWZMvfB3g49ndMoIXwzWO6sdnXaQi0X0Yld4pGh6iOkngVFQUh8LM2kFEMXm5zIw
         Hbo9RvFAFPCmH4h/r38ldR69pJAgDJD0+kxoQQTiGVBoIDY1lb+i5vkzkDvFA0H3Ls
         LMmUbrG00KCiLalAxZyqrxxp38HtTzCQ5KXagGef2yuZzPuLYWPaK2Yx9rQqEDlU7B
         qQsq3sV4jHuEnovAFzkek+1qX8dEQ/anhnawppZAvlZRMfmrv7FhI6VvUPypsAL5WW
         Ctb/ySn5ztAAqcN/NV0EmAPMt+agRWiz5jj/AF5k6pCPif10zkB2p8mymNryePqfvX
         iXV01vOiEkWAA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id 9ADDB594C;
        Wed, 30 Jan 2019 09:48:17 -0800 (PST)
From:   Joao Pinto <joao.pinto@synopsys.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     joao.pinto@synopsys.com, pedrom.sousa@synopsys.com,
        marc.w.gonzalez@free.fr, Alex.Lemberg@wdc.com
Subject: [PATCH for-next] scsi: ufs: Update dwc driver maintainer to Pedro Sousa
Date:   Wed, 30 Jan 2019 18:48:13 +0100
Message-Id: <812e9e1426555808ad1bd5fbfda320c6684abc81.1548869844.git.jpinto@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently I am managing the Synopsys drivers & tools team (full-time) and
so I am passing the DWC UFS driver maintenance to Pedro Sousa.

Signed-off-by: Joao Pinto <jpinto@synopsys.com>
Cc: Pedro Sousa <pedrom.sousa@synopsys.com>
Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Alex Lemberg <Alex.Lemberg@wdc.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70c93b1..458a2a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15673,7 +15673,7 @@ F:	Documentation/scsi/ufs.txt
 F:	drivers/scsi/ufs/
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER DWC HOOKS
-M:	Joao Pinto <jpinto@synopsys.com>
+M:	Pedro Sousa <pedrom.sousa@synopsys.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
 F:	drivers/scsi/ufs/*dwc*
-- 
2.7.4

