Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514876-2-16506698682625539855
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514876; b=lAQDfAcmU9t+Yj4zG5EyejD3yR3CzjafPlshCXAwrh7ccV/
    iKBfZ7ZmMfinfaKkydtL+fMbiOL3q7oVImXK1j/9rYC1VuMShNms7iq/lm62jiXf
    w7bbwJOIiuiR+lHqzrebKd/7BanZUmR4IaX7sYdmRF4pUbgltnqnkcPpZUQV6hK9
    as6Wk5UCxlE6hKOVsBXzgrA3ayWClr7G9ofTiASgR+VKX9AF8fLlwcS3QyyGM8md
    NX5lyCPrYUAfVxVi19x9FSu69C6l8AuIL2fO/Db501H8W0Ye57UGYprP74+ss+Eh
    NhDDgMd5KSifIeB8+Kvt0fQYpIQSU3vj2ydpxTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514876;
    bh=JSy94qwFdjB6l8UBxZN8ovcCp5pqTJt1x6lni9UDrP8=; b=T05YlXAwK+c+
    iL+PepCsr43bQ/h0ocmfwuJI9JDufQaSCkFMWmPYv1QZXI0bfTaTiaFPdrQ4sTA8
    h9ZOV013SGyR5co3zPPejU4sXkznUAgITJ9+XsJEuXyAsZwxuZ4WzTziasPrP7NQ
    HiNU/sjxMkbNqzMp8WsIC/lV7J4LS/LLrXqs9iajWQq6ODZb4ckOLOXTSPvgNEVZ
    P8XFnr14g9ZesBEL08J2gTr9ks9jzZnzbrLnaEjwp0hzDYYoxc8vopNlOyERnDOy
    zF0KX+FIZOqp7jIeRiEuIo4wbpwC03tqyUkHG8lfDpOj/BDkSMEmTRkCxpW19mwv
    nS9VP1M9Og==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934763AbeBMJft (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:35:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:27121 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934370AbeBMJfp (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889565"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v4 12/24] fpga: dfl: fme: add FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Date: Tue, 13 Feb 2018 17:24:41 +0800
Message-Id: <1518513893-4719-13-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

FPGA_GET_API_VERSION and FPGA_CHECK_EXTENSION ioctls are common ones which
need to be supported by all feature devices drivers including FME and AFU.
Userspace application can use these ioctl interfaces to get the API info
and check if specific extension is supported or not in current driver.

This patch implements above 2 ioctls in FPGA Management Engine (FME)
driver.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: switched to GPLv2 license.
v3: rename intel-fpga.h to fpga-dfl.h and rebased.
v4: fix SPDX license issue.
    add Acked-by from Alan and Moritz.
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 drivers/fpga/dfl-fme-main.c          | 12 +++++++++
 include/uapi/linux/fpga-dfl.h        | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 include/uapi/linux/fpga-dfl.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 6501389..f1e7baa 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -324,6 +324,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB3	00	linux/mmc/ioctl.h
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
+0xB6	all	linux/fpga-dfl.h
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
 0xCA	10-2F	uapi/misc/ocxl.h
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 056ae24..1a9929c 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl.h"
 
@@ -114,6 +115,13 @@ static struct feature_driver fme_feature_drvs[] = {
 	},
 };
 
+static long fme_ioctl_check_extension(struct feature_platform_data *pdata,
+				      unsigned long arg)
+{
+	/* No extension support for now */
+	return 0;
+}
+
 static int fme_open(struct inode *inode, struct file *filp)
 {
 	struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
@@ -154,6 +162,10 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
 	switch (cmd) {
+	case FPGA_GET_API_VERSION:
+		return FPGA_API_VERSION;
+	case FPGA_CHECK_EXTENSION:
+		return fme_ioctl_check_extension(pdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
new file mode 100644
index 0000000..9321ee9
--- /dev/null
+++ b/include/uapi/linux/fpga-dfl.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header File for FPGA DFL User API
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Zhang Yi <yi.z.zhang@intel.com>
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ */
+
+#ifndef _UAPI_LINUX_FPGA_DFL_H
+#define _UAPI_LINUX_FPGA_DFL_H
+
+#define FPGA_API_VERSION 0
+
+/*
+ * The IOCTL interface for DFL based FPGA is designed for extensibility by
+ * embedding the structure length (argsz) and flags into structures passed
+ * between kernel and userspace. This design referenced the VFIO IOCTL
+ * interface (include/uapi/linux/vfio.h).
+ */
+
+#define FPGA_MAGIC 0xB6
+
+#define FPGA_BASE 0
+
+/**
+ * FPGA_GET_API_VERSION - _IO(FPGA_MAGIC, FPGA_BASE + 0)
+ *
+ * Report the version of the driver API.
+ * Return: Driver API Version.
+ */
+
+#define FPGA_GET_API_VERSION	_IO(FPGA_MAGIC, FPGA_BASE + 0)
+
+/**
+ * FPGA_CHECK_EXTENSION - _IO(FPGA_MAGIC, FPGA_BASE + 1)
+ *
+ * Check whether an extension is supported.
+ * Return: 0 if not supported, otherwise the extension is supported.
+ */
+
+#define FPGA_CHECK_EXTENSION	_IO(FPGA_MAGIC, FPGA_BASE + 1)
+
+#endif /* _UAPI_LINUX_FPGA_DFL_H */
-- 
2.7.4

