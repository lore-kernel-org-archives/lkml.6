Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DCC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8D920856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8D920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeGSLQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:16:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeGSLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:16:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JAXwDa2249991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 03:33:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JAXwXF2249987;
        Thu, 19 Jul 2018 03:33:58 -0700
Date:   Thu, 19 Jul 2018 03:33:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiang Biao <tipbot@zytor.com>
Message-ID: <tip-d9f4426c73002957be5dd39936f44a09498f7560@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, jiang.biao2@zte.com.cn,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn
In-Reply-To: <1531872194-39207-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531872194-39207-1-git-send-email-jiang.biao2@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Remove SPECTRE_V2_IBRS in enum
 spectre_v2_mitigation
Git-Commit-ID: d9f4426c73002957be5dd39936f44a09498f7560
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d9f4426c73002957be5dd39936f44a09498f7560
Gitweb:     https://git.kernel.org/tip/d9f4426c73002957be5dd39936f44a09498f7560
Author:     Jiang Biao <jiang.biao2@zte.com.cn>
AuthorDate: Wed, 18 Jul 2018 08:03:14 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 19 Jul 2018 12:31:00 +0200

x86/speculation: Remove SPECTRE_V2_IBRS in enum spectre_v2_mitigation

SPECTRE_V2_IBRS in enum spectre_v2_mitigation is never used. Remove it.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: hpa@zytor.com
Cc: dwmw2@amazon.co.uk
Cc: konrad.wilk@oracle.com
Cc: bp@suse.de
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1531872194-39207-1-git-send-email-jiang.biao2@zte.com.cn

---
 arch/x86/include/asm/nospec-branch.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index f6f6c63da62f..c99082e2ef13 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -214,7 +214,6 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
-	SPECTRE_V2_IBRS,
 };
 
 /* The Speculative Store Bypass disable variants */
