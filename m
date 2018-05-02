Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230505-2-5055516430105259605
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230504; b=CoBLn3HWI21jkHoJB1OiE5cWVZdLBY92vuysiWEVI/wUI6qV3p
    9GPJj3h12Q8jW1eLiEVZ9kThC1twxDHY7un/YeaDlWEZAQKQmN7ojT11RKuA81Vv
    g+LEx/sjVh19JtUeRbN8SrN18njB3InqbuiEil+xE63sNBfEWXk9JLNzwmIDzGJh
    TdLUc1Mvac1sanIIqQWO/6cLF/u8rkckABe1qg14Xobj2At3Q8zDqHnX+kThr4qu
    tp+OtA0mKmf2WIiXkqmbTxQzr4v29HJW6bwM5rQdVvzsyZk0ltfHokYdg4Bo+UfV
    T3OMnxJ0cikwaJE8FKTToNwFfydE3XxrpJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230504; bh=
    EcDOiG9R9UFJPKnOzR6VsnYAlhrNUJLf44LK5ZW/WPI=; b=gb0cxinhLEbAhZLX
    XCkN9NpO5tCcn0zRhyfUl/ZdFxAGc81TBQH1pomY4H+xIrEUyjdqoaKXTb1m4pUW
    1KlZIlxK+qLPI75HR8u6XCDun0iOcrDSShUb3DdUPMsb7Mu9ygmXz9gWSDSx8PTU
    f1EOkICIt3x3C5nblUpQ+0NX9UfkgG4igJD+9zLwW5wTc0diaaOXIc/YvndijaId
    97HQnFPMF+2Aurf3ooifWbxrOBGigjcLW5GkKHKdlpk6K24K9GsYAGcMojvb/qn0
    oZ0qbd0fdyeUXwEcSbz4QMfHkzIR8PH/unLKW1K5eMJI/oh9NL36Bhl7f4WCCnal
    HVGzrg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK63L8Xup7+mEwz6k1Sl0sMhaiBIM0aJBESgZSPSB+odGZBZa7iOR+EX3cgEJhLfy+dJoLTX3/Phkk/MUfYAYncxKs9FgJ9eHeFz/RENhymYFFVl56ZB
    BxfUOmpw0pPTzFq2i4zBFUwFfyknKAZxh4puAVKztCDKOWvsud2LPxmb1Pyvyfm+OrFVWOeVKPlm/3cVcCP8ReYSsV1goENw9PXUWUg/w50aB61mfBYakEII
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=xc2XTRMxS-wbUm1phvUA:9 a=IPxNYz59a0QIK62-:21
    a=iz4iQLsm0KqY_e1Y:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbeEBDIJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:08:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:63836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751308AbeEBDB6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:01:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058293"
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
Subject: [PATCH v5 07/28] fpga: dfl: add chardev support for feature devices
Date: Wed,  2 May 2018 10:50:10 +0800
Message-Id: <1525229431-3087-8-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For feature devices drivers, both the FPGA Management Engine (FME) and
Accelerated Function Unit (AFU) driver need to expose user interfaces via
the device file, for example, mmap and ioctls.

This patch adds chardev support in the dfl driver for feature devices,
FME and AFU. It reserves the chardev regions for FME and AFU, and provide
interfaces for FME and AFU driver to register their device file operations.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: rebased
v3: move chardev support to fpga-dfl framework
v4: rebase, and add more comments in code.
v5: rebase, and add dfl_ prefix to APIs and data structures.
---
 drivers/fpga/dfl.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/fpga/dfl.h |  14 ++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c1462e9..18aba02 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -74,6 +74,96 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
 	return DFL_ID_MAX;
 }
 
