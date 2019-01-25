Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D1C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF742133F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfAYT7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:59:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:12808 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfAYT7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:59:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 11:59:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="117510329"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2019 11:59:02 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] x86: intel-family.h: Add Atom Tremont (Jacobsville)
Date:   Fri, 25 Jan 2019 11:59:01 -0800
Message-Id: <20190125195902.17109-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125195902.17109-1-tony.luck@intel.com>
References: <20190125195902.17109-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add CPUID of Atom Tremont processor to Intel family list.

[Tony: Also update comment at head of file to say "_X" suffix is
 also used for microserver parts]

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
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
 
-- 
2.19.1

