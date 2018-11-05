Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D22C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84882085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 15:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84882085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbeKFBJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:09:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49845 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbeKFBJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:09:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5Fmo6U392438
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 07:48:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5FmolO392435;
        Mon, 5 Nov 2018 07:48:50 -0800
Date:   Mon, 5 Nov 2018 07:48:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-b42967dcac1d4f5b059ec25568136462bcb051fe@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        wang.yi59@zte.com.cn, mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <1540797451-2792-1-git-send-email-wang.yi59@zte.com.cn>
References: <1540797451-2792-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyper-v: Fix indentation in
 hv_do_fast_hypercall16()
Git-Commit-ID: b42967dcac1d4f5b059ec25568136462bcb051fe
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

Commit-ID:  b42967dcac1d4f5b059ec25568136462bcb051fe
Gitweb:     https://git.kernel.org/tip/b42967dcac1d4f5b059ec25568136462bcb051fe
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 29 Oct 2018 15:17:31 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 16:45:24 +0100

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
