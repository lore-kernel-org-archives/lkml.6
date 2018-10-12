Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 145D320865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 145D320865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeJLW0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:26:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46257 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbeJLW0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:26:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAyoU-0002o1-W0; Fri, 12 Oct 2018 14:53:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: fix spelling mistake QSD_PORT_ACTUVE -> QSD_PORT_ACTIVE
Date:   Fri, 12 Oct 2018 15:53:14 +0100
Message-Id: <20181012145314.20897-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in kernel error message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/alpha/kernel/core_wildfire.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/core_wildfire.c b/arch/alpha/kernel/core_wildfire.c
index cad36fc6ed7d..445e96e0c206 100644
--- a/arch/alpha/kernel/core_wildfire.c
+++ b/arch/alpha/kernel/core_wildfire.c
@@ -557,7 +557,7 @@ wildfire_dump_qsd_regs(int qbbno)
 	printk(KERN_ERR " QSD_REV:           0x%16lx\n", qsd->qsd_rev.csr);
 	printk(KERN_ERR " QSD_PORT_PRESENT:  0x%16lx\n",
 	       qsd->qsd_port_present.csr);
-	printk(KERN_ERR " QSD_PORT_ACTUVE:   0x%16lx\n",
+	printk(KERN_ERR " QSD_PORT_ACTIVE:   0x%16lx\n",
 	       qsd->qsd_port_active.csr);
 	printk(KERN_ERR " QSD_FAULT_ENA:     0x%16lx\n",
 	       qsd->qsd_fault_ena.csr);
-- 
2.17.1

