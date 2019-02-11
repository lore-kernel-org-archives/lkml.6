Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A03C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD2A20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfBKLEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:04:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:60089 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfBKLEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:04:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 03:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="145850439"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2019 03:04:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A6DFBE3; Mon, 11 Feb 2019 12:57:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINAINERS: Swap words in INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
Date:   Mon, 11 Feb 2019 12:57:10 +0200
Message-Id: <20190211105710.37800-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap PMIC and MULTIFUNCTION words in the title to:
- show that this is about Intel PMICs
- keep MAINTAINERS properly sorted

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9919840d54cd..918795d5eea6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7789,7 +7789,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git
 F:	drivers/gpio/gpio-*cove.c
 F:	drivers/gpio/gpio-msic.c
 
-INTEL MULTIFUNCTION PMIC DEVICE DRIVERS
+INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_msic.c
-- 
2.20.1

