Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D45C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2321530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F2321530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeIZXHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:07:18 -0400
Received: from mga18.intel.com ([134.134.136.126]:30890 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbeIZXHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:07:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="83447670"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2018 09:52:25 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g5D32-00055C-Ct; Wed, 26 Sep 2018 19:52:24 +0300
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
Subject: [PATCH v1 19/28] platform/x86: intel-rst: Sort headers alphabetically
Date:   Wed, 26 Sep 2018 19:52:14 +0300
Message-Id: <20180926165223.19390-19-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926165223.19390-1-andriy.shevchenko@linux.intel.com>
References: <20180926165223.19390-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers alphabetically for better maintenance.

No functional change.

While here, remove unneeded linux/init.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel-rst.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-rst.c b/drivers/platform/x86/intel-rst.c
index 7344d841f4d9..56abf5cbb824 100644
--- a/drivers/platform/x86/intel-rst.c
+++ b/drivers/platform/x86/intel-rst.c
@@ -17,10 +17,9 @@
  */
 
 
-#include <linux/init.h>
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/acpi.h>
 
 MODULE_LICENSE("GPL");
 
-- 
2.19.0