+struct dfl_chardev_info {
+	const char *name;
+	dev_t devt;
+};
+
+/* indexed by enum dfl_fpga_devt_type */
+struct dfl_chardev_info dfl_chrdevs[] = {
+	{.name = DFL_FPGA_FEATURE_DEV_FME},	/* DFL_FPGA_DEVT_FME */
+	{.name = DFL_FPGA_FEATURE_DEV_PORT},	/* DFL_FPGA_DEVT_AFU */
+};
+
+static void dfl_chardev_uinit(void)
+{
+	int i;
+
+	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++)
+		if (MAJOR(dfl_chrdevs[i].devt)) {
+			unregister_chrdev_region(dfl_chrdevs[i].devt,
+						 MINORMASK);
+			dfl_chrdevs[i].devt = MKDEV(0, 0);
+		}
+}
+
+static int dfl_chardev_init(void)
+{
+	int i, ret;
+
+	for (i = 0; i < DFL_FPGA_DEVT_MAX; i++) {
+		ret = alloc_chrdev_region(&dfl_chrdevs[i].devt, 0, MINORMASK,
+					  dfl_chrdevs[i].name);
+		if (ret)
+			goto exit;
+	}
+
+	return 0;
+
+exit:
+	dfl_chardev_uinit();
+	return ret;
+}
+
+static dev_t dfl_get_devt(enum dfl_fpga_devt_type type, int id)
+{
+	WARN_ON(type >= DFL_FPGA_DEVT_MAX);
+
+	return MKDEV(MAJOR(dfl_chrdevs[type].devt), id);
+}
+
+/**
+ * dfl_fpga_register_dev_ops - register cdev ops for feature dev
+ *
+ * @pdev: feature dev.
+ * @fops: file operations for feature dev's cdev.
+ * @owner: owning module/driver.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+int dfl_fpga_register_dev_ops(struct platform_device *pdev,
+			      const struct file_operations *fops,
+			      struct module *owner)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	cdev_init(&pdata->cdev, fops);
+	pdata->cdev.owner = owner;
+
+	/*
+	 * set parent to the feature device so that its refcount is
+	 * decreased after the last refcount of cdev is gone, that
+	 * makes sure the feature device is valid during device
+	 * file's life-cycle.
+	 */
+	pdata->cdev.kobj.parent = &pdev->dev.kobj;
+
+	return cdev_add(&pdata->cdev, pdev->dev.devt, 1);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_register_dev_ops);
+
+/**
+ * dfl_fpga_unregister_dev_ops - unregister cdev ops for feature dev
+ * @pdev: feature dev.
+ */
+void dfl_fpga_unregister_dev_ops(struct platform_device *pdev)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
+
+	cdev_del(&pdata->cdev);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_unregister_dev_ops);
+
 /**
  * struct build_feature_devs_info - info collected during feature dev build.
  *
@@ -208,9 +298,13 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		      enum dfl_id_type type, const char *name,
 		      void __iomem *ioaddr)
 {
+	enum dfl_fpga_devt_type devt_type = DFL_FPGA_DEVT_FME;
 	struct platform_device *fdev;
 	int ret;
 
+	if (type == PORT_ID)
+		devt_type = DFL_FPGA_DEVT_PORT;
+
 	/* we will create a new device, commit current device first */
 	ret = build_info_commit_dev(binfo);
 	if (ret)
@@ -234,6 +328,7 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
 		return fdev->id;
 
 	fdev->dev.parent = &binfo->cdev->region->dev;
+	fdev->dev.devt = dfl_get_devt(devt_type, fdev->id);
 
 	return 0;
 }
@@ -702,13 +797,20 @@ void dfl_fpga_remove_feature_devs(struct dfl_fpga_cdev *cdev)
 
 static int __init dfl_fpga_init(void)
 {
+	int ret;
+
 	dfl_ids_init();
 
-	return 0;
+	ret = dfl_chardev_init();
+	if (ret)
+		dfl_ids_destroy();
+
+	return ret;
 }
 
 static void __exit dfl_fpga_exit(void)
 {
+	dfl_chardev_uinit();
 	dfl_ids_destroy();
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 2ede915..5fcb1a1 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -15,6 +15,7 @@
 #define __FPGA_DFL_H
 
 #include <linux/bitfield.h>
+#include <linux/cdev.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/iopoll.h>
@@ -150,6 +151,7 @@ struct dfl_feature {
  *
  * @node: node to link feature devs to container device's port_dev_list.
  * @lock: mutex to protect platform data.
+ * @cdev: cdev of feature dev.
  * @dev: ptr to platform device linked with this platform data.
  * @dfl_cdev: ptr to container device.
  * @disable_count: count for port disable.
@@ -159,6 +161,7 @@ struct dfl_feature {
 struct dfl_feature_platform_data {
 	struct list_head node;
 	struct mutex lock;
+	struct cdev cdev;
 	struct platform_device *dev;
 	struct dfl_fpga_cdev *dfl_cdev;
 	unsigned int disable_count;
@@ -176,6 +179,17 @@ static inline int dfl_feature_platform_data_size(const int num)
 		num * sizeof(struct dfl_feature);
 }
 
+enum dfl_fpga_devt_type {
+	DFL_FPGA_DEVT_FME,
+	DFL_FPGA_DEVT_PORT,
+	DFL_FPGA_DEVT_MAX,
+};
+
+int dfl_fpga_register_dev_ops(struct platform_device *pdev,
+			      const struct file_operations *fops,
+			      struct module *owner);
+void dfl_fpga_unregister_dev_ops(struct platform_device *pdev);
+
 #define dfl_fpga_dev_for_each_feature(pdata, feature)			    \
 	for ((feature) = (pdata)->features;				    \
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
-- 
1.8.3.1

