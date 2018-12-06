Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD607C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969020838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7969020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbeLFLIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:08:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeLFLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:08:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB6B6sBk1667773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Dec 2018 03:06:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB6B6qOw1667766;
        Thu, 6 Dec 2018 03:06:52 -0800
Date:   Thu, 6 Dec 2018 03:06:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-aa77bfb354c495fc4361199e63fc5765b9e1e783@git.kernel.org>
Cc:     tglx@linutronix.de, ak@linux.intel.com, karahmed@amazon.de,
        hpa@zytor.com, jkosina@suse.cz, linux-kernel@vger.kernel.org,
        mingo@kernel.org, longman@redhat.com, mingo@redhat.com,
        x86@kernel.org, bp@suse.de, tim.c.chen@linux.intel.com,
        konrad.wilk@oracle.com, peterz@infradead.org, jpoimboe@redhat.com,
        dwmw@amazon.co.uk
Reply-To: bp@suse.de, x86@kernel.org, mingo@redhat.com,
          jpoimboe@redhat.com, peterz@infradead.org, dwmw@amazon.co.uk,
          konrad.wilk@oracle.com, tim.c.chen@linux.intel.com,
          hpa@zytor.com, karahmed@amazon.de, ak@linux.intel.com,
          tglx@linutronix.de, longman@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jkosina@suse.cz
In-Reply-To: <1544039368-9009-1-git-send-email-longman@redhat.com>
References: <1544039368-9009-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Change misspelled STIPB to STIBP
Git-Commit-ID: aa77bfb354c495fc4361199e63fc5765b9e1e783
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

Commit-ID:  aa77bfb354c495fc4361199e63fc5765b9e1e783
Gitweb:     https://git.kernel.org/tip/aa77bfb354c495fc4361199e63fc5765b9e1e783
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Wed, 5 Dec 2018 14:49:27 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 6 Dec 2018 11:49:15 +0100

x86/speculation: Change misspelled STIPB to STIBP

STIBP stands for Single Thread Indirect Branch Predictors. The acronym,
however, can be easily mis-spelled as STIPB. It is perhaps due to the
presence of another related term - IBPB (Indirect Branch Predictor
Barrier).

Fix the mis-spelling in the code.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1544039368-9009-1-git-send-email-longman@redhat.com
---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 arch/x86/kernel/process.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 500278f5308e..a68b32cb845a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,7 +54,7 @@ static u64 __ro_after_init x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
 u64 __ro_after_init x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
-/* Control conditional STIPB in switch_to() */
+/* Control conditional STIBP in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 /* Control conditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
@@ -379,12 +379,12 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 			"always-on" : "conditional");
 	}
 
-	/* If enhanced IBRS is enabled no STIPB required */
+	/* If enhanced IBRS is enabled no STIBP required */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
 	/*
-	 * If SMT is not possible or STIBP is not available clear the STIPB
+	 * If SMT is not possible or STIBP is not available clear the STIBP
 	 * mode.
 	 */
 	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 898e97cf6629..320ab978fb1f 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -19,7 +19,7 @@ static inline void switch_to_extra(struct task_struct *prev,
 	if (IS_ENABLED(CONFIG_SMP)) {
 		/*
 		 * Avoid __switch_to_xtra() invocation when conditional
-		 * STIPB is disabled and the only different bit is
+		 * STIBP is disabled and the only different bit is
 		 * TIF_SPEC_IB. For CONFIG_SMP=n TIF_SPEC_IB is not
 		 * in the TIF_WORK_CTXSW masks.
 		 */
