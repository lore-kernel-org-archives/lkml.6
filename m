Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBEFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217192145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217192145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbeKNXWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:22:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbeKNXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:22:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAEDJSHV399565
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 14 Nov 2018 05:19:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAEDJRD5399562;
        Wed, 14 Nov 2018 05:19:27 -0800
Date:   Wed, 14 Nov 2018 05:19:27 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-8e1599fcac2efda8b7d433ef69d2492f0b351e3f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        bp@suse.de, x86@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, bp@suse.de, x86@kernel.org, hpa@zytor.com
In-Reply-To: <20181110141647.GA20073@zn.tnic>
References: <20181110141647.GA20073@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/traps: Complete prototype declarations
Git-Commit-ID: 8e1599fcac2efda8b7d433ef69d2492f0b351e3f
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

Commit-ID:  8e1599fcac2efda8b7d433ef69d2492f0b351e3f
Gitweb:     https://git.kernel.org/tip/8e1599fcac2efda8b7d433ef69d2492f0b351e3f
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 12 Nov 2018 13:20:36 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 14 Nov 2018 13:46:29 +0100

x86/traps: Complete prototype declarations

... with proper variable names.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181110141647.GA20073@zn.tnic
---
 arch/x86/include/asm/traps.h | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index afbc87206886..877afdedbbc5 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -61,34 +61,34 @@ asmlinkage void xen_machine_check(void);
 asmlinkage void xen_simd_coprocessor_error(void);
 #endif
 
-dotraplinkage void do_divide_error(struct pt_regs *, long);
-dotraplinkage void do_debug(struct pt_regs *, long);
-dotraplinkage void do_nmi(struct pt_regs *, long);
-dotraplinkage void do_int3(struct pt_regs *, long);
-dotraplinkage void do_overflow(struct pt_regs *, long);
-dotraplinkage void do_bounds(struct pt_regs *, long);
-dotraplinkage void do_invalid_op(struct pt_regs *, long);
-dotraplinkage void do_device_not_available(struct pt_regs *, long);
-dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *, long);
-dotraplinkage void do_invalid_TSS(struct pt_regs *, long);
-dotraplinkage void do_segment_not_present(struct pt_regs *, long);
-dotraplinkage void do_stack_segment(struct pt_regs *, long);
+dotraplinkage void do_divide_error(struct pt_regs *regs, long error_code);
+dotraplinkage void do_debug(struct pt_regs *regs, long error_code);
+dotraplinkage void do_nmi(struct pt_regs *regs, long error_code);
+dotraplinkage void do_int3(struct pt_regs *regs, long error_code);
+dotraplinkage void do_overflow(struct pt_regs *regs, long error_code);
+dotraplinkage void do_bounds(struct pt_regs *regs, long error_code);
+dotraplinkage void do_invalid_op(struct pt_regs *regs, long error_code);
+dotraplinkage void do_device_not_available(struct pt_regs *regs, long error_code);
+dotraplinkage void do_coprocessor_segment_overrun(struct pt_regs *regs, long error_code);
+dotraplinkage void do_invalid_TSS(struct pt_regs *regs, long error_code);
+dotraplinkage void do_segment_not_present(struct pt_regs *regs, long error_code);
+dotraplinkage void do_stack_segment(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_64
-dotraplinkage void do_double_fault(struct pt_regs *, long);
+dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_general_protection(struct pt_regs *, long);
-dotraplinkage void do_page_fault(struct pt_regs *, unsigned long);
-dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *, long);
-dotraplinkage void do_coprocessor_error(struct pt_regs *, long);
-dotraplinkage void do_alignment_check(struct pt_regs *, long);
+dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code);
+dotraplinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code);
+dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
+dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_MCE
-dotraplinkage void do_machine_check(struct pt_regs *, long);
+dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_simd_coprocessor_error(struct pt_regs *, long);
+dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
 #ifdef CONFIG_X86_32
-dotraplinkage void do_iret_error(struct pt_regs *, long);
+dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
 #endif
-dotraplinkage void do_mce(struct pt_regs *, long);
+dotraplinkage void do_mce(struct pt_regs *regs, long error_code);
 
 static inline int get_si_code(unsigned long condition)
 {
