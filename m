Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B08AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D3208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6D3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeH0TXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:23:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:35840 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbeH0TXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:23:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 08:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="78711997"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2018 08:36:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A6E32232; Mon, 27 Aug 2018 18:35:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] extcon: cht-wc: Convert to use SPDX identifier
Date:   Mon, 27 Aug 2018 18:35:56 +0300
Message-Id: <20180827153557.58363-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
References: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use SPDX identifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index ad1fd70e4023..5ef215297101 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Extcon charger detection driver for Intel Cherrytrail Whiskey Cove PMIC
  * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
  *
  * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
  * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #include <linux/extcon-provider.h>
-- 
2.18.0

