Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BEEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66870205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66870205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJQAwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:52:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:15655 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbeJQAwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:52:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 10:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,389,1534834800"; 
   d="scan'208";a="100736210"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2018 10:00:58 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Moger, Babu" <Babu.Moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        "Arshiya Hayatkhan Pathan" <arshiya.hayatkhan.pathan@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 7/7] selftests/resctrl: Add the test in MAINTAINERS
Date:   Tue, 16 Oct 2018 09:56:41 -0700
Message-Id: <1539709001-38018-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The resctrl selftests will be maintained by RDT maintainers.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ac000cc006d..07d597c68edc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12271,6 +12271,7 @@ S:	Supported
 F:	arch/x86/kernel/cpu/intel_rdt*
 F:	arch/x86/include/asm/intel_rdt_sched.h
 F:	Documentation/x86/intel_rdt*
+F:	tools/testing/selftests/resctrl
 
 READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
-- 
2.5.0

