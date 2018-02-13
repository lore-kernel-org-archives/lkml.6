Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518514715-2-12841608940625521588
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
    t=1518514714; b=aU/4ZYYN2TEvv02E/1nwGmd3ng9vKX0iF06Ex2zUuz2Kf1L
    Bz3twAN5clcDdP6o8aYlKu2E1ohBVMD328gcG6FLZsswW9oo1E2NL/Ig0k6X7BeO
    i5vtl3nxy9kY6pE91jfwwcA8hgtvlX2ljhKv6HHoWqfGXl2qaiXlvDA7Ipu/3edw
    UA4P55LiIeb1TC4DxHcY1k/Y4zEogY2sLoykd+wRySwAW/THWpFnPQosn9hSqOsU
    cPY1nBiTuIhydH8f7YcO4gck7qrfdJKYeene9BhP9tnJgd03jtvnt6itmr931J9P
    eIh4I9WKk4StRmlT1Ksx6YL3XLr6Y38IZbrgq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518514714;
    bh=/KqXROZwfncsDSQj04hWOqt1mbPy+mq2JnJa2M8gUe8=; b=h+ptFYFQKDtV
    Ej3OMqpvcyEYC1P0+W4qMgAass8PNwVkc8jC/mB7Brbf9SFFSE1X1Y1WUNpibjEv
    DPkNha8iJmMh+y0RyOyDtNzpA8jc8ftOfQEZ7IFNcqub/l9twngutpAlrbtu+Z4P
    Bb6oTQEfaV+IAQvRGEWPnfBle2u6rVwOsC37q9x0/M89KrCpSAbC7uMRY0WbjThV
    7tkw0HiOFHVAPXeYKCtZzdUBGpJwbTuNVJqKXYPIJLD+iB1aYYPvMCm2cookBIqt
    S8vwuGRng2x5HzbB7DNhPGOm0dqzpIhiuZjFBLytkIOd1kKthq/oEbG7w0VejaQ0
    KdT6cN2Z1A==
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
        id S934834AbeBMJgI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:36:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:27146 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934829AbeBMJgG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Feb 2018 04:36:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,507,1511856000";
   d="scan'208";a="26889658"
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
Subject: [PATCH v4 22/24] fpga: dfl: afu: add FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Date: Tue, 13 Feb 2018 17:24:51 +0800
Message-Id: <1518513893-4719-23-git-send-email-hao.wu@intel.com>
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
This patch implements above 2 ioctls in FPGA Accelerated Function Unit
(AFU) driver.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased
v3: rebased as driver renamed to fpga-dfl-afu
    fix one checkpatch issue
v4: add Acked-by from Alan and Moritz.
---
 drivers/fpga/dfl-afu-main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index b2f8798..bead242 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -121,6 +121,13 @@ static int afu_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static long afu_ioctl_check_extension(struct feature_platform_data *pdata,
+				      unsigned long arg)
+{
+	/* No extension support for now */
+	return 0;
+}
+
 static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct platform_device *pdev = filp->private_data;
@@ -131,6 +138,10 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
 	switch (cmd) {
+	case FPGA_GET_API_VERSION:
+		return FPGA_API_VERSION;
+	case FPGA_CHECK_EXTENSION:
+		return afu_ioctl_check_extension(pdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
-- 
2.7.4

