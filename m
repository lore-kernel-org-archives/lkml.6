Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeB0SXP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 13:23:15 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:39198 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751671AbeB0SXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 13:23:12 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GKAAAFoZVamMuZ6EReGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYUmKJt1gxiWPwqFMgKCTFgUAQIBAQEBAQECAQIQAQEBAQEGDQs?=
 =?us-ascii?q?GKC+COCQBgkgDA3kQPxJXBgEShRWuS4hwghYBAQgoh0qBV5AjBY5mi2gJgguOZ?=
 =?us-ascii?q?gKOcpFQgS41gXNwgxKCUyKCBFiMUgEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2GKAAAFoZVamMuZ6EReGQEBAQEBAQEBAQEBAQcBAQEBAYU?=
 =?us-ascii?q?mKJt1gxiWPwqFMgKCTFgUAQIBAQEBAQECAQIQAQEBAQEGDQsGKC+COCQBgkgDA?=
 =?us-ascii?q?3kQPxJXBgEShRWuS4hwghYBAQgoh0qBV5AjBY5mi2gJgguOZgKOcpFQgS41gXN?=
 =?us-ascii?q?wgxKCUyKCBFiMUgEBAQ?=
X-LoopCount0: from 10.208.86.39
X-IronPort-AV: E=Sophos;i="5.47,402,1515477600";
   d="scan'208";a="140764455"
X-DLP: DLP_GlobalPCIDSS
From: Mario Limonciello <mario.limonciello@dell.com>
To: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: pali.rohar@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 2/3] platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base
Date: Tue, 27 Feb 2018 12:23:03 -0600
Message-Id: <1519755784-2155-2-git-send-email-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
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
