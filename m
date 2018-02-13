Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514982-2-6494303694465627913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514981; b=otZJcn97h3JUW3hsdd7hvaKRrfGVO2pdKnZybPLQIxS0PXi
    KHbt2oy0MxFOwDwHUaCgA5+JxAxbD3ZHMP48SRodjS3l1mhs+ARtFscB7zMD178C
    LPszu3sHApABshX9vmAY5ARXSwNNF1HVkEgsim2m0KkrtCb9zJ2F8FdPpBOPZXBj
    mRp2EpkmNRG/REvEQUAg0xl13J9EjnukIrPHCa7/twkYbrLhVPWAvCwWfvgCjBbQ
    /Zxo+4aOYh4LbQrKr0bRNKoVMqxR3XWj/Q5EjdSePd9wRgRcFBZekxUjEIEQUA+f
    iFLz/LzGIZbwME/1bvcaY8OGuYJra6cwE50+1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514981;
    bh=QSZDhjkr8kFLaICS6I0JHG06PQTsybjco+pBb8yAeeU=; b=o8szAsPT673c
    yqWzl8ld9T3uZusBesfpHvi1t27DA2z6wK/yw4ys1+HbZOUmGGJNq+CHCgjgo1ZV
    h4ydxQ2jRaQZM+TwJEDy2POOslH9DQVNU6AaVQq/1YLcKNNjKRcGAQiG+1xtvvHh
    XSK9/9dp5UQccPNLg3YC7oT8qjcpg1C5LcLI75xOtDPhmE+onYLfeljAdx4RuMuS
    MPc67MHAYCloE5cpnXIxotSXkwcw7BPcMJTyjZNEnB7m/rG2AmoTcH+oUb2NHrbm
    FOeAMSrKmqHEfHbFuPxaxlZ5MJpG2DRnu1sPFMBpnmai/gQOssmVUcFVp7+G62vK
    /oBQMzMwsQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeBMJmk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:42:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:27128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934652AbeBMJfi (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889549"
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
Subject: [PATCH v4 10/24] fpga: dfl: add FPGA Management Engine driver basic framework
Date: Tue, 13 Feb 2018 17:24:39 +0800
Message-Id: <1518513893-4719-11-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kang Luwei <luwei.kang@intel.com>

The FPGA Management Engine (FME) provides power, thermal management,
performance counters, partial reconfiguration and other functions. For each
function, it is packaged into a private feature linked to the FME feature
device in the 'Device Feature List'. It's a platform device created by
DFL framework.

This patch adds the basic framework of FME platform driver. It defines
sub feature drivers to handle the different sub features, including init,
uinit and ioctl. It also registers the file operations for the device file.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: rename driver from intel-fpga-fme to dfl-fme
    rename Kconfig from INTEL_FPGA_FME to FPGA_DFL_FME
v4: fix SPDX license issue, use dfl-fme as module name
---
 drivers/fpga/Kconfig        |  10 +++
 drivers/fpga/Makefile       |   3 +
 drivers/fpga/dfl-fme-main.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-main.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 87f3d44..103d5e2 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -140,6 +140,16 @@ config FPGA_DFL
 	  Gate Array (FPGA) solutions which implement Device Feature List.
 	  It provides enumeration APIs, and feature device infrastructure.
 
+config FPGA_DFL_FME
+	tristate "FPGA DFL FME Driver"
+	depends on FPGA_DFL
+	help
+	  The FPGA Management Engine (FME) is a feature device implemented
+	  under Device Feature List (DFL) framework. Select this option to
+	  enable the platform device driver for FME which implements all
+	  FPGA platform level management features. There shall be 1 FME
+	  per DFL based FPGA device.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 4375630..fbd1c85 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -30,6 +30,9 @@ obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
 
 # FPGA Device Feature List Support
 obj-$(CONFIG_FPGA_DFL)			+= dfl.o
+obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
+
+dfl-fme-objs := dfl-fme-main.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
new file mode 100644
index 0000000..ebe6b52
--- /dev/null
+++ b/drivers/fpga/dfl-fme-main.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include "dfl.h"
+
+static int fme_hdr_init(struct platform_device *pdev, struct feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR Init.\n");
+
+	return 0;
+}
+
+static void fme_hdr_uinit(struct platform_device *pdev, struct feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
+}
+
+static const struct feature_ops fme_hdr_ops = {
+	.init = fme_hdr_init,
+	.uinit = fme_hdr_uinit,
+};
+
+static struct feature_driver fme_feature_drvs[] = {
+	{
+		.id = FME_FEATURE_ID_HEADER,
+		.ops = &fme_hdr_ops,
+	},
+	{
+		.ops = NULL,
+	},
+};
+
+static int fme_open(struct inode *inode, struct file *filp)
+{
+	struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
+	struct feature_platform_data *pdata = dev_get_platdata(&fdev->dev);
+	int ret;
+
+	if (WARN_ON(!pdata))
+		return -ENODEV;
+
+	ret = feature_dev_use_begin(pdata);
+	if (ret)
+		return ret;
+
+	dev_dbg(&fdev->dev, "Device File Open\n");
+	filp->private_data = pdata;
+
+	return 0;
+}
+
+static int fme_release(struct inode *inode, struct file *filp)
+{
+	struct feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+
+	dev_dbg(&pdev->dev, "Device File Release\n");
+	feature_dev_use_end(pdata);
+
+	return 0;
+}
+
+static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct feature_platform_data *pdata = filp->private_data;
+	struct platform_device *pdev = pdata->dev;
+	struct feature *f;
+	long ret;
+
+	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
+
+	switch (cmd) {
+	default:
+		/*
+		 * Let sub-feature's ioctl function to handle the cmd
+		 * Sub-feature's ioctl returns -ENODEV when cmd is not
+		 * handled in this sub feature, and returns 0 and other
+		 * error code if cmd is handled.
+		 */
+		fpga_dev_for_each_feature(pdata, f) {
+			if (f->ops && f->ops->ioctl) {
+				ret = f->ops->ioctl(pdev, f, cmd, arg);
+				if (ret == -ENODEV)
+					continue;
+				else
+					return ret;
+			}
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations fme_fops = {
+	.owner		= THIS_MODULE,
+	.open		= fme_open,
+	.release	= fme_release,
+	.unlocked_ioctl = fme_ioctl,
+};
+
+static int fme_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = fpga_dev_feature_init(pdev, fme_feature_drvs);
+	if (ret)
+		goto exit;
+
+	ret = fpga_register_dev_ops(pdev, &fme_fops, THIS_MODULE);
+	if (ret)
+		goto feature_uinit;
+
+	return 0;
+
+feature_uinit:
+	fpga_dev_feature_uinit(pdev);
+exit:
+	return ret;
+}
+
+static int fme_remove(struct platform_device *pdev)
+{
+	fpga_dev_feature_uinit(pdev);
+	fpga_unregister_dev_ops(pdev);
+
+	return 0;
+}
+
+static struct platform_driver fme_driver = {
+	.driver	= {
+		.name    = FPGA_FEATURE_DEV_FME,
+	},
+	.probe   = fme_probe,
+	.remove  = fme_remove,
+};
+
+module_platform_driver(fme_driver);
+
+MODULE_DESCRIPTION("FPGA Management Engine driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme");
-- 
2.7.4

