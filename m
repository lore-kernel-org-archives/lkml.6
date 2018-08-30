Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9714420661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9714420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeH3Uwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:52:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:43850 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeH3Uwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:52:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:49:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="253212380"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2018 09:49:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5FBF0110; Thu, 30 Aug 2018 19:49:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] MAINTAINERS: Add myself as designated reviewer of Intel PMIC GPIO
Date:   Thu, 30 Aug 2018 19:49:35 +0300
Message-Id: <20180830164935.42791-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few Intel PMIC GPIO device drivers which I would like
to review.

Note, Intel MSIC is old system controller that based mostly on PMIC
integrated in it. Thus, I included it as well.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cbbeee75ebb9..3031d76abaab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7358,6 +7358,12 @@ T:	git https://github.com/intel/gvt-linux.git
 S:	Supported
 F:	drivers/gpu/drm/i915/gvt/
 
+INTEL PMIC GPIO DRIVER
+R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+S:	Maintained
+F:	drivers/gpio/gpio-*cove.c
+F:	drivers/gpio/gpio-msic.c
+
 INTEL HID EVENT DRIVER
 M:	Alex Hung <alex.hung@canonical.com>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.18.0

