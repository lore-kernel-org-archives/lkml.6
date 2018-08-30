Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C051C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F31205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F31205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeH3U4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:63534 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeH3U4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="70357397"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2018 09:52:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C99926D; Thu, 30 Aug 2018 19:52:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/7] MAINTAINERS: Add myself as designated reviewer of Intel MFD PMIC
Date:   Thu, 30 Aug 2018 19:52:55 +0300
Message-Id: <20180830165255.43114-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few Intel MFD PMIC device drivers which I would like
to review.

Note, Intel MSIC is old system controller that based mostly on PMIC
integrated in it. Thus, I included it as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a340f680230..cbbeee75ebb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7484,6 +7484,14 @@ F:	drivers/platform/x86/intel_punit_ipc.c
 F:	arch/x86/include/asm/intel_pmc_ipc.h
 F:	arch/x86/include/asm/intel_punit_ipc.h
 
+INTEL MULTIFUNCTION PMIC DEVICE DRIVERS
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+S:	Maintained
+F:	drivers/mfd/intel_msic.c
+F:	drivers/mfd/intel_soc_pmic*
+F:	include/linux/mfd/intel_msic.h
+F:	include/linux/mfd/intel_soc_pmic*
+
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
 M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
 L:	linux-wireless@vger.kernel.org
-- 
2.18.0

