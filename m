Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6A6214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:03:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6A6214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbeKVBia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:38:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40551 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeKVBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:38:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF3SWB3416973
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:03:28 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF3SZU3416970;
        Wed, 21 Nov 2018 07:03:28 -0800
Date:   Wed, 21 Nov 2018 07:03:28 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-83kcyqa1qkxkhm1s7q3hbpel@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
        fenghua.yu@intel.com, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: fenghua.yu@intel.com, tglx@linutronix.de,
          adrian.hunter@intel.com, mingo@kernel.org, dsahern@gmail.com,
          wangnan0@huawei.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools arch x86: Update tools's copy of
 cpufeatures.h
Git-Commit-ID: 65e259d5c4ae425f7c80e40b838eba1b9e8608fd
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

Commit-ID:  65e259d5c4ae425f7c80e40b838eba1b9e8608fd
Gitweb:     https://git.kernel.org/tip/65e259d5c4ae425f7c80e40b838eba1b9e8608fd
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Nov 2018 12:27:07 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Nov 2018 12:27:07 -0800

tools arch x86: Update tools's copy of cpufeatures.h

To get the changes in the following csets:

  ace6485a0326 ("x86/cpufeatures: Enumerate MOVDIR64B instruction")
  33823f4d63f7 ("x86/cpufeatures: Enumerate MOVDIRI instruction")

No tools were affected, copy it to silence this perf tool build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Link: https://lkml.kernel.org/n/tip-83kcyqa1qkxkhm1s7q3hbpel@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 89a048c2faec..28c4a502b419 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -331,6 +331,8 @@
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
