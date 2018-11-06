Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDB4C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0CE2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0CE2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbeKFX1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:27:33 -0500
Received: from mail114-240.sinamail.sina.com.cn ([218.30.114.240]:50607 "HELO
        mail114-240.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1730421AbeKFX1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:27:33 -0500
Received: from unknown (HELO localhost.localdomain.localdomain)([110.184.32.86])
        by sina.com with ESMTP
        id 5BE19EB200001FD8; Tue, 6 Nov 2018 22:01:30 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 7757325952691
From:   Peng Hao <penghao122@sina.com.cn>
To:     haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        kys@microsoft.com, mingo@redhat.com
Cc:     x86@kernel.org, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  x86/hyper-v: fix a commit description style in the comments
Date:   Tue,  6 Nov 2018 09:01:18 -0500
Message-Id: <1541512878-5121-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

Use commit description style 'commit <12+ chars of sha1> ("<title line>")'.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/x86/include/asm/mshyperv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f377044..b56b77c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -386,7 +386,8 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 	 *   A special '0' value indicates the time source is unreliable and we
 	 *   need to use something else. The currently published specification
 	 *   versions (up to 4.0b) contain a mistake and wrongly claim '-1'
-	 *   instead of '0' as the special value, see commit c35b82ef0294.
+	 *   instead of '0' as the special value, see commit c35b82ef0294 (
+	 *   "drivers/hv: correct tsc page sequence invalid value").
 	 * - ReferenceTime =
 	 *        ((RDTSC() * ReferenceTscScale) >> 64) + ReferenceTscOffset
 	 * - READ ReferenceTscSequence again. In case its value has changed
-- 
1.8.3.1


