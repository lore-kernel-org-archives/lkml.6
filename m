Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DCBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B046E21900
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394115AbfBNM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:26:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfBNM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:26:01 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1ECPTpd713901
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 14 Feb 2019 04:25:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1ECPSfn713898;
        Thu, 14 Feb 2019 04:25:28 -0800
Date:   Thu, 14 Feb 2019 04:25:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rajneesh Bhardwaj <tipbot@zytor.com>
Message-ID: <tip-8cd8f0ce0d6aafe661cb3d6781c8b82bc696c04d@git.kernel.org>
Cc:     kan.liang@linux.intel.com, dave.hansen@linux.intel.com,
        x86@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        mingo@redhat.com, andriy.shevchenko@linux.intel.com, bp@suse.de,
        peterz@infradead.org, qiuxu.zhuo@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        srinivas.pandruvada@linux.intel.com, david.e.box@intel.com,
        rajneesh.bhardwaj@linux.intel.com
Reply-To: mingo@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          x86@kernel.org, kan.liang@linux.intel.com,
          dave.hansen@linux.intel.com, srinivas.pandruvada@linux.intel.com,
          hpa@zytor.com, rajneesh.bhardwaj@linux.intel.com,
          david.e.box@intel.com, bp@suse.de,
          andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
          qiuxu.zhuo@intel.com, peterz@infradead.org
In-Reply-To: <20190214115712.19642-2-rajneesh.bhardwaj@linux.intel.com>
References: <20190214115712.19642-2-rajneesh.bhardwaj@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/CPU: Add Icelake model number
Git-Commit-ID: 8cd8f0ce0d6aafe661cb3d6781c8b82bc696c04d
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

Commit-ID:  8cd8f0ce0d6aafe661cb3d6781c8b82bc696c04d
Gitweb:     https://git.kernel.org/tip/8cd8f0ce0d6aafe661cb3d6781c8b82bc696c04d
Author:     Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
AuthorDate: Thu, 14 Feb 2019 17:27:08 +0530
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 14 Feb 2019 13:18:30 +0100

x86/CPU: Add Icelake model number

Add the CPUID model number of Icelake (ICL) mobile processors to the
Intel family list. Icelake U/Y series uses model number 0x7E.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "David E. Box" <david.e.box@intel.com>
Cc: dvhart@infradead.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190214115712.19642-2-rajneesh.bhardwaj@linux.intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index d9a9993af882..9f15384c504a 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -52,6 +52,8 @@
 
 #define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
 
+#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
