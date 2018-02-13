Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514772-2-12985016238144431414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514771; b=BEtT5kNbktvOflALe3ANhXecsHU+suniNtnD4t0lfFTgtal
    sr7t5gKWQxK0VdHPc4ZI8y1TpqeC1T/2ah1nSsWnr0J4VkmfJXlTvqmIWt0Qx5E9
    njjJo5ShuUfZ3uC7GSHwOvTbYEdO6t183mq2tYLvy0Q00ybzb+XEglbkq2XeH4n3
    +TpJ+jMQzRLxL8wNwmN5dHdnrHev1hphNe9jn2ofz8EqPnMNRumu6zhn3cia9nZy
    Q7sfEmJDSlTSV+WZku8Y3PHVHdG98tLHKnmOVG4QEpZhAYrm7pQIixVLkDHjYdx/
    jh4MsMHzdDahOmlotZj4PzhR3SY/eoZQfQnGsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514771;
    bh=1+9SU8FYn4Q3lJjfzPivvz4AI+d3WPZJuaSJaSDe/LQ=; b=N0Z55sPSSAT8
    7IlXr2WIhsYNxX2ngBkqMEpZkstNX+hc5jUuYieczbgvOt7OE7eSTJ90LmYUz5Bg
    Y8TmkltXzg973IPyeI5BfqOwghn+h9vgFqW4CA9o2G/wOnW4iqqhBcsOAJQ/7VrU
    ahuFB6y+AaSy4HM9c325xZfSg9QgSvvx9jAucMea20m+UV6/tcBfGchRTUSUT0hs
    FLAL8Hm0lT/RPFQ2Rm0JCE9qtP140nSakVEB+hYbj28oo7Ahq5SXOccvJySHpM3z
    DlpPwQQLMZcLSCGCM28FI7tvYtpcMhEBVD8rvXukZyxDN6IX5yNWAEPzQaomqlZc
    F1nsq8Rvxw==
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
        id S934534AbeBMJgF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:36:05 -0500
Received: from mga03.intel.com ([134.134.136.65]:27146 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933937AbeBMJgB (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:36:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889628"
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
Subject: [PATCH v4 20/24] fpga: dfl: add FPGA Accelerated Function Unit driver basic framework
Date: Tue, 13 Feb 2018 17:24:49 +0800
Message-Id: <1518513893-4719-21-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On DFL FPGA devices, the Accelerated Function Unit (AFU), can be
reprogrammed for different functions. It connects to the FPGA
infrastructure("blue bistream") via a Port. Port CSRs are implemented
separately from the AFU CSRs to provide control and status of the Port.
Once valid green bitstream is programmed into the AFU, it allows access
to the AFU CSRs in the AFU MMIO space.

This patch only implements basic driver framework for AFU, including
device file operation framework.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: rename driver to dfl-afu-main.c
v4: rename to dfl-port and fix SPDX license issue.
---
 drivers/fpga/Kconfig        |   9 +++
 drivers/fpga/Makefile       |   2 +
 drivers/fpga/dfl-afu-main.c | 159 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/fpga/dfl-afu-main.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 65d54a4..4c6b45f 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -168,6 +168,15 @@ config FPGA_DFL_FME_REGION
 	help
 	  Say Y to enable FPGA Region driver for FPGA Management Engine.
 
+config FPGA_DFL_AFU
+	tristate "FPGA DFL AFU Driver"
+	depends on FPGA_DFL
+	help
+	  This is the driver for FPGA Accelerated Function Unit (AFU) which
+	  implements AFU and Port management features. A User AFU connects
+	  to the FPGA infrastructure via a Port. There may be more than 1
+	  Port/AFU per DFL based FPGA device.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 163894e..5c9607b 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -34,8 +34,10 @@ obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
 obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
+obj-$(CONFIG_FPGA_DFL_AFU)		+= dfl-afu.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
+dfl-afu-objs := dfl-afu-main.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
new file mode 100644
index 0000000..70db28c
--- /dev/null
+++ b/drivers/fpga/dfl-afu-main.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA Accelerated Function Unit (AFU)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
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
+static int port_hdr_init(struct platform_device *pdev, struct feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
+
+	return 0;
+}
+
+static void port_hdr_uinit(struct platform_device *pdev,
+			   struct feature *feature)
+{
+	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
+}
+
+static const struct feature_ops port_hdr_ops = {
+	.init = port_hdr_init,
+	.uinit = port_hdr_uinit,
+};
+
+static struct feature_driver port_feature_drvs[] = {
+	{
+		.id = PORT_FEATURE_ID_HEADER,
+		.ops = &port_hdr_ops,
+	},
+	{
+		.ops = NULL,
+	}
+};
+
+static int afu_open(struct inode *inode, struct file *filp)
+{
+	struct platform_device *fdev = fpga_inode_to_feature_dev(inode);
+	struct feature_platform_data *pdata;
+	int ret;
+
+	pdata = dev_get_platdata(&fdev->dev);
+	if (WARN_ON(!pdata))
+		return -ENODEV;
+
+	ret = feature_dev_use_begin(pdata);
+	if (ret)
+		return ret;
+
+	dev_dbg(&fdev->dev, "Device File Open\n");
+	filp->private_data = fdev;
+
+	return 0;
+}
+
+static int afu_release(struct inode *inode, struct file *filp)
+{
+	struct platform_device *pdev = filp->private_data;
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	dev_dbg(&pdev->dev, "Device File Release\n");
+
+	feature_dev_use_end(pdata);
+
+	return 0;
+}
+
+static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct platform_device *pdev = filp->private_data;
+	struct feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
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
+		fpga_dev_for_each_feature(pdata, f)
+			if (f->ops && f->ops->ioctl) {
+				ret = f->ops->ioctl(pdev, f, cmd, arg);
+				if (ret == -ENODEV)
+					continue;
+				else
+					return ret;
+			}
+	}
+
+	return -EINVAL;
+}
+
+static const struct file_operations afu_fops = {
+	.owner = THIS_MODULE,
+	.open = afu_open,
+	.release = afu_release,
+	.unlocked_ioctl = afu_ioctl,
+};
+
+static int afu_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	ret = fpga_dev_feature_init(pdev, port_feature_drvs);
+	if (ret)
+		return ret;
+
+	ret = fpga_register_dev_ops(pdev, &afu_fops, THIS_MODULE);
+	if (ret)
+		fpga_dev_feature_uinit(pdev);
+
+	return ret;
+}
+
+static int afu_remove(struct platform_device *pdev)
+{
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	fpga_dev_feature_uinit(pdev);
+	fpga_unregister_dev_ops(pdev);
+
+	return 0;
+}
+
+static struct platform_driver afu_driver = {
+	.driver	= {
+		.name    = FPGA_FEATURE_DEV_PORT,
+	},
+	.probe   = afu_probe,
+	.remove  = afu_remove,
+};
+
+module_platform_driver(afu_driver);
+
+MODULE_DESCRIPTION("FPGA Accelerated Function Unit driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-port");
-- 
2.7.4

