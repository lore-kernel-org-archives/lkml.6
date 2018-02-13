Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813382-1518515014-2-12538622621790586636
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
    t=1518515014; b=DaGE4yeDhsYMcfZ+phoplQnVq+GnlXf6zP53tsdNba6E2GL
    kPC1ATA7n8WZppsq+LCvc/QROXTxaeoQJAj8fudIPvvBGjWBu/yszmBnXyzulmXR
    BfVFRlOdyoSJM/n46BfuvsGcQ2mLZgtw/kgW08tiZZ3Ge4ZVsgyVzhIcyM8zR7Ny
    qx2WxNdTO+ItIG5LmkfyEUuUeS2KVy5Hv4+a3G+aoRlQddD1YLPK+bGspacgAPi5
    4NxiO/NBOVsdujl5ck3sPGOhNG3/U1nQ0zo6F2R0giz4AAacdoWNvNc4az0EoxFg
    5yWFfNkAQ/+Z+ef7dKedgRKERZHiaOW10SFUzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518515014;
    bh=gur1M3WmAOCsiUZZ2AkeBYoh/QGpnZtKWAAJRJvXg1U=; b=Bwq9vLZuj3p0
    7VRrNLqoqWiuKbZtFbCDTwCNLngMXxHp3Zk5YHAJn5Jri35wxSSEkaaxFWWcS7ex
    KA9J6T1WGj/vraE/9tSwl9LV+P9kSLybkzwy+fTfDi+kFjhd8YRpmJ8RF7cnZpME
    aYXlc5SHPIiGLw6wCKN93ziCO5bfAHmu85HOM1RK7hGO6DHtOsM+MuPSK+hSl0Ex
    d7sdcQl5iB/Plk/e5MwAcRAt1N/392hWd+WUMK42ankRKy6Uvv2zpK61EIwNdIa1
    XBHSJyvijM+ZsK1KxRPANJYNGc7ejHKFjdQU46LLbIPU0/IJCcQGHzXgnGoEGptP
    8BPmM7/I1w==
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
        id S934203AbeBMJnK (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:43:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:27123 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934692AbeBMJf2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:35:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889516"
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
Subject: [PATCH v4 06/24] fpga: dfl: adds fpga_cdev_find_port
Date: Tue, 13 Feb 2018 17:24:35 +0800
Message-Id: <1518513893-4719-7-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For feature devices, we need a method to find the port dedicated
to the device. This patch adds a function fpga_cdev_find_port
for this purpose. e.g FPGA Management Engine (FME) Partial
Reconfiguration sub feature, it uses this function to find
dedicated port on the device for PR function implementation.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v3: s/fpga_for_each_port/fpga_cdev_find_port/
    move fpga_cdev_find_port to fpga-dfl module.
v4: improve description in commit message.
    add comments to remind user to put_device after use this function.
---
 drivers/fpga/dfl.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 20 ++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index dcfe5ab..38dc819 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -783,6 +783,40 @@ void fpga_remove_feature_devs(struct fpga_cdev *cdev)
 }
 EXPORT_SYMBOL_GPL(fpga_remove_feature_devs);
 
+/**
+ * __fpga_cdev_find_port - find a port under given container device
+ *
+ * @cdev: container device
+ * @data: data passed to match function
+ * @match: match function used to find specific port from the port device list
+ *
+ * Find a port device under container device. This function needs to be
+ * invoked with lock held.
+ *
+ * This function returns NULL if the device doesn't match and non-zero if it
+ * does. If this function returns non-zero and a reference to the platform
+ * device of port can be obtained.
+ *
+ * NOTE: you will need to drop the device reference with put_device() after use.
+ */
+struct platform_device *
+__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
+		      int (*match)(struct platform_device *, void *))
+{
+	struct feature_platform_data *pdata;
+	struct platform_device *port_dev;
+
+	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
+		port_dev = pdata->dev;
+
+		if (match(port_dev, data) && get_device(&port_dev->dev))
+			return port_dev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(__fpga_cdev_find_port);
+
 int fpga_port_id(struct platform_device *pdev)
 {
 	void __iomem *base = get_feature_ioaddr_by_id(&pdev->dev,
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 9b19399..d6ecda1 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -356,4 +356,24 @@ struct fpga_cdev {
 struct fpga_cdev *fpga_enumerate_feature_devs(struct fpga_enum_info *info);
 void fpga_remove_feature_devs(struct fpga_cdev *cdev);
 
+/*
+ * need to drop the device reference with put_device() after use port platform
+ * device returned by __fpga_cdev_find_port and fpga_cdev_find_port functions.
+ */
+struct platform_device *
+__fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
+		      int (*match)(struct platform_device *, void *));
+
+static inline struct platform_device *
+fpga_cdev_find_port(struct fpga_cdev *cdev, void *data,
+		    int (*match)(struct platform_device *, void *))
+{
+	struct platform_device *pdev;
+
+	mutex_lock(&cdev->lock);
+	pdev = __fpga_cdev_find_port(cdev, data, match);
+	mutex_unlock(&cdev->lock);
+
+	return pdev;
+}
 #endif /* __FPGA_DFL_H */
-- 
2.7.4

