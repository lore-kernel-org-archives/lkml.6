Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6340A214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 06:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeL0GEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 01:04:01 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:35484 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbeL0GEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 01:04:00 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 24C143B91CE20114F429;
        Thu, 27 Dec 2018 14:03:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wBR63ouw019580;
        Thu, 27 Dec 2018 14:03:50 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018122714041906-19047302 ;
          Thu, 27 Dec 2018 14:04:19 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  arm/mach-iop13xx: remove duplicated argument in define
Date:   Thu, 27 Dec 2018 14:24:33 +0800
Message-Id: <1545891873-84150-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-27 14:04:19,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-27 14:03:38,
        Serialize complete at 2018-12-27 14:03:38
X-MAIL: mse01.zte.com.cn wBR63ouw019580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated PCI_STATUS_REC_TARGET_ABORT.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm/mach-iop13xx/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index 736168d..c6a0678 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -23,7 +23,6 @@
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
 			       PCI_STATUS_REC_MASTER_ABORT | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
 	 		       PCI_STATUS_DETECTED_PARITY)
-- 
1.8.3.1

