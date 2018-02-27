Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeB0P5H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:57:07 -0500
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:16540 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932234AbeB0P5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:57:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GKAAAGf5Vahz+a6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKJt1gxiWPwqFMgKCTFgUAQIBAQEBAQECAQIQAQEBCgsJCCg?=
 =?us-ascii?q?vgjgkAYJIAwN5ED8SVwYBEoUVrVqIcIIUAQEIKIdKgVeQIwWOZotoCYILjmYCj?=
 =?us-ascii?q?nKRUIEuNYFzcIMSglMiggRYjFIBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GKAAAGf5Vahz+a6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKJt1gxiWPwqFMgKCTFgUAQIBAQEBAQECAQIQAQEBCgsJCCgvgjgkAYJIAwN5E?=
 =?us-ascii?q?D8SVwYBEoUVrVqIcIIUAQEIKIdKgVeQIwWOZotoCYILjmYCjnKRUIEuNYFzcIM?=
 =?us-ascii?q?SglMiggRYjFIBAQE?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,401,1515477600";
   d="scan'208";a="623642154"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 2/3] platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base
Date: Tue, 27 Feb 2018 09:56:53 -0600
Message-Id: <1519747014-17561-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
References: <1519747014-17561-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is being done to faciliate a later change to link all the dell-smbios
drivers together.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/platform/x86/Makefile                              | 1 +
 drivers/platform/x86/{dell-smbios.c => dell-smbios-base.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/platform/x86/{dell-smbios.c => dell-smbios-base.c} (100%)

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index c388608..940b118 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
 obj-$(CONFIG_DELL_SMBIOS)	+= dell-smbios.o
+dell-smbios-objs		:= dell-smbios-base.o
 obj-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
 obj-$(CONFIG_DELL_SMBIOS_SMM)	+= dell-smbios-smm.o
 obj-$(CONFIG_DELL_LAPTOP)	+= dell-laptop.o
diff --git a/drivers/platform/x86/dell-smbios.c b/drivers/platform/x86/dell-smbios-base.c
similarity index 100%
rename from drivers/platform/x86/dell-smbios.c
rename to drivers/platform/x86/dell-smbios-base.c
-- 
2.7.4
