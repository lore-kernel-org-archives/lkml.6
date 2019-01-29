Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE7C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDB9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfA2PuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:50:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfA2PuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:50:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0TFmuKv1998206
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 07:48:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0TFmt9q1998202;
        Tue, 29 Jan 2019 07:48:55 -0800
Date:   Tue, 29 Jan 2019 07:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-00ae831dfe4474ef6029558f5eb3ef0332d80043@git.kernel.org>
Cc:     bp@suse.de, rajneesh.bhardwaj@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        megha.dey@linux.intel.com, mchehab@s-opensource.com,
        qiuxu.zhuo@intel.com, mingo@kernel.org, peterz@infradead.org,
        aris@redhat.com, tony.luck@intel.com,
        andriy.shevchenko@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, tglx@linutronix.de,
        kan.liang@linux.intel.com, x86@kernel.org
Reply-To: kan.liang@linux.intel.com, x86@kernel.org,
          linux-edac@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          andriy.shevchenko@linux.intel.com, tony.luck@intel.com,
          aris@redhat.com, peterz@infradead.org, megha.dey@linux.intel.com,
          linux-kernel@vger.kernel.org, mingo@redhat.com,
          mchehab@s-opensource.com, mingo@kernel.org, qiuxu.zhuo@intel.com,
          rajneesh.bhardwaj@intel.com, bp@suse.de
In-Reply-To: <20190125195902.17109-4-tony.luck@intel.com>
References: <20190125195902.17109-4-tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu: Add Atom Tremont (Jacobsville)
Git-Commit-ID: 00ae831dfe4474ef6029558f5eb3ef0332d80043
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

Commit-ID:  00ae831dfe4474ef6029558f5eb3ef0332d80043
Gitweb:     https://git.kernel.org/tip/00ae831dfe4474ef6029558f5eb3ef0332d80043
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 25 Jan 2019 11:59:01 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 29 Jan 2019 16:37:35 +0100

x86/cpu: Add Atom Tremont (Jacobsville)

Add the Atom Tremont model number to the Intel family list.

[ Tony: Also update comment at head of file to say "_X" suffix is
  also used for microserver parts. ]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Megha Dey <megha.dey@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190125195902.17109-4-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0dd6b0f4000e..d9a9993af882 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -6,7 +6,7 @@
  * "Big Core" Processors (Branded as Core, Xeon, etc...)
  *
  * The "_X" parts are generally the EP and EX Xeons, or the
- * "Extreme" ones, like Broadwell-E.
+ * "Extreme" ones, like Broadwell-E, or Atom microserver.
  *
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
@@ -71,6 +71,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C /* Apollo Lake */
 #define INTEL_FAM6_ATOM_GOLDMONT_X	0x5F /* Denverton */
 #define INTEL_FAM6_ATOM_GOLDMONT_PLUS	0x7A /* Gemini Lake */
+#define INTEL_FAM6_ATOM_TREMONT_X	0x86 /* Jacobsville */
 
 /* Xeon Phi */
 
