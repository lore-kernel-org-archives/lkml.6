Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518514762-2-362927084026434360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518514761; b=MmsykjxR9vCgFKEDR0DzVVROpIoxwVVsJpd2nqZlGRgkPHU
    1cgQra0CiP8DyjGFNIlEwXYJ46puNNMiJFmTI3VwYKF3bFG8+FMizH4IsHJVa5Fp
    zzxA7IEtW24aIsmXUQgJTjccqh3f+YhdnAtMEFljXYBVvgoOmE7d0giMWmhy1pAL
    O76gk/kLOtxW1zCW9F5rw7JHpqkoGcUCqmm7ifDg05FHd68w307SxhDA1H0wBM7E
    lAY7xxVyq6PQS0GNHIK2+S7a5OirBDFGKfH9UiBxkWERhzYoNy0RB5n11cvylG67
    8rlSqNJL6SH425egO/JdpPpygPbL4f8LRDX+vzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514761;
    bh=pZptMa4zNRqcDQdExM7kRBtHAvMh3x3rU6xRyPqk4VI=; b=f3UInM+764E5
    mGybalmx+E76hNj3ZtTZbIYsPEzJAesFUmr55vb0ojHx0wZgZ/xHK+CP/jf2HbJ+
    xAN1RHGFIse9CE4fQSzWhto/TcfHTaByTs/W41z7f09YoHbpH6CN3I3PavEAnsUQ
    jvRON57ePsrFw+4/r+zwHbNcYojUnjkAsaJY+9k84OkO8zZsRFCpQFv0VJw5vKOK
    CIP3lDVS5S3Ms+An+eac2N7cJD2QUi7trtz5MiQ8sL99Ruc0+zCBbOzUv8CRlVrK
    qHY+zZ2tI2jeDCW2FIcYTaZ5bZYZXTsTgmfRbxO8r3ee+tsNhy/q5WgityO2EjM2
    lcEUvuMkMg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934821AbeBMJgG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:36:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:27128 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934370AbeBMJf5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889615"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>
Subject: [PATCH v4 18/24] fpga: dfl: add fpga region platform driver for FME
Date: Tue, 13 Feb 2018 17:24:47 +0800
Message-Id: <1518513893-4719-19-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds fpga region platform driver for FPGA Management Engine.
It register an fpga region with given fpga manager / bridge device.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v3: rename driver to fpga-dfl-fme-region
    fix fpga_mgr_put order problem in remove function.
    rebased due to fpga api changes.
v4: rename to dfl-fme-region, fix SPDX license issue
    include dfl-fme-pr.h instead of dfl-fme.h and dfl.h
    add Acked-by from Alan and Moritz
---
 drivers/fpga/Kconfig          |  6 +++
 drivers/fpga/Makefile         |  1 +
 drivers/fpga/dfl-fme-region.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/fpga/dfl-fme-region.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index a8f939a..65d54a4 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -162,6 +162,12 @@ config FPGA_DFL_FME_BRIDGE
 	help
 	  Say Y to enable FPGA Bridge driver for FPGA Management Engine.
 
+config FPGA_DFL_FME_REGION
+	tristate "FPGA DFL FME Region Driver"
+	depends on FPGA_DFL_FME
+	help
+	  Say Y to enable FPGA Region driver for FPGA Management Engine.
+
 config FPGA_DFL_PCI
 	tristate "FPGA Device Feature List (DFL) PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 75096e9..163894e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_FPGA_DFL)			+= dfl.o
 obj-$(CONFIG_FPGA_DFL_FME)		+= dfl-fme.o
 obj-$(CONFIG_FPGA_DFL_FME_MGR)		+= dfl-fme-mgr.o
 obj-$(CONFIG_FPGA_DFL_FME_BRIDGE)	+= dfl-fme-br.o
+obj-$(CONFIG_FPGA_DFL_FME_REGION)	+= dfl-fme-region.o
 
 dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o
 
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
new file mode 100644
index 0000000..1f5f33d
--- /dev/null
+++ b/drivers/fpga/dfl-fme-region.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Region Driver for FPGA Management Engine (FME)
+ *
+ * Copyright (C) 2017 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Joseph Grecco <joe.grecco@intel.com>
+ *   Enno Luebbers <enno.luebbers@intel.com>
+ *   Tim Whisonant <tim.whisonant@intel.com>
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Henry Mitchel <henry.mitchel@intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fpga/fpga-region.h>
+
+#include "dfl-fme-pr.h"
+
+static int fme_region_get_bridges(struct fpga_region *region)
+{
+	struct fme_region_pdata *pdata = region->priv;
+	struct device *dev = &pdata->br->dev;
+
+	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
+}
+
+static int fme_region_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct fme_region_pdata *pdata = dev_get_platdata(dev);
+	struct fpga_region *region;
+	struct fpga_manager *mgr;
+	int ret;
+
+	mgr = fpga_mgr_get(&pdata->mgr->dev);
+	if (IS_ERR(mgr))
+		return -EPROBE_DEFER;
+
+	region = devm_kzalloc(dev, sizeof(*region), GFP_KERNEL);
+	if (!region) {
+		ret = -ENOMEM;
+		goto eprobe_mgr_put;
+	}
+
+	region->mgr = mgr;
+	region->get_bridges = fme_region_get_bridges;
+	region->priv = pdata;
+	region->parent = dev;
+	platform_set_drvdata(pdev, region);
+
+	ret = fpga_region_register(region);
+	if (ret)
+		goto eprobe_mgr_put;
+
+	dev_dbg(dev, "DFL FME FPGA Region probed\n");
+
+	return 0;
+
+eprobe_mgr_put:
+	fpga_mgr_put(mgr);
+	return ret;
+}
+
+static int fme_region_remove(struct platform_device *pdev)
+{
+	struct fpga_region *region = dev_get_drvdata(&pdev->dev);
+
+	fpga_region_unregister(region);
+	fpga_mgr_put(region->mgr);
+
+	return 0;
+}
+
+static struct platform_driver fme_region_driver = {
+	.driver	= {
+		.name    = FPGA_DFL_FME_REGION,
+	},
+	.probe   = fme_region_probe,
+	.remove  = fme_region_remove,
+};
+
+module_platform_driver(fme_region_driver);
+
+MODULE_DESCRIPTION("FPGA Region for DFL FPGA Management Engine");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:dfl-fme-region");
-- 
2.7.4

