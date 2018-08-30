Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE688C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C208205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C208205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeH3U4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:48788 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbeH3U4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="253213413"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 30 Aug 2018 09:52:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31A8925F; Thu, 30 Aug 2018 19:52:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/7] mfd: Convert Intel PMIC drivers to use SPDX identifier
Date:   Thu, 30 Aug 2018 19:52:54 +0300
Message-Id: <20180830165255.43114-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce size of duplicated comments by switching to use SPDX identifier.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_msic.c                 |  5 +----
 drivers/mfd/intel_soc_pmic_bxtwc.c       | 10 +---------
 drivers/mfd/intel_soc_pmic_chtdc_ti.c    |  5 +----
 drivers/mfd/intel_soc_pmic_chtwc.c       |  5 +----
 drivers/mfd/intel_soc_pmic_core.c        | 12 ++----------
 drivers/mfd/intel_soc_pmic_core.h        | 12 ++----------
 drivers/mfd/intel_soc_pmic_crc.c         | 12 ++----------
 include/linux/mfd/intel_msic.h           |  7 ++-----
 include/linux/mfd/intel_soc_pmic.h       | 12 ++----------
 include/linux/mfd/intel_soc_pmic_bxtwc.h | 10 +---------
 10 files changed, 15 insertions(+), 75 deletions(-)

diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index 441de7b3d231..bb24c2a07900 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Intel MSIC
  *
  * Copyright (C) 2011, Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index c878724497a9..6310c3bdb991 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MFD core driver for Intel Broxton Whiskey Cove PMIC
  *
  * Copyright (C) 2015 Intel Corporation. All rights reserved.
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
 
 #include <linux/acpi.h>
diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 861277c6580a..64b5c3cc30e7 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device access for Dollar Cove TI PMIC
  *
@@ -6,10 +7,6 @@
  *
  * Cleanup and forward-ported
  *   Copyright (c) 2017 Takashi Iwai <tiwai@suse.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index b35da01d5bcf..64a3aece9c5e 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MFD core driver for Intel Cherrytrail Whiskey Cove PMIC
  *
@@ -5,10 +6,6 @@
  *
  * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
  * Copyright (C) 2013-2015 Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 170d5ed16a3b..c9f35378d391 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * intel_soc_pmic_core.c - Intel SoC PMIC MFD Driver
+ * Intel SoC PMIC MFD Driver
  *
  * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
diff --git a/drivers/mfd/intel_soc_pmic_core.h b/drivers/mfd/intel_soc_pmic_core.h
index 90a1416d4dac..d490685845eb 100644
--- a/drivers/mfd/intel_soc_pmic_core.h
+++ b/drivers/mfd/intel_soc_pmic_core.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * intel_soc_pmic_core.h - Intel SoC PMIC MFD Driver
+ * Intel SoC PMIC MFD Driver
  *
  * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 5ac6f3710294..b6ab72fa0569 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * intel_soc_pmic_crc.c - Device access for Crystal Cove PMIC
+ * Device access for Crystal Cove PMIC
  *
  * Copyright (C) 2013, 2014 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
diff --git a/include/linux/mfd/intel_msic.h b/include/linux/mfd/intel_msic.h
index 439a7a617bc9..317e8608cf41 100644
--- a/include/linux/mfd/intel_msic.h
+++ b/include/linux/mfd/intel_msic.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * include/linux/mfd/intel_msic.h - Core interface for Intel MSIC
+ * Core interface for Intel MSIC
  *
  * Copyright (C) 2011, Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __LINUX_MFD_INTEL_MSIC_H__
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index 806a4f095312..ed1dfba5e5f9 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * intel_soc_pmic.h - Intel SoC PMIC Driver
+ * Intel SoC PMIC Driver
  *
  * Copyright (C) 2012-2014 Intel Corporation. All rights reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Author: Yang, Bin <bin.yang@intel.com>
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
diff --git a/include/linux/mfd/intel_soc_pmic_bxtwc.h b/include/linux/mfd/intel_soc_pmic_bxtwc.h
index 0c351bc85d2d..9be566cc58c6 100644
--- a/include/linux/mfd/intel_soc_pmic_bxtwc.h
+++ b/include/linux/mfd/intel_soc_pmic_bxtwc.h
@@ -1,16 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Header file for Intel Broxton Whiskey Cove PMIC
  *
  * Copyright (C) 2015 Intel Corporation. All rights reserved.
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
 
 #ifndef __INTEL_BXTWC_H__
-- 
2.18.0

