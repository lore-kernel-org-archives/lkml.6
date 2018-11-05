Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3B420827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3B420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeKEU7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:59:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbeKEU7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:59:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5Bdq0a315279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:39:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5BdpLa315276;
        Mon, 5 Nov 2018 03:39:51 -0800
Date:   Mon, 5 Nov 2018 03:39:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-eb8fde6217d6229155c7ec6bdf6b31e4717fb3da@git.kernel.org>
Cc:     wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, wang.yi59@zte.com.cn,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1540797451-2792-1-git-send-email-wang.yi59@zte.com.cn>
References: <1540797451-2792-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyper-v: Fix indentation in
 hv_do_fast_hypercall16()
Git-Commit-ID: eb8fde6217d6229155c7ec6bdf6b31e4717fb3da
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

Commit-ID:  eb8fde6217d6229155c7ec6bdf6b31e4717fb3da
Gitweb:     https://git.kernel.org/tip/eb8fde6217d6229155c7ec6bdf6b31e4717fb3da
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 29 Oct 2018 15:17:31 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:35:03 +0100

x86/hyper-v: Fix indentation in hv_do_fast_hypercall16()

Remove the surplus TAB in hv_do_fast_hypercall16().

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: haiyangz@microsoft.com
Cc: sthemmin@microsoft.com
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: devel@linuxdriverproject.org
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1540797451-2792-1-git-send-email-wang.yi59@zte.com.cn

---
 arch/x86/include/asm/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0d6271cce198..1d0a7778e163 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -232,7 +232,7 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 				      : "cc");
 	}
 #endif
-		return hv_status;
+	return hv_status;
 }
 
 /*
