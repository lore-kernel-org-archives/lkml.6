Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B0C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344CD213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344CD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJCVHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:07:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33475 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:07:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w93EIotF2373358
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 3 Oct 2018 07:18:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w93EIovo2373355;
        Wed, 3 Oct 2018 07:18:50 -0700
Date:   Wed, 3 Oct 2018 07:18:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Takuya Yamamoto <tipbot@zytor.com>
Message-ID: <tip-b3541fbc3c25bf2ba6d03a450c07f824e318f9b9@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tkyymmt01@gmail.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tkyymmt01@gmail.com, mingo@kernel.org
In-Reply-To: <20180829072730.988-1-tkyymmt01@gmail.com>
References: <20180829072730.988-1-tkyymmt01@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Fix typo in comment
Git-Commit-ID: b3541fbc3c25bf2ba6d03a450c07f824e318f9b9
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

Commit-ID:  b3541fbc3c25bf2ba6d03a450c07f824e318f9b9
Gitweb:     https://git.kernel.org/tip/b3541fbc3c25bf2ba6d03a450c07f824e318f9b9
Author:     Takuya Yamamoto <tkyymmt01@gmail.com>
AuthorDate: Wed, 29 Aug 2018 16:27:30 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 3 Oct 2018 16:14:05 +0200

x86/mm: Fix typo in comment

Signed-off-by: Takuya Yamamoto <tkyymmt01@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180829072730.988-1-tkyymmt01@gmail.com

---
 arch/x86/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 45f5d6cf65ae..9ceb940334cd 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -230,7 +230,7 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 	 * result in a hard-to-debug panic.
 	 *
 	 * Keep in mind that not all vectors actually get here.  Early
-	 * fage faults, for example, are special.
+	 * page faults, for example, are special.
 	 */
 	if (fixup_exception(regs, trapnr))
 		return;
