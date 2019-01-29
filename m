Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B4C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C342C2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfA2Jji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:39:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:32842 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfA2Jie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:38:34 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F03F82761E1
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 01/12] platform/chrome: cromeos_pstore: switch to SPDX identifier
Date:   Tue, 29 Jan 2019 10:38:12 +0100
Message-Id: <20190129093823.27137-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129093823.27137-1-enric.balletbo@collabora.com>
References: <20190129093823.27137-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management. Also fix the module license mismatch and change the term
'Chrome OS' for 'ChromeOS' to be coherent with other drivers.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---

Changes in v3:
- Add Reviewed-by tags.

Changes in v2:
- Removed the patches that removed the unnused includes (were wrong).
- Add patches for all files in platform/chrome that didn't switch yet.

 drivers/platform/chrome/chromeos_pstore.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index b0693fdec8c6..d13770785fb5 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -1,12 +1,7 @@
-/*
- *  chromeos_pstore.c - Driver to instantiate Chromebook ramoops device
- *
- *  Copyright (C) 2013 Google, Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, version 2 of the License.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Driver to instantiate Chromebook ramoops device.
+//
+// Copyright (C) 2013 Google, Inc.
 
 #include <linux/acpi.h>
 #include <linux/dmi.h>
@@ -138,5 +133,5 @@ static void __exit chromeos_pstore_exit(void)
 module_init(chromeos_pstore_init);
 module_exit(chromeos_pstore_exit);
 
-MODULE_DESCRIPTION("Chrome OS pstore module");
-MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("ChromeOS pstore module");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

