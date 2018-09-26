Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7CEECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B8121530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8121530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeIZXIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:08:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:28770 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbeIZXIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:08:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="266910446"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2018 09:52:25 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g5D32-00054c-6S; Wed, 26 Sep 2018 19:52:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 01/28] platform/x86: intel_bxtwc_tmu: Convert to use SPDX identifier
Date:   Wed, 26 Sep 2018 19:51:56 +0300
Message-Id: <20180926165223.19390-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce size of duplicated comments by switching to use SPDX identifier.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_bxtwc_tmu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
index 227943a20212..951c105bafc1 100644
--- a/drivers/platform/x86/intel_bxtwc_tmu.c
+++ b/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -1,21 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * intel_bxtwc_tmu.c - Intel BXT Whiskey Cove PMIC TMU driver
+ * Intel BXT Whiskey Cove PMIC TMU driver
  *
  * Copyright (C) 2016 Intel Corporation. All rights reserved.
  *
  * This driver adds TMU (Time Management Unit) support for Intel BXT platform.
  * It enables the alarm wake-up functionality in the TMU unit of Whiskey Cove
  * PMIC.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/module.h>
-- 
2.19.0

