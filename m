Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB62421473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfA2P3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:29:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfA2P3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:29:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TFRxcp1991517
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 07:27:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TFRvqW1991513;
        Tue, 29 Jan 2019 07:27:57 -0800
Date:   Tue, 29 Jan 2019 07:27:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-2b0fc3742bc77687f58d389c902ee092df6f8669@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, keescook@chromium.org, hpa@zytor.com,
        x86@kernel.org, gustavo@embeddedor.com, qianyue.zj@alibaba-inc.com,
        jacek.tomaka@poczta.fm, jolsa@kernel.org, ak@linux.intel.com,
        mingo@kernel.org, bp@suse.de, kan.liang@linux.intel.com
Reply-To: qianyue.zj@alibaba-inc.com, gustavo@embeddedor.com,
          x86@kernel.org, hpa@zytor.com, keescook@chromium.org,
          peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
          bp@suse.de, mingo@kernel.org, ak@linux.intel.com,
          jolsa@kernel.org, jacek.tomaka@poczta.fm
In-Reply-To: <20190125184917.GA7289@embeddedor>
References: <20190125184917.GA7289@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/events: Mark expected switch-case
 fall-throughs
Git-Commit-ID: 2b0fc3742bc77687f58d389c902ee092df6f8669
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

Commit-ID:  2b0fc3742bc77687f58d389c902ee092df6f8669
Gitweb:     https://git.kernel.org/tip/2b0fc3742bc77687f58d389c902ee092df6f8669
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Fri, 25 Jan 2019 12:49:17 -0600
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 29 Jan 2019 16:23:47 +0100

x86/events: Mark expected switch-case fall-throughs

In preparation to enable -Wimplicit-fallthrough by default, mark
switch-case statements where fall-through is intentional, explicitly in
order to fix a couple of -Wimplicit-fallthrough warnings.

Warning level 3 was used: -Wimplicit-fallthrough=3.

 [ bp: Massasge and trim commit message. ]

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jacek Tomaka <jacek.tomaka@poczta.fm>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190125184917.GA7289@embeddedor
---
 arch/x86/events/intel/core.c | 2 ++
 arch/x86/events/intel/lbr.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cfc87f6..ece43e7e4569 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4168,6 +4168,8 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_CORE2_MEROM:
 		x86_add_quirk(intel_clovertown_quirk);
+		/* fall through */
+
 	case INTEL_FAM6_CORE2_MEROM_L:
 	case INTEL_FAM6_CORE2_PENRYN:
 	case INTEL_FAM6_CORE2_DUNNINGTON:
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index c88ed39582a1..580c1b91c454 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -931,6 +931,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 			ret = X86_BR_ZERO_CALL;
 			break;
 		}
+		/* fall through */
 	case 0x9a: /* call far absolute */
 		ret = X86_BR_CALL;
 		break;
