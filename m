Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BEAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0512126A24
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0512126A24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934072AbeFZXli (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:41:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:1147 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933682AbeFZXlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:41:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 16:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="scan'208";a="60411595"
Received: from nc-new.jf.intel.com (HELO linux.intel.com) ([10.54.75.147])
  by FMSMGA003.fm.intel.com with SMTP; 26 Jun 2018 16:41:35 -0700
Received: by linux.intel.com (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:34:49 -0700
From:   nathan.d.ciobanu@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     mika.westerberg@linux.intel.com, michael.jamet@intel.com,
        andreas.noever@gmail.com,
        Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>
Subject: [PATCH] thunderbolt: fix small typo in variable name
Date:   Tue, 26 Jun 2018 16:34:20 -0700
Message-Id: <1530056060-3612-1-git-send-email-nathan.d.ciobanu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>

Fixes small variable name typo and the associated
checkpatch spelling warning

Signed-off-by: Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>
---
 drivers/thunderbolt/tb_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 5d94142afda6..693b0353c3fe 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -202,7 +202,7 @@ struct tb_regs_port_header {
 	/* DWORD 5 */
 	u32 max_in_hop_id:11;
 	u32 max_out_hop_id:11;
-	u32 __unkown4:10;
+	u32 __unknown4:10;
 	/* DWORD 6 */
 	u32 __unknown5;
 	/* DWORD 7 */
-- 
1.9.1

