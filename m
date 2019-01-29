Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3474CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE920882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfA2VNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:13:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2VNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:13:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TLCtDc2099376
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 13:12:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TLCtHB2099373;
        Tue, 29 Jan 2019 13:12:55 -0800
Date:   Tue, 29 Jan 2019 13:12:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pingfan Liu <tipbot@zytor.com>
Message-ID: <tip-439fbdf6a2021ab1cca94b30837674b2b7527ae8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, kernelfans@gmail.com,
        bp@alien8.de, mingo@kernel.org, tglx@linutronix.de
Reply-To: bp@alien8.de, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, kernelfans@gmail.com
In-Reply-To: <1546591579-23502-1-git-send-email-kernelfans@gmail.com>
References: <1546591579-23502-1-git-send-email-kernelfans@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/trap: Remove useless declaration
Git-Commit-ID: 439fbdf6a2021ab1cca94b30837674b2b7527ae8
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

Commit-ID:  439fbdf6a2021ab1cca94b30837674b2b7527ae8
Gitweb:     https://git.kernel.org/tip/439fbdf6a2021ab1cca94b30837674b2b7527ae8
Author:     Pingfan Liu <kernelfans@gmail.com>
AuthorDate: Fri, 4 Jan 2019 16:46:19 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 29 Jan 2019 22:09:12 +0100

x86/trap: Remove useless declaration

There is no early_trap_pf_init() implementation, hence remove this useless
declaration.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1546591579-23502-1-git-send-email-kernelfans@gmail.com


---
 arch/x86/include/asm/processor.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 33051436c864..2bb3a648fc12 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -742,7 +742,6 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-void early_trap_pf_init(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
