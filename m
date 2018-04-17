Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeDQKBt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:01:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeDQKBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:01:47 -0400
Date: Tue, 17 Apr 2018 03:01:35 -0700
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-451cf3ca7d4615631443014ee769c25e267c25ff@git.kernel.org>
Cc: tglx@linutronix.de, mingo@kernel.org, douly.fnst@cn.fujitsu.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, douly.fnst@cn.fujitsu.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180404064527.10562-1-douly.fnst@cn.fujitsu.com>
References: <20180404064527.10562-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/processor: Remove two unused function
 declarations
Git-Commit-ID: 451cf3ca7d4615631443014ee769c25e267c25ff
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  451cf3ca7d4615631443014ee769c25e267c25ff
Gitweb:     https://git.kernel.org/tip/451cf3ca7d4615631443014ee769c25e267c25ff
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 4 Apr 2018 14:45:27 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 11:56:32 +0200

x86/processor: Remove two unused function declarations

early_trap_init() and cpu_set_gdt() have been removed, so remove the stale
declarations as well.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@chromium.org
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: bp@suse.de
Cc: kirill.shutemov@linux.intel.com
Link: https://lkml.kernel.org/r/20180404064527.10562-1-douly.fnst@cn.fujitsu.com

---
 arch/x86/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4fa4206029e3..21a114914ba4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -749,13 +749,11 @@ enum idle_boot_override {IDLE_NO_OVERRIDE=0, IDLE_HALT, IDLE_NOMWAIT,
 extern void enable_sep_cpu(void);
 extern int sysenter_setup(void);
 
-extern void early_trap_init(void);
 void early_trap_pf_init(void);
 
 /* Defined in head.S */
 extern struct desc_ptr		early_gdt_descr;
 
-extern void cpu_set_gdt(int);
 extern void switch_to_new_gdt(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
