Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4163049-1525230436-2-1265743801319175638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525230436; b=b9R/zrjD2/k+51YfgQ6jlnP5D9BTGVRt0rWQmIvxnAYEiFC4eM
    SWT+5TD7ryuYr7UsVyU2x4xN1lrh9y7wOjWHUugd14gFzSntsic5HLpzuAbZiGtr
    +EniBhDqlyK0cwEZgmHNIXXbCaflLbzf1gBKmJiz/0zfX0wrNih0DVm0Qyee4R2C
    Db85fG0RAXIDdANG1l5/f/M4fajupEskM3AHfXkKWE3L/klXh/6/l4UjdcGRDGws
    lJnY707YGW5+E2a1tFxKLs7v+52BxohHsL7o0egzdQYKb90rnZ+NIqa5L4Z2e2qf
    FKf2bKTEce0lryOT6c+cEX7gWAaNtkX48PhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525230436; bh=
    GGPD8ybttkFOEGBkGT86LKMr6LkwjfdGgVjD67kW+Ls=; b=Iht6vJ9tEr/w77zC
    fwiA5ThuumxCSVArPAgVoDl4Ccf0wctCsGNtGZufr5Tl9dkyg/Wkzl4Amg3gUAh/
    SocFffX+g/HG6Pyljw5f7ravTbBBxUciJUmRGOmeToYT5aJRToApWwwV/LEN1kNl
    9bTRzFu+29pUza18H8H68mto+zH115d3N796bj+MVI5xvNzgqGWFZ+SQw9oWWiVs
    UYBkyOmQO85g4O6UWI2n3JHaePYAZo/VDoNsU9JHeguOOM81x/Q2YCmstZ+/d6Uv
    Sizl+3tb3j0zKIPRIljCzNdAZmGp0emG8aqVR3aTdbyANGkwUAnhsfa/UuB7Fhpj
    U3mufQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAy39OlZD5Oe5CvGBKFRImqSfiDFTGVgtTyWtywg52pIt63BvFxHuSzl5S9geLqThkarzHtW+PSXnkAW040aD5QGKEEf1cJTMZXFDwXW/AWbJtDkpqTy
    Oa+Z9g3vlBq3E/73e9KVp3lB6bPRlN6ifV0KvlVNwDXkQt/vDfEcAWN5uyb9oDPMJPnyPXn3iUgS6jRY1Q7YUblkRiuQ0M32mXwnPVS8myiw44PDleNLB/ur
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=gcutYzlcg2wRuFqeKlAA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeEBDHM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:07:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:63837 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751403AbeEBDCI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 May 2018 23:02:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400";
   d="scan'208";a="46058366"
From: Wu Hao <hao.wu@intel.com>
To: atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v5 11/28] fpga: dfl: add dfl_fpga_check_port_id function.
Date: Wed,  2 May 2018 10:50:14 +0800
Message-Id: <1525229431-3087-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
References: <1525229431-3087-1-git-send-email-hao.wu@intel.com>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds one common function in DFL framework. It uses
port_ops get_id callback to get port id and compare it with given
value. This function could be used as match function of the
dfl_fpga_cdev_find_port function.

Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl.c | 22 ++++++++++++++++++++++
 drivers/fpga/dfl.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b5a14a4..d47613c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -81,6 +81,28 @@ void dfl_fpga_del_port_ops(struct dfl_fpga_port_ops *ops)
 }
 EXPORT_SYMBOL_GPL(dfl_fpga_del_port_ops);
 
+/**
+ * dfl_fpga_check_port_id - check the port id
+ * @pdev: port platform device.
+ * @pport_id: port id to compare.
+ *
+ * Return: 1 if port device matches with given port id, otherwise 0.
+ */
+int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
+{
+	struct dfl_fpga_port_ops *port_ops = dfl_fpga_get_port_ops(pdev);
+	int port_id;
+
+	if (!port_ops || !port_ops->get_id)
+		return 0;
+
+	port_id = port_ops->get_id(pdev);
+	dfl_fpga_put_port_ops(port_ops);
+
+	return port_id == *(int *)pport_id;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
+
 static DEFINE_MUTEX(dfl_id_mutex);
 
 enum dfl_id_type {
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index c9d9a01..b0d9b2f 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -151,6 +151,7 @@ struct dfl_fpga_port_ops {
 void dfl_fpga_del_port_ops(struct dfl_fpga_port_ops *ops);
 struct dfl_fpga_port_ops *dfl_fpga_get_port_ops(struct platform_device *pdev);
 void dfl_fpga_put_port_ops(struct dfl_fpga_port_ops *ops);
+int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
 
 /**
  * struct dfl_feature_driver - sub feature's driver
-- 
1.8.3.1

